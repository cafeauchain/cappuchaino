# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:0.10.1

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get -qq update
RUN apt-get -qq -y install wget python3.4 virtualenv supervisor
RUN mkdir -p /multichain /chaincreator
WORKDIR /multichain
ADD multichain.sh /multichain/multichain.sh
RUN /multichain/multichain.sh
WORKDIR /chaincreator
ADD ./chaincreator /chaincreator
RUN mkdir /chaincreator/logs
RUN virtualenv -p /usr/bin/python3 . && . bin/activate && pip install flask && python src/app.py
# ADD cappuchaino.conf /etc/supervisor/conf.d/cappuchaino.conf
# RUN /usr/bin/supervisord && /usr/bin/supervisorctl reload
# RUN /usr/bin/supervisorctl update stats && /usr/bin/supervisorctl start stats

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
