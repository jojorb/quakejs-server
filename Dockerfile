FROM ubuntu:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install sudo curl git nodejs npm jq apache2 wget apt-utils -y
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

# https://github.com/begleysm/quakejs.git
COPY ./quakejs/ /quakejs
COPY ./quakejs_fixes/ioq3ded.js /quakejs/build/ioq3ded.js

COPY ./config/server/server.cfg /quakejs/base/baseq3/server.cfg
COPY ./config/server/cpma-ca.cfg /quakejs/base/cpma/server.cfg

RUN rm /var/www/html/index.html && cp /quakejs/html/* /var/www/html/
COPY ./updates/ /var/www/html/assets
COPY ./updates/baseq3/517367614-ospmaps0.pk3 /quakejs/base/baseq3/ospmaps0.pk3
COPY ./updates/baseq3/3521216606-q3wpak1.pk3 /quakejs/base/baseq3/q3wpak1.pk3

WORKDIR /quakejs
RUN npm install
# RUN echo "127.0.0.1 content.quakejs.com" >> /etc/hosts

WORKDIR /
ADD entrypoint.sh /entrypoint.sh
# Was having issues with Linux and Windows compatibility with chmod -x, but this seems to work in both
RUN chmod 777 ./entrypoint.sh

#RUN ls /quakejs/base/baseq3/
#RUN rm /quakejs/base/baseq3/pak0.pk3
#COPY ./quakejs_fixes/pak0.pk3 /quakejs/base/baseq3/pak0.pk3
ENTRYPOINT ["/entrypoint.sh"]
