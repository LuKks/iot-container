# esp-dev-container

ESP container for development

```
npm i -g esp-dev-container
```

## Usage

```sh
esp-dev-container [--sudo] [--device <path>] [--persistent]
```

## Example

```sh
esp-dev-container # This does cd into current working directory

idf.py create-project my_project
cd my_project

cat <<EOF > main/my_project.c
#include <stdio.h>
#include <freertos/FreeRTOS.h>
#include <freertos/task.h>

void app_main () {
  while (1) {
    printf("hello from module\n");
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
sudo chmod 666 /dev/ttyUSB0
```

Otherwise, use `--sudo`.

## Notes

```sh
espsecure.py generate_signing_key --version 2 --scheme ecdsa256 secure_boot_signing_key.pem
```

## License

MIT
