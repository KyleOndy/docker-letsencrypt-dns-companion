FROM alpine:latest
MAINTAINER Kyle Ondy <kyle@ondy.me>

ENV LEXICON_VERSION 2.1.8
ENV DEHYDRATED_VERSION 0.4.0

run apk add --update \
        bash \
        curl \
        git \
        openssl \
        py-pip \
        python

# Dehydrated
RUN git clone https://github.com/lukas2511/dehydrated.git /dehydrated
RUN cd /dehydrated && git checkout tags/v${DEHYDRATED_VERSION}

# Lexicon
# need to install boto3 explicitly. For some reason dns-lexicon[route53] doesn't seem to do it
RUN pip install dns-lexicon==${LEXICON_VERSION} dns-lexicon[route53] boto3
RUN git clone https://github.com/AnalogJ/lexicon.git /lexicon
RUN cd /lexicon && git checkout tags/v${LEXICON_VERSION}
RUN cp /lexicon/examples/dehydrated.default.sh /dehydrated/
RUN chmod +x /dehydrated/dehydrated.default.sh


ADD dns-certbot.sh /dns-certbot.sh
RUN chmod +x /dns-certbot.sh

ENTRYPOINT  [ "/dns-certbot.sh" ]
