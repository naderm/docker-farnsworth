FROM centos
MAINTAINER Nader Morshed <morshed.nader@gmail.com>

RUN yum -y update
RUN wget wget http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm -O /root/epel-release-7-0.2.noarch.rpm
RUN yum install -y /root/epel-release-7-0.2.noarch.rpm
RUN yum install -y httpd postgresql python python-devel python-pip gcc mod_wsgi mercurial git libffi-devel

# Clone Farnsworth
RUN git clone -b kingman https://github.com/knagra/farnsworth.git /var/www/farnsworth
RUN pip install -r /var/www/farnsworth/bin/activate/requirements.txt
RUN chown -R apache:apache /var/www/farnsworth

ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 80

CMD ["/usr/local/bin/run"]

