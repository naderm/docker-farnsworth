# docker-farnsworth

Docker config file for [Farnsworth](https://github.com/knagra/farnsworth)

Requires separate docker instances for [PostgreSQL database](https://registry.hub.docker.com/u/morshed/postgresql) and [ElasticSearch](https://registry.hub.docker.com/u/dockerfile/elasticsearch)

```
$ docker run -d -p 9200:9200 \
  --name elasticsearch \
  dockerfile/elasticsearch
$ docker run -d -p 5432:5432 \
  -e POSTGRESQL_USER=kingman_admin \
  -e POSTGRESQL_PASS=... \
  -e POSTGRESQL_DB=kingman \
  --name db \
  morshed/postgresql
$ docker run -d -p 80:80 \
  -e POSTGRESQL_PASS=... \
  -e HOUSE_NAME="Kingman Hall" \
  -e SHORT_HOUSE_NAME="Kingman" \
  -e HOUSE_ABBREV="kng" \
  -e HOSTNAME="kingmanhall.org" \
  --link db:db \
  --link elasticsearch:elasticsearch \
  --name web \
  morshed/farnsworth
```

