FROM webdevops/php-nginx:alpine-php7

ENV TZ Asia/Shanghai

COPY conf/ /opt/docker/

RUN go-replace --mode=replace --regex -s '^\s*https?://.*?/'  -r "http://mirrors.aliyun.com/" -- /etc/apk/repositories \
    && apk add --no-cache tzdata \
    && apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && apk add --no-cache --virtual .build-deps gcc g++ make libffi-dev openssl-dev geoip-dev php7-dev php7-pear autoconf \
    && apk-install php7-memcached \
    && pecl install yaf hprose \
    && echo -e "yes\nyes\nno\nyes" | pecl install swoole \
    && echo 'extension=yaf.so' > /etc/php7/conf.d/30_yaf.ini\
    && echo 'extension=hprose.so' > /etc/php7/conf.d/30_hprose.ini\
    && echo 'extension=swoole.so' > /etc/php7/conf.d/30_swoole.ini \
    && apk del .build-deps \
    && docker-run-bootstrap \
    && docker-service-disable-all \
    && docker-image-cleanup

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so
