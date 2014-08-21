FROM centos
MAINTAINER Nader Morshed <morshed.nader@gmail.com>

# EPEL required for pip and supervisor
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm
RUN yum -y update
RUN yum install -y postgresql-devel python-devel python-pip gcc mercurial git libffi-devel curl openssl openssl-devel supervisor mailcap
RUN pip install uwsgi supervisor-stdout

# Clone Farnsworth
RUN mkdir -p /opt/apps
RUN git clone https://github.com/knagra/farnsworth.git /opt/apps/farnsworth
RUN pip install -r /opt/apps/farnsworth/requirements.txt
RUN pip install git+git://github.com/django/django.git@1.7c3

EXPOSE 80 443
CMD ["/usr/local/bin/run"]

RUN groupadd --system www-data
RUN useradd --gid www-data --system --shell /bin/false www-data

RUN yum install -y cronie
ADD dockerfiles/farnsworth.cron /etc/cron.d/farnsworth.cron
RUN chmod 600 /etc/cron.d/farnsworth.cron
#ADD settings/house_settings.py /opt/apps/farnsworth/farnsworth/house_settings.py
#ADD settings/local_settings.py /opt/apps/farnsworth/farnsworth/local_settings.py
#ADD keys /opt/apps/keys
ADD dockerfiles/supervisord.conf /opt/apps/supervisord.conf
ADD dockerfiles/run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
