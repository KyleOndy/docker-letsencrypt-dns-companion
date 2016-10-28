FROM alpine:latest
MAINTAINER Kyle Ondy <kyle@ondy.me>

run apk add --update \
        bash \
        curl \
        git \
        openssl \
        py-pip \
        python

RUN cd / \
 && git clone https://github.com/lukas2511/dehydrated.git \
 # need to install boto3 explicitly. For some reason dns-lexicon[route53] doesn't seem to do it
 && pip install dns-lexicon dns-lexicon[route53] boto3

ADD https://raw.githubusercontent.com/AnalogJ/lexicon/master/examples/dehydrated.default.sh /dehydrated/
RUN chmod +x /dehydrated/dehydrated.default.sh
ADD dns-certbot.sh /dns-certbot.sh
RUN chmod +x /dns-certbot.sh

ENTRYPOINT  [ "/dns-certbot.sh" ]
