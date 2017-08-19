FROM alpine:3.6
MAINTAINER Bertus Steenberg

ENV PORT 8081
ENV USERNAME username
ENV PASSWORD=
ENV PYTHONIOENCODING="UTF-8"
ENV DATADIR /data
ENV CONFIGFILE /config/config.ini

COPY config/config.ini /config/config.ini

RUN sed -i -e "s|web_username = username|web_username = ${USERNAME}|g" -e "s|web_password = password|web_username = ${PASSWORD}|g" /config/config.ini

# install packages
RUN apk update && \
    apk add --no-cache \
        python \
        git

RUN git clone --depth=1 https://github.com/SickRage/SickRage.git /app/sickrage

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod u+x  /usr/bin/entrypoint.sh

VOLUME ["/data", "/config"]

EXPOSE $PORT

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD python /app/sickrage/SickBeard.py \
    --nolaunch \
    --port ${PORT} \
    --datadir ${DATADIR} \
    --config ${CONFIGFILE} \
    --pidfile /var/run/sickbeard.pid \
    --force-update
