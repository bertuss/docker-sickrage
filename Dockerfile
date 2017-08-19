FROM alpine:3.6
MAINTAINER Bertus Steenberg

ENV PORT 8081
ENV USERNAME username
ENV PASSWORD=
ENV PYTHONIOENCODING="UTF-8"
ENV DATADIR /data
ENV CONFIGFILE /config/config.ini

COPY config/config.ini /config/config.ini

RUN sed -i -e "s|web_username = \"\"|web_username = \"${USERNAME}\"|g" -e "s|web_password = \"password\"|web_username = \"${PASSWORD}\"|g" /config/config.ini

# install packages
RUN apk update && \
    apk add --no-cache \
        ca-certificates \
        python \
        wget \
        tar

RUN \
    wget --quiet https://github.com/SickRage/SickRage/archive/master.tar.gz && \
    mkdir -p /app/sickrage && \
    tar -C /app/sickrage --strip-components=1 -xzvf master.tar.gz 'SickRage-master' && \
    rm master.tar.gz

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod u+x  /usr/bin/entrypoint.sh

VOLUME ["/data", "/config"]

EXPOSE $PORT

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD python /app/sickrage/SickBeard.py \
    --nolaunch \
    --port ${PORT} \
    --datadir ${DATADIR} \
    --config ${CONFIGFILE}
