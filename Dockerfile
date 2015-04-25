FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y python2.7-minimal python-virtualenv python-pip
RUN apt-get install -y python2.7-dev

RUN apt-get install -y rbenv ruby-build bundler

RUN apt-get install -y libyaml-0-2 libyaml-dev

COPY setup.sh /opt/setup.sh
RUN /opt/setup.sh

COPY test /work
WORKDIR /work
CMD ["./test.sh"]
