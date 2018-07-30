# Consul Agent Msi Package

[![Build status](https://img.shields.io/appveyor/ci/Silvenga/Consul-Msi.svg?maxAge=2592000&style=flat-square)](https://ci.appveyor.com/project/Silvenga/Consul-Msi)
[![License](https://img.shields.io/github/license/Silvenga/Consul-Msi.svg?style=flat-square)](https://github.com/Silvenga/Consul-Msi/blob/master/LICENSE)

> BREAKING CHANGE: Changed the service name from `consul-agent` to `consul` to match the standard Linux service name.

A Windows installer for a 64-bit Consul agent. Provided configurations assume client mode only.

## Downloading

Releases are built by Appveyor, linked above, the built installers can be downloaded from the [releases tab](https://github.com/Silvenga/Consul-Msi/releases).

## Installing

Like all MSI's, this installer supports slient installations, for example:

```cmd
msiexec /i Consul.msi ADDLOCAL=Consul,Service,Dns,Firewall /qn
```

Or use `msiexec /i Consul.msi` for an interactive insallation.

## Support Features

| Feature Name | Description
| ------------- |-------------
| Consul  | Install the Consul agent binary and add it to the system path. This option provides no configuration files by default.
| Service | Configure Consul to run as a service and configure defaults (e.g. data directory).  
| Dns | Configure Consul to run as a local DNS server. Modifies Window's DNSCache service to play nice with Consul and set's Consul to listen on `127.0.0.1:53`.
| Firewall | Confugure Window's Firewall to open ports required for LAN gossip.
