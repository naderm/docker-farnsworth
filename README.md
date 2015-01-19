# docker-farnsworth

Docker repository for deploying [Farnsworth](https://github.com/knagra/farnsworth)

# Install Docker and Fig

Follow these instructions to install Docker and Fig on your system of choice:

- [Docker](http://docs.docker.com/installation/)
- [Fig](http://www.fig.sh/install.html)

# Deploy

Bring up your Farnsworth deployment using fig:

```
$ cp fig.yml.example fig.yml
$ $EDITOR fig.yml
$ cp settings/house_settings.py.example settings/house_settings.py
$ $EDITOR settings/house_settings.py
$ fig up -d
# Add initial content to the site
$ fig run web /opt/apps/farnsworth/farnsworth/pre_fill.py --managers --requests --workshift
```

(This may take a while as it needs to build the docker images the first time)

# Backups

Backups require the postgresql package, run them with the following command:

```
$ pg_dump -h localhost -U postgres docker | gzip > "backup-<house>-$(date +%F).db.gz"
```

You will need to enter the password used to create the database instance in fig.yml

Backups can be restored with the following command:

```
# Only bring up the database
$ fig up -d db
$ gunzip -c "backup-<house>-<date>.db.gz | psql -h localhost -U postgres docker
# Bring up the rest of the site
$ fig up -d
```

# HTTPS

To enable SSL, modify your fig.yml file to enable SSL and mount a volume containing the SSL keys:

```
web:
  ports:
    - "80:80"
    - "443:443"
...
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
$ sudo chcon -Rt svirt_sandbox_file_t settings keys pg_data
```
