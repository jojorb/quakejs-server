FROM ubuntu:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install sudo curl git nodejs npm jq apache2 wget apt-utils -y
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

# https://github.com/begleysm/quakejs.git
COPY ./quakejs/ /quakejs
COPY ./server_conf/server.cfg /quakejs/base/baseq3/server.cfg
COPY ./server_conf/server.cfg /quakejs/base/cpma/server.cfg


# The two following lines are not necessary because we copy assets from include.  Leaving them here for continuity.
# WORKDIR /var/www/html
# RUN bash /var/www/html/get_assets.sh
COPY ./fixes/ioq3ded.fixed.js /quakejs/build/ioq3ded.js

RUN rm /var/www/html/index.html && cp /quakejs/html/* /var/www/html/
COPY ./updates/ /var/www/html/assets

WORKDIR /quakejs
RUN npm install
# RUN echo "127.0.0.1 content.quakejs.com" >> /etc/hosts

WORKDIR /
ADD entrypoint.sh /entrypoint.sh
# Was having issues with Linux and Windows compatibility with chmod -x, but this seems to work in both
RUN chmod 777 ./entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
