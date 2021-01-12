FROM alpine:latest

COPY bin/ /usr/local/

# this sed command adds alpine edge repository
RUN sed -i 's/http\:\/\/alpine.gliderlabs.com/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories \
  && apk --no-cache --update add perl

CMD /usr/local/main.pl
