# Latest Ubuntu LTS
FROM ubuntu:14.04
FROM ubuntu:14.04

RUN apt-get update && \
        apt-get install -y ca-certificates librados2 apache2-utils curl jq wget && \
        rm -rf /var/lib/apt/lists/*

COPY ./registry/registry /bin/registry
COPY ./registry/config-example.yml /etc/docker/registry/config.yml

VOLUME ["/var/lib/registry"]
EXPOSE 5000
#ENTRYPOINT ["/bin/registry"]
#CMD ["/etc/docker/registry/config.yml"]




#RUN apt-get update \
#&& apt-get install -y curl jq

ADD service.json            /service.json
ADD register-service.sh     /register-service.sh
ADD start.sh                /start.sh

ENV SERVICE_JSON            /service.json

#CMD /register-service.sh
CMD /start.sh
