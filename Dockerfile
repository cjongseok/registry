FROM registry:2

RUN apt-get update \
    && apt-get install -y curl jq

ADD consul-registration.json /consul-registration.json
ADD register-service.sh /register-service.sh

CMD /register-service.sh
