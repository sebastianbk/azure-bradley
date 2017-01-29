Project Azure-Bradley
=====================

This project uses the [Azure IoT Hub Device SDK for Python](https://github.com/Azure/azure-iot-sdk-python) and the [cpppo](https://github.com/pjkundert/cpppo) repository to connect an EtherNet/IP-capable device to an Azure IoT Hub. The project currently supports connecting to only one device per proces. Multiple tags from one device can be extracted at a user-defined interval and sent to the IoT Hub.

Cloning this project
--------------------

Since this project depends on the **azure-iot-sdk-python** submodule, you must clone the repository using the following command:

```
git clone --recursive https://github.com/sebastianbk/azure-bradley.git
```

Building (on Linux)
-------------------

Since *Project Azure-Bradley* depends on Azure IoT SDKs (for C and Python), you need [CMake] and [gcc] to compile the dependencies. [CMake] will create makefiles and [make] tool will use these makefiles to compile the C SDK source code using [gcc] compiler.

**Note:** This setup process requires **cmake** version **3.x** or higher and **gcc** version **4.9** or higher. 

For [CMake], verify the current version installed in your environment using the `cmake --version` command. For information about how to upgrade your version of cmake to 3.x on Ubuntu 14.04, see http://askubuntu.com/questions/610291/how-to-install-cmake-3-2-on-ubuntu-14-04.

For [gcc], verify the current version installed in your environment using the `gcc --version` command. For information about how to upgrade your version of gcc on Ubuntu 14.04, see http://askubuntu.com/questions/466651/how-do-i-use-the-latest-gcc-4-9-on-ubuntu-14-04.

Also, ensure that the desired Python version (2.7.x, 3.4 or 3.5.x) is installed and active. Run `python --version` or `python3 --version` at the command line to check the version. Moreover, the build script depends on `pip`. If you need to change this to `pip3`, you would have to do so in the `build/setup.sh` file. While this project should be working with newer versions of Python, it has only been tested with version 2.7.

Given that you have installed all the build tools, run the following commands from the root of the folder of the cloned repository:

```
cd build
chmod +x setup.sh
./setup.sh
```

To compile on Windows, please refer to [the Azure IoT team's guide](https://github.com/Azure/azure-iot-sdk-python/blob/master/doc/python-devbox-setup.md) on how to do so.

Configuring the client
----------------------

Before running the client you must provide some settings in the `config.json` file placed in the `client` folder. These settings include the IP address of the PLC, the names of the tags that you are interested in and the interval (in seconds) of the loop. The values of the tags are being read in a loop and the wait time between each loop is defined in the `interval` variable in the config file.

Here is an example of what the config file could look like:

```
{
    "plc-ipaddress": "192.168.1.21",
    "tags": ["FT101.Inp_PV", "LT101.Inp_PV", "VLV101.Inp_OpenLS", "VLV101.Inp_ClosedLS"],
    "interval": 1
}
```

Running the client
------------------

Once you have built the client and provided the correct settings in the config file, you can run the whole thing using this command from the `client` folder:

```
python azurebradley_client.py -c "AZURE-IOT-HUB-DEVICE-CONNSTRING"
```

You need to replace `AZURE-IOT-HUB-DEVICE-CONNSTRING` with your own connection string. See [this guide from ThingLabs](http://web.archive.org/web/20160710185640/http://thinglabs.io/setup-azure-iot-hub) to learn how to create an IoT Hub, create a device and find the connection string of the newly created device. Below is an example of the complete command with a fake connection string:

```
python azurebradley_client.py - c "HostName=youriothub.azure-devices.net;DeviceId=DemoDevice01;SharedAccessKey=YamIPc/t6qR5g2R99nG3RRjGcbRq2Cn36oMmXPGdfkw="
```

After running the command you should start to see some output in the terminal. Here is an example of what the output looks like:

```
Sent: {"FT101.Inp_PV": 53.65281295776367, "VLV101.Inp_ClosedLS": 0, "LT101.Inp_PV": 51.395912170410156, "VLV101.Inp_OpenLS": 255}
Confirmation[9] received for message with result = OK
    message_id: None
    correlation_id: None
    Properties: {}
    Total calls confirmed: 10
```

Note on the authorship
----------------------

This project has been developed as a hobby project by Per Thyme, Mads Laier and Sebastian Brandes. Neither Microsoft nor Rockwell Automation officially support this repository. So far this piece of software has only been used for demo purposes and implementing it in production is entirely at one's own risk.

Disclaimer
----------
THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.