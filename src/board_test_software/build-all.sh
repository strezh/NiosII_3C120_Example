#!/bin/sh

pushd ddr2_ram_test/app
./create-this-app --cpu-name linux_cpu
popd

pushd general_io_test/app
./create-this-app --cpu-name linux_cpu
popd

pushd simple_socket_server/app
./create-this-app --cpu-name linux_cpu
popd
