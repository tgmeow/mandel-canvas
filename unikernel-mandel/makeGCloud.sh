#! /bin/bash
cd build
source activate.sh
boot -b -g mandel_service
mv mandel_service.grub.img disk.raw
tar -zcf mandel_service.tar.gz disk.raw
cp mandel_service.tar.gz ~/sf_Shared
