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
 #&& mkdir -p /var/www/dehydrated \
 && git clone https://github.com/lukas2511/dehydrated.git \
 && pip install dns-lexicon dns-lexicon[route53] boto3
 # need to install boto3 explicitly. For some reason dns-lexicon[route53] doesn't seem to do it

ADD https://raw.githubusercontent.com/AnalogJ/lexicon/master/examples/dehydrated.default.sh /dehydrated/
RUN chmod +x /dehydrated/dehydrated.default.sh

ENTRYPOINT [ "/dehydrated/dehydrated" ]
CMD [ "" ]
