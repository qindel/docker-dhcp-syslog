#!/bin/sh
mkdir -p /etc/rsyslog
cat /dev/null > /etc/rsyslog/00-remote.conf
[ -n "$UDPLOGHOST" ] && echo "*.* @$UDPLOGHOST" >> /etc/rsyslog/00-remote.conf
[ -n "$TCPLOGHOST" ] && echo "*.* @@$TCPLOGHOST" >> /etc/rsyslog/00-remote.conf
[ -n "$UDPLOGHOST" -o -n "$TCPLOGHOST" ] && /usr/sbin/rsyslogd -f /etc/rsyslog.conf
mkdir /var/run/dhcp
chown dhcp:dhcp /var/run/dhcp
chown -R dhcp:dhcp /var/lib/dhcp
exec /usr/sbin/dhcpd -f -user dhcp -group dhcp -cf /etc/dhcp/dhcpd.conf -pf /var/run/dhcp/dhcpd.pid

