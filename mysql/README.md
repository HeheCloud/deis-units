# Deis MySQL

A MySQL database for use in the [Deis@HeheCloud](http://hehecloud.com/) open source PaaS.

This Docker image is based on the official
[mariadb:10.1](https://registry.hub.docker.com/_/mariadb/) image.

Please add any [issues](https://github.com/HeheCloud/deis-mysql/issues) you find with this software to the Project.

## Usage

Build

```
docker build -t hehecloud/mysql:10.1 .
```

Run

```
COREOS_PRIVATE_IPV4=<Host's IP address> && \
ROOT_PASS=`etcdctl get /hehe/services/mysql/rootPass` && \
  docker run --name deis-mysql --rm \
    -p $COREOS_PRIVATE_IPV4:3306:3306 \
    -e EXTERNAL_PORT=3306 \
    -e HOST=$COREOS_PRIVATE_IPV4 \
    -e MYSQL_ROOT_PASSWORD=$ROOT_PASS \
    -v /var/lib/deis/store/mysql:/var/lib/mysql \
    hehecloud/mysql:10.1
```

## Environment Variables

* **DEBUG** enables verbose output if set
* **ETCD_PORT** sets the TCP port on which to connect to the local etcd
  daemon (default: *4001*)
* **ETCD_PATH** sets the etcd directory where the database announces
  its configuration (default: */hehe/services/mysql*)
* **ETCD_TTL** sets the time-to-live before etcd purges a configuration
  value, in seconds (default: *20*)
* **HOST** Host's IP address
* **EXTERNAL_PORT** sets the TCP port on which the web server listens (default: *3306*)
* **MYSQL_ROOT_PASSWORD** sets the password for `root` user


## Additional Resources

* [HeheCloud](http://hehecloud.com/)
* [Deis中文指南](http://deis.heheapp.com/)
