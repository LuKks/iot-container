# iot-container

Espressif IDF container

```
npm i -g iot-container
```

## Usage

```sh
iot-container [--sudo] [--device <path>]
```

## Example

```sh
# This does cd into current working directory
iot-container --device /dev/ttyUSB0

idf.py create-project my_project
cd my_project

cat <<EOF > main/my_project.c
#include <stdio.h>
#include <freertos/FreeRTOS.h>
#include <freertos/task.h>

void app_main () {
  while (1) {
    printf("Hello World!\n");
    vTaskDelay(1000 / portTICK_PERIOD_MS);
  }
}
EOF

# Optional configs
# idf.py menuconfig

idf.py build

idf.py -p /dev/ttyUSB0 -b 921600 flash

idf.py -p /dev/ttyUSB0 monitor # CTRL-] to exit
```

## USB permission

For rootless, the permanent way is to only allow the logged-in user via ACL:

```sh
udev_rule='KERNEL=="ttyUSB[0-9]*", TAG+="udev-acl", TAG+="uaccess"'

echo "$udev_rule" | sudo tee /etc/udev/rules.d/60-extra-acl.rules
sudo udevadm control --reload-rules
sudo udevadm trigger
```

A temporal solution is to change the USB permission:

```sh
sudo chmod 660 /dev/ttyUSB0
```

Otherwise, use `--sudo`.

## Arduino

Strictly use those versions:

- ESP-IDF `5.1.4`
- Arduino-ESP32 `3.0.1`

```sh
iot-container --build-arg "ESP_IDF_VERSION=5.1.4"

idf.py create-project my_sketch
cd my_sketch

# Add the Arduino ESP32 component
git clone -b 3.0.1 --depth=1 https://github.com/espressif/arduino-esp32.git components/arduino-esp32

# Delete the default .c file because Arduino uses .cpp
rm main/my_sketch.c

# Change the CMakeLists.txt configuration
sed -i 's/SRCS "my_sketch.c"/SRCS "my_sketch.cpp"/' main/CMakeLists.txt

cat <<EOF > main/my_sketch.cpp
#include "Arduino.h"

void setup () {
  Serial.begin(115200);
}

void loop () {
  Serial.println("Hello world with Arduino API!");
  delay(1000);
}
EOF

# (or use the menuconfig)
cat <<EOF > sdkconfig.defaults
CONFIG_AUTOSTART_ARDUINO=y
CONFIG_FREERTOS_HZ=1000
EOF

idf.py build
# ...
```

## License

MIT
