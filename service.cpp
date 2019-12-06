// Tiger Mou
// Mandelbrot Computation Unikernel
// Copyright 2019

#include <cmath> // rand()
#include <sstream>

#include <os>

#include <net/interfaces>
#include <timers>
#include <net/http/request.hpp>
#include <net/http/response.hpp>

#include <hal/machine.hpp>
#include <mandel.pb.h> // TODO: Uncomment when building image, comment in CLion

using namespace std::chrono;

void start_http_service();

http::Response handle_request(const http::Request &req);

struct my_device {
    int i = 0;
};

std::string HTML_RESPONSE() {
    const int color = rand();

    // Generate some HTML
    std::stringstream stream;
    stream << "<!DOCTYPE html><html><head>"
           << "<link href='https://fonts.googleapis.com/css?family=Ubuntu:500,300'"
           << " rel='stylesheet' type='text/css'>"
           << "<title>IncludeOS Demo Service</title></head><body>"
           << "<h1 style='color: #" << std::hex << ((color >> 8) | 0x020202)
           << "; font-family: \"Arial\", sans-serif'>"
           << "Include<span style='font-weight: lighter'>OS</span></h1>"
           << "<h2>The C++ Unikernel</h2>"
           << "<p>You have successfully booted an IncludeOS TCP service with simple http. "
           << "For a more sophisticated example, take a look at "
           << "<a href='https://github.com/hioa-cs/IncludeOS/tree/master/examples/acorn'>Acorn</a>.</p>"
           << "<footer><hr/>&copy; 2017 IncludeOS </footer></body></html>";

    return stream.str();
}

void Service::start() {
    //---------------------------------------------------------------------------
    // Verify that the version of the library that we linked against is
    // compatible with the version of the headers we compiled against.
    //---------------------------------------------------------------------------
    GOOGLE_PROTOBUF_VERIFY_VERSION;

//    std::string data; //< Message buffer
//
//    //---------------------------------------------------------------------------
//    // Write message to a std::string
//    //---------------------------------------------------------------------------
//    Person person;
//    person.set_id(1234);
//    person.set_name("John Doe");
//    person.set_email("jdoe@example.com");
//    person.SerializeToString(&data);
//
//    //---------------------------------------------------------------------------
//    // Clear message information
//    //---------------------------------------------------------------------------
//    person.Clear();
//    assert(person.id() == 0);
//    assert(person.name() == "");
//    assert(person.email() == "");
//    print_person_info("Cleared message information:", person);
//
//    //---------------------------------------------------------------------------
//    // Read message from a std::string
//    //---------------------------------------------------------------------------
//    person.ParseFromString(data);
//    assert(person.id() == 1234);
//    assert(person.name() == "John Doe");
//    assert(person.email() == "jdoe@example.com");
//    print_person_info("Parsed message information:", person);
//
//    //---------------------------------------------------------------------------
//    // Print raw message
//    //---------------------------------------------------------------------------
//    std::cout << "Raw message:\n";
//    std::cout << data << '\n';

    start_http_service();

    //---------------------------------------------------------------------------
    // Optional:  Delete all global objects allocated by libprotobuf.
    //---------------------------------------------------------------------------
    google::protobuf::ShutdownProtobufLibrary();
}

/**
 * Starts the mandel http service
 */
void start_http_service() {
    printf("Service started\n");
    my_device dev1{42};
    auto dev = std::make_unique<my_device>(dev1);
    auto *stored_addr = dev.get();

    printf("Made device_ptr, adding to machine\n");
    auto dev_i = os::machine().add<my_device>(std::move(dev));
    auto &device = os::machine().get<my_device>(dev_i);
    Expects(device.i == 42);
    Expects(&device == stored_addr);
    Expects(dev.get() == nullptr);

    // Get the first IP stack
    // It should have configuration from config.json
    auto &inet = net::Interfaces::get(0);

    // Print some useful netstats every 30 secs
//    Timers::periodic(5s, 30s,
//                     [&inet](uint32_t) {
//                         printf("<Service> TCP STATUS:\n%s\n", inet.tcp().status().c_str());
//                     });

    // Set up a TCP server on port 80
    auto &server = inet.tcp().listen(80);

    // Add a TCP connection handler - here a hardcoded HTTP-service
    server.on_connect(
            [](net::tcp::Connection_ptr conn) {
                printf("<Service> @on_connect: Connection %s successfully established.\n",
                       conn->remote().to_string().c_str());
                // read async with a buffer size of 1024 bytes
                // define what to do when data is read
                conn->on_read(1024,
                              [conn](auto buf) {
                                  printf("<Service> @on_read: %lu bytes received.\n", buf->size());
                                  try {
                                      const std::string data((const char *) buf->data(), buf->size());
                                      // try to parse the request
                                      http::Request req{data};

                                      // handle the request, getting a matching response
                                      auto res = handle_request(req);

                                      printf("<Service> Responding with %u %s.\n",
                                             res.status_code(), http::code_description(res.status_code()).data());

                                      conn->write(res);
                                  }
                                  catch (const std::exception &e) {
                                      printf("<Service> Unable to parse request:\n%s\n", e.what());
                                  }
                              });
                conn->on_write([](size_t written) {
                    printf("<Service> @on_write: %lu bytes written.\n", written);
                });
            });

    printf("*** Basic demo service started ***\n");
}

http::Response handle_request(const http::Request &req) {
    printf("<Service> Request:\n%s\n", req.to_string().c_str());
    MandelParams params;
    std::string body(req.body().begin(), req.body().end()); //< Message buffer
    params.ParseFromString(body);
    http::Response res;

    auto &header = res.header();

    header.set_field(http::header::Server, "IncludeOS/0.10");

    // GET /
    if (req.method() == http::GET && req.uri().to_string() == "/") {
        // add HTML response
        std::string message = "IntRect "
                + std::to_string(params.ib().xmin())
                + " "
                + std::to_string(params.ib().xmax());
        res.add_body(message);

        // set Content type and length
        header.set_field(http::header::Content_Type, "text/html; charset=UTF-8");
        header.set_field(http::header::Content_Length, std::to_string(res.body().size()));
    } else {
        // Generate 404 response
        res.set_status_code(http::Not_Found);
    }

    header.set_field(http::header::Connection, "close");

    return res;
}