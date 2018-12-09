FROM webdevops/base-app:alpine

ENV TZ=Asia/Shanghai

COPY conf/ /opt/docker/

RUN sed -r -i "s#dl-cdn.alpinelinux.org#mirrors.aliyun.com#g" /etc/apk/repositories \
    && apk-install tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && docker-run-bootstrap \
    && docker-service-disable-all \
    && docker-image-cleanup
