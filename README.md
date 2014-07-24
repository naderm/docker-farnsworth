# docker-farnsworth

Docker config file for [Farnsworth](https://github.com/knagra/farnsworth)

# Fig

Install fig with:

```
$ sudo pip install -U fig
```

Then bring up your Farnsworth deployment using fig:

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

Add keys... update fig

# SELinux

...

```
$ sudo chcon -Rt svirt_sandbox_file_t keys
$ sudo chcon -Rt svirt_sandbox_file_t settings
```
