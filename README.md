# esp-dev-container

ESP container for development

```
npm i -g esp-dev-container
```

## Usage

```sh
esp-dev-container [--sudo] [--device <path>] [--persistent]
```

## Notes

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

## License

MIT
