# docker-farnsworth

Docker repository for deploying [Farnsworth](https://github.com/knagra/farnsworth)

# Install Docker and Fig

Follow these instructions to install Docker and Fig on your system of choice:

- [Docker](http://docs.docker.com/installation/)
- [Fig](http://www.fig.sh/install.html)

Note that most commands below require access to root in order to communicate
with the Docker daemon. `sudo` has been added in front of commands whever
appropriate.

# Deploy

Bring up your Farnsworth deployment using fig:

```
$ cp fig.yml.example fig.yml
$ $EDITOR fig.yml
$ cp settings/house_settings.py.example settings/house_settings.py
$ $EDITOR settings/house_settings.py
$ sudo fig up -d
```

You can then add some initial content to the site via:

```
$ sudo fig run web /opt/apps/farnsworth/farnsworth/pre_fill.py --managers --requests --workshift
```

(This may take a while as it needs to build the docker images the first time)

## Updates

You can pull updates from the official Farnsworth repository without restarting
your container by running the following command:

```
$ sudo bin/update
```

## Backups

Backups require the postgresql package, run them with the following command:

```
$ sudo bin/backup "backup-<house>-$(date +%F).dump"
```

Backups can be restored with the following command:

```
$ sudo bin/restore "backup-<house>-<date>.dump"
```

# HTTPS

To enable SSL, modify your fig.yml file to enable SSL and mount a volume
containing the SSL keys:

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

Then create `keys/public.crt` and `keys/private.key` for your public and
private key respectively.

# SELinux

If your host machine is running CentOS or RHEL, or is otherwise running SELinux
you will need to give docker permission to read the folders containing the
settings and optionally the ssl keys.

```
$ sudo chcon -Rt svirt_sandbox_file_t settings keys pg_data
```
