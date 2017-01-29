build_root=$(cd "$(dirname "$0")/.." && pwd)
cd $build_root

echo Installing: cpppo
pip install cpppo

echo Restoring submodules...
git submodule update --init --recursive

echo Buidling: azure-iot-sdk-python
./azure-iot-sdk-python/c/build_all/linux/setup.sh
./azure-iot-sdk-python/c/build_all/linux/build.sh
./azure-iot-sdk-python/build_all/linux/setup.sh
./azure-iot-sdk-python/build_all/linux/build.sh

echo Copying dependencies to client folder
cp azure-iot-sdk-python/device/samples/iothub_client.so client/iothub_client.so
cp azure-iot-sdk-python/device/samples/iothub_client.so client/iothub_client.so
cp azure-iot-sdk-python/device/samples/iothub_client_args.py client/iothub_client_args.py
cp azure-iot-sdk-python/device/samples/iothub_client_cert.py client/iothub_client_cert.py

echo Done!