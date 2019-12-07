// Tiger Mou
// Mandelbrot Computation Unikernel
// Copyright 2019

#include <sstream>

#include <os>

#include <net/interfaces>
#include <timers>
#include <net/http/request.hpp>
#include <net/http/response.hpp>

#include <hal/machine.hpp>
#include <mandel.pb.h> // MUST COME LAST (OR AFTER 'net') OTHERWISE BUILD FAILS

using namespace std::chrono;

void start_http_service();

std::string handle_request(const std::string &data);

mandel::MandelResponse run_mandel_calc(const mandel::MandelRequest &mandReq);

uint32_t iterations_at_point(double x, double y, uint32_t max_iter);

std::string get_length_pad(const std::string &data);

struct my_device {
    int i = 0;
};

std::string HTML_RESPONSE() {
    // Generate some HTML
    std::stringstream stream;
    stream << "<!DOCTYPE html><html><head>"
           << "<link href='https://fonts.googleapis.com/css?family=Ubuntu:500,300'"
           << " rel='stylesheet' type='text/css'>"
           << "<title>IncludeOS Demo Service</title></head><body>"
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

    // Set up a TCP server on port 80
    auto &server = inet.tcp().listen(80);

    // Add a TCP connection handler - here a hardcoded HTTP-service
    server.on_connect([](net::tcp::Connection_ptr conn) {
        printf("<Service> @on_connect: Connection %s successfully established.\n",
               conn->remote().to_string().c_str());
        // read async with a buffer size of 2048 bytes
        // define what to do when data is read
        conn->on_read(2048, [conn](auto buf) {
            printf("<Service> @on_read: %lu bytes received.\n", buf->size());
            try {
                const std::string data((const char *) buf->data(), buf->size());

                // handle the request, get a MandelResponse buffer
                auto res = handle_request(data);

                // Send the MandelResponse string
                conn->write(res);

            } catch (const std::exception &e) {
                printf("<Service> Unable to parse request:\n%s\n", e.what());
                try {
                    conn->write(e.what());
                } catch (const std::exception &e) {
                    // Failed, whatever we tried.
                }
            }
        });
        conn->on_write([](size_t written) {
            printf("<Service> @on_write: %lu bytes written.\n", written);
        });
    });

    printf("*** Mandel service started ***\n");
}

std::string handle_request(const std::string &data) {
    std::string res;
    mandel::MandelRequest mandReq;
    mandel::MandelResponse mandRes;

    // If parse was successful, we can run the mandelbrot calculation. Otherwise send back default.
    if (mandReq.ParseFromString(data)) {
        mandRes = run_mandel_calc(mandReq);
    }
    // Write to string buffer
    mandRes.SerializeToString(&res);
    return get_length_pad(res) + res;
}

mandel::MandelResponse run_mandel_calc(const mandel::MandelRequest &mandReq) {
    // Copy over the ib.
    mandel::MandelResponse mandRes;
    mandRes.mutable_ib()->CopyFrom(mandReq.ib());

    // Computation vars
    double xRange = mandReq.cb().xmax() - mandReq.cb().xmin();
    double yRange = mandReq.cb().ymax() - mandReq.cb().ymin();

    // Iterate over the rows/cols of ib and append to mandRes Data
    for (uint32_t x = mandReq.ib().xmin(); x < mandReq.ib().xmax(); ++x) {
        for (uint32_t y = mandReq.ib().ymin(); y < mandReq.ib().ymax(); ++y) {

            double ptX = mandReq.cb().xmin() + ((double)x) * xRange / ((double) mandReq.view_width());
            double ptY = mandReq.cb().ymin() + ((double)y) * yRange / ((double) mandReq.view_height());
            uint32_t iters = iterations_at_point(ptX, ptY, mandReq.max_iter());

            // Add pixel to the response.
            mandel::MandelPixel *mp = mandRes.add_data();
            mp->set_num_iter(iters);
        }
    }
    return mandRes;
}

uint32_t iterations_at_point(double x, double y, uint32_t max_iter) {
    double x0 = x,
        y0 = y,
        x2 = x * x,
        y2 = y * y;
    uint32_t iter = 0;
    for (; (x2+y2 <= 4) && (iter < max_iter); ++iter) {
        double x_tmp = x2-y2+x0;
        y = 2.0*x*y+y0;
        x = x_tmp;
        x2 = x*x;
        y2 = y*y;
    }
    return iter;
}


/**
 * Creates a string (bytes) of 4 bytes to send over the message size.
 */
std::string get_length_pad(const std::string &data) {
    size_t pad_size = 4;
    unsigned char bytes[pad_size];
    uint32_t n = data.length();
    bytes[0] = (n >> 24) & 0xFF;
    bytes[1] = (n >> 16) & 0xFF;
    bytes[2] = (n >> 8) & 0xFF;
    bytes[3] = n & 0xFF;
    std::string num((char *) &bytes, pad_size);
    return num;
}