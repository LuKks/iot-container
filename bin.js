#!/usr/bin/env node

// TODO: Device should be optional because it's not always connected

require('docker-bin')(__dirname, {
  cwd: true,
  device: '/dev/ttyUSB0'
})
