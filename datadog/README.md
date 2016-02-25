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



## Additional Resources

* [HeheCloud](http://hehecloud.com/)
* [Deis中文指南](http://deis.heheapp.com/)
