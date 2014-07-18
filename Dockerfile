FROM centos
MAINTAINER Nader Morshed <morshed.nader@gmail.com>

RUN yum -y update
RUN yum install -y httpd postgresql python python-devel gcc mod_wsgi mod_openssl mercurial git libffi-devel curl postgresql-devel openssl
RUN curl https://bootstrap.pypa.io/get-pip.py | python

# Clone Farnsworth
RUN git clone https://github.com/knagra/farnsworth.git /var/www/farnsworth
RUN pip install -r /var/www/farnsworth/requirements.txt

#ADD wsgi.conf /etc/httpd/conf.d/wsgi.conf
ADD ssl.conf /etc/httpd/conf.d/ssl.conf
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
ADD local_settings.py /var/www/farnsworth/farnsworth/local_settings.py

EXPOSE 80 443

CMD ["/usr/local/bin/run"]

