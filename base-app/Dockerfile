FROM webdevops/base-app:alpine

ENV TZ=Asia/Shanghai

COPY conf/ /opt/docker/

RUN go-replace --mode=replace --regex -s '^\s*https?://.*?/'  -r "http://mirrors.aliyun.com/" -- /etc/apk/repositories \
    && apk-install tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && docker-run-bootstrap \
    && docker-service-disable-all \
    && docker-image-cleanup
