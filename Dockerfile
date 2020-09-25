#################
# Builder image #
#################

FROM alpine:3 AS builder

LABEL maintainer "Matt Knight <matt@adventurousway.com>"

RUN apk add --no-cache \
    build-base \
    cmake \
    git \
    librtlsdr-dev

ENV RTL_433_TAG HEAD

RUN git clone https://github.com/merbanan/rtl_433.git /tmp/rtl_433 \
  && cd /tmp/rtl_433 \
  && git checkout $RTL_433_TAG \
  && mkdir build \
  && cd build \
  && cmake .. \
  && make

##############
# Main image #
##############

FROM alpine:3

RUN apk add --no-cache rtl-sdr

COPY --from=builder /tmp/rtl_433/build/src/rtl_433 /usr/local/bin/rtl_433
COPY --from=builder /tmp/rtl_433/conf/*.conf /usr/local/etc/rtl_433/
COPY --from=builder /tmp/rtl_433/include/rtl_433*.h /usr/local/include/

ENTRYPOINT ["rtl_433"]

