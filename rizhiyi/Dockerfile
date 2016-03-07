FROM alpine:3.2
RUN apk add --update-cache \
    rsyslog \
    bash \
    curl \
    && rm -rf /var/cache/apk/*

# install etcdctl
RUN curl -sSL -o /usr/local/bin/etcdctl http://sinacloud.net/hehe/etcd/etcdctl-v0.4.9 \
    && chmod +x /usr/local/bin/etcdctl

# install confd
RUN curl -sSL -o /usr/local/bin/confd http://sinacloud.net/hehe/confd/confd-0.11.0-linux-amd64 \
    && chmod +x /usr/local/bin/confd

ADD . /app
RUN chmod +x /app/bin/boot
RUN chmod +x /app/bin/clean
RUN chmod +x /app/bin/reload
EXPOSE 514/udp
CMD ["/app/bin/boot"]

