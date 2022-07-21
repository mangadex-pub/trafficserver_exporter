FROM debian:bullseye
LABEL maintainer="MangaDex Opensource <opensource@mangadex.org>"

RUN apt -q update && \
    apt -qq -y full-upgrade && \
    apt -qq -y autoremove && \
    apt -qq -y --no-install-recommends install curl ca-certificates dnsutils python3 python3-pip && \
    apt -qq -y --purge autoremove && \
    apt -qq -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/* /var/log/*

WORKDIR /build
COPY setup.py .
COPY trafficserver_exporter ./trafficserver_exporter
RUN python3 setup.py install && cd / && rm -rfv /build

RUN groupadd -r -g 999 mangadex && useradd -u 999 -r -g 999 mangadex

USER mangadex
WORKDIR /tmp

COPY docker-entrypoint.sh /docker-entrypoint.sh
CMD ["/docker-entrypoint.sh"]
