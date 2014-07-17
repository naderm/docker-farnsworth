FROM centos
MAINTAINER Nader Morshed <morshed.nader@gmail.com>

RUN yum -y update
RUN yum install -y httpd postgresql python python-devel gcc mod_wsgi mercurial git libffi-devel curl postgresql-devel openssl
RUN curl https://bootstrap.pypa.io/get-pip.py | python

# Clone Farnsworth
RUN git clone -b kingman https://github.com/knagra/farnsworth.git /var/www/farnsworth
RUN pip install -r /var/www/farnsworth/requirements.txt
RUN chown -R apache:apache /var/www/farnsworth

ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 80

CMD ["/usr/local/bin/run"]

