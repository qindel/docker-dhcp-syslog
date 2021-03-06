FROM alpine:latest
EXPOSE 67/udp

ENV UDPLOGHOST=
ENV TCPLOGHOST=
# The rsyslog package for alpine has no omrelp support
#ENV RELPLOGHOST=

RUN apk --update add dhcp
RUN apk --update add rsyslog

RUN mkdir -m 0755 -p /var/spool/rsyslog &&  addgroup syslog && adduser -D -s /sbin/nologin -h /var/spool/rsyslog -G syslog syslog && chown -R syslog:syslog /var/spool/rsyslog 

# Mounts
# NOTE: Per Dockerfile manual -->
#	"if any build steps change the data within the volume
# 	 after it has been declared, those changes will be discarded."
VOLUME ["/var/spool/rsyslog"]
VOLUME ["/etc/rsyslog"]
VOLUME ["/etc/dhcp"]
VOLUME ["/var/lib/dhcp"]

COPY entrypoint.sh /
COPY rsyslog.conf /etc/rsyslog.conf

ENTRYPOINT ["/entrypoint.sh"]
