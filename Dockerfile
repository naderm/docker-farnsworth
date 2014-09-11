FROM centos
MAINTAINER Nader Morshed <morshed.nader@gmail.com>

# EPEL required for pip and supervisor
RUN yum -y update
RUN yum install -y epel-release
RUN yum install -y postgresql-devel python-devel python-pip gcc mercurial git libffi-devel curl openssl openssl-devel supervisor mailcap cronie
RUN pip install uwsgi supervisor-stdout

# Clone Farnsworth
RUN mkdir -p /opt/apps
RUN git clone https://github.com/knagra/farnsworth.git /opt/apps/farnsworth
RUN pip install -r /opt/apps/farnsworth/requirements.txt

EXPOSE 80 443
CMD ["/usr/local/bin/run"]

RUN groupadd --system www-data
RUN useradd --gid www-data --system --shell /bin/false www-data

ADD dockerfiles/farnsworth.cron /etc/cron.d/farnsworth.cron
RUN chmod 644 /etc/cron.d/farnsworth.cron
ADD dockerfiles/supervisord.conf /opt/apps/supervisord.conf
ADD dockerfiles/run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
