FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y libyaml-0-2 libyaml-dev git
RUN apt-get install -y python2.7-minimal python2.7-dev python-virtualenv python-pip
RUN apt-get install -y rbenv bundler
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build

COPY setup.sh /opt/setup.sh
RUN /opt/setup.sh

COPY test.sh /opt/test.sh
CMD ["/opt/test.sh"]
