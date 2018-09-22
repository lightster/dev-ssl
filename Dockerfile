FROM alpine:3.8

RUN apk add --no-cache \
        bash openssl

COPY dev-ssl.sh /dev-ssl.sh

CMD ["/dev-ssl.sh"]
