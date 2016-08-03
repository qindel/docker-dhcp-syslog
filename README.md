Docker container with dhcp and syslog forwarding
Based on Alpine with around 12MB

NOTE: Example assumes you have a "/dhcp" with your container specific data!
Change as needed with the SRC data that you are mounting into the container.
Example named data is defined in the example subdir.

## Required "DATA" directory:
This container assumes you have a "/dhcp" folder with your container specific data:
You can change that folder as needed, but make sure you update the "-v" mounts for run time

1.) [ *REQUIRED* ] In your /dhcp/etc/dhcp a file "smb.conf", which acts as an entry point to your config

2.) [ *REQUIRED* ] A "/dhcp/var/lib/dhcp" directory for the Dhcp database

3.) [ *OPTIONAL* ] set environment variable "UDPLOGHOST" or "TCPLOGHOST", if defined rsyslog will be started with remote SYSLOG logging to these hosts. If you use remote syslog, then it might be useful to set the hostname of the container depending on your server syslog configuration (the logs on the syslog server might get stored based on the hostname of the client)


## Run dhcp

```
docker run --name=dhcpserver --hostname=dhcpserver --rm -p 67:67/udp -e UDPLOGHOST=192.168.0.17  -v /dhcp/var/lib/dhcp:/var/lib/dhcp  -v /dhcp/etc/dhcp:/etc/dhcp qindel/dhcp-syslog
```