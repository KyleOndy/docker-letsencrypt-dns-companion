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
RUN git clone https://github.com/lukas2511/dehydrated.git /srv/dehydrated
RUN cd /srv/dehydrated && git checkout tags/v${DEHYDRATED_VERSION}

# Lexicon
RUN git clone https://github.com/AnalogJ/lexicon.git /srv/lexicon
RUN cd /srv/lexicon && git checkout tags/v${LEXICON_VERSION}
RUN pip install /srv/lexicon[route53]
RUN cp /srv/lexicon/examples/dehydrated.default.sh /srv/dehydrated/
RUN chmod +x srv/dehydrated/dehydrated.default.sh


ADD dns-certbot.sh /dns-certbot.sh
RUN chmod +x /dns-certbot.sh

ENTRYPOINT  [ "/dns-certbot.sh" ]
