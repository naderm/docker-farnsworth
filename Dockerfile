FROM centos
MAINTAINER Nader Morshed <morshed.nader@gmail.com>

RUN yum -y update
RUN yum install -y httpd postgresql python python-devel python-virtualenv gcc mod_wsgi mercurial git libffi-devel

# Clone Farnsworth
RUN git clone -b kingman https://github.com/knagra/farnsworth.git /var/www/farnsworth
RUN pip install -r /var/www/farnsworth/bin/activate/requirements.txt
RUN chown -R apache:apache /var/www/farnsworth

ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 80

CMD ["/usr/local/bin/run"]

