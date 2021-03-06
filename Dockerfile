FROM alpine:3.5

ENV FRONTEND_UUID=c94f4e74-edf8-ecc9-0149-5ed25a75326b
ENV BACKEND_UUID=fa083a39-0472-6dce-33c3-d046a39567d8
ENV V2RAY_PORT=9199
ENV V2RAY_PATH=ray

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
 && mkdir /usr/bin/v2ray /etc/v2ray \
 && touch /etc/v2ray/config.json \
 && unzip /v2ray.zip -d /usr/bin/v2ray \
 && rm -rf /v2ray.zip /usr/bin/v2ray/*.sig /usr/bin/v2ray/doc /usr/bin/v2ray/*.json /usr/bin/v2ray/*.dat /usr/bin/v2ray/sys* \
 && chgrp -R 0 /etc/v2ray \
 && chmod -R g+rwX /etc/v2ray

ADD configure.sh /configure.sh
RUN chmod +x /configure.sh
ENTRYPOINT /configure.sh

EXPOSE 8188 ${V2RAY_PORT}
