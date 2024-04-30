#!/usr/bin/env node

const os = require('os')
const path = require('path')
const { execFileSync } = require('child_process')
const minimist = require('minimist')

const argv = minimist(process.argv.slice(2))

try {
  const imageId = exec('docker', [
    'build',
    argv.verbose ? null : '-q',
    path.join(__dirname)
  ]).toString().trim()

  exec('docker', [
    'run',
    argv.persistent ? null : '--rm',
    '-ti',
    '-v=' + process.cwd() + ':/mnt/cwd',
    argv.home ? ('-v=' + os.homedir() + ':/mnt/home') : null,
    argv.privileged ? '--privileged' : null,
    '--device', (argv.device || '/dev/ttyUSB0'),
    imageId
  ], { stdio: 'inherit' })
} catch (err) {
  process.exitCode = err.status || 1
}

function exec (cmd, args, opts) {
  if (argv.sudo) {
    args.unshift(cmd)
    cmd = 'sudo'
  }

  return execFileSync(cmd, args.filter(v => v), opts)
}
