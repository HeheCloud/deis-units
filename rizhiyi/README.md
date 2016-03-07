# Deis 日志易

日志易 for use in the [Deis@HeheCloud](http://hehecloud.com/) open source PaaS.


## Usage

Create etcd keys as follows, and set proper values for each key:

 - /hehe/services/rizhiyi/server
 - /hehe/services/rizhiyi/authkey
 - /hehe/services/rizhiyi/appname
 - /hehe/services/rizhiyi/tag

Use the `fleetctl` command load and start the unit service

```
$ fleetctl load deis-csphere.service && \
  fleetctl start deis-csphere.service
```

## Additional Resources

* [HeheCloud](http://hehecloud.com/)
* [Deis中文指南](http://deis.heheapp.com/)
