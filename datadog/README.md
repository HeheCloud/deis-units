# Deis Datadog

Datadog for use in the [Deis@HeheCloud](http://hehecloud.com/) open source PaaS.


## Usage

Pull && Push

```
DEIS_RELEASE=v1.12.2
docker pull datadog/docker-dd-agent:latest && \
docker tag -f datadog/docker-dd-agent:latest localhost:5000/deis/dd-agent:${DEIS_RELEASE} && \
docker push localhost:5000/deis/dd-agent:${DEIS_RELEASE}
```

## Environment Variables

* **DEBUG** enables verbose output if set
* **ETCD_PORT** sets the TCP port on which to connect to the local etcd
  daemon (default: *4001*)
* **ETCD_PATH** sets the etcd directory where the database announces
  its configuration (default: */deis/database*)
* **ETCD_PATH** sets the etcd directory where the phppgadmin announces
  its configuration (default: */deis/phppgadmin*)
* **ETCD_TTL** sets the time-to-live before etcd purges a configuration
  value, in seconds (default: *10*)
* **HOST** Host's IP address
* **EXTERNAL_PORT** sets the TCP port on which the web server listens (default: *10801*)


## Additional Resources

* [HeheCloud](http://hehecloud.com/)
* [Deis中文指南](http://deis.heheapp.com/)
