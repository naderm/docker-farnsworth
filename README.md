# docker-farnsworth

Docker config file for [Farnsworth](https://github.com/knagra/farnsworth)

# Install Docker
## Debian

Install docker on debian with:

```
$ sudo apt-get install docker.io
```

## CentOS

Docker is available through [EPEL](https://fedoraproject.org/wiki/EPEL) on CentOS:

```
$ sudo yum install epel-release
$ sudo yum install docker-io
```

## OS X

[Follow these instructions on Docker's website to install the package on OS X](http://docs.docker.com/installation/mac/)

# Install Fig

Install fig with:

```
$ sudo pip install -U fig
```

# Deploy

Bring up your Farnsworth deployment using fig:

```
$ cp fig.yml.example fig.yml
$ $EDITOR fig.yml
$ cp settings/house_settings.py.example settings/house_settings.py
$ $EDITOR settings/house_settings.py
$ sudo fig up
```

(This may take a while as it needs to build the docker images the first time)

# Backups

Backups require the postgresql package, run them with the following command:

```
$ pg_dump -h localhost -U docker docker | gzip > "backup-<house>-$(date +%F).db.gz"
```

You will need to enter the password used to create the database instance in fig.yml

# HTTPS

To enable SSL, modify your fig.yml file to enable SSL and mount a volume containing the SSL keys:

```
web:
  environment:
    - ENABLE_SSL=yes
...
  volumes:
    - keys/:/opt/apps/keys
```

Then create `keys/public.crt` and `keys/private.key` for your public and private key respectively.

# SELinux

If your host machine is running CentOS or RHEL, or is otherwise running SELinux you will need to give docker permission to read the folders containing the settings and optionally the ssl keys.

```
$ sudo chcon -Rt svirt_sandbox_file_t settings
$ sudo chcon -Rt svirt_sandbox_file_t keys
```
