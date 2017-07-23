# Consul-Msi

A Windows installer for a 64-bit Consul agent. Provided configurations assume client mode only.

## Installing

Like all MSI's, this installer supports slient installations, for example:

```cmd
msiexec /i Consul.msi ADDLOCAL=Consul,Service,Dns,Firewall
```

Or use `msiexec /i Consul.msi` for an interactive insallation.

## Support Features

| Feature Name | Description
| ------------- |-------------
| Consul  | Install the Consul agent binary and add it to the system path. This option provides no configuration files by default.
| Service | Configure Consul to run as a service and configure defaults (e.g. data directory).  
| Dns | Configure to run as a local DNS server. Modifies Window's DNSCache service to play nice with Consul and listens on 127.0.0.1:53.
| Firewall | Open ports required for LAN gossip.
