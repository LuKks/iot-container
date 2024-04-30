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

For rootless, temporarily change the permission for the USB:

```sh
sudo chmod 666 /dev/ttyUSB0
```

Otherwise, use `--sudo`.

## License

MIT
