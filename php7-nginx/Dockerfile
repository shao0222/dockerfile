FROM webdevops/php-nginx:alpine-php7

ENV TZ Asia/Shanghai

RUN VERSION=$(docker-image-info dist-version) && VERSION=${VERSION%.*} \
    && echo "http://mirrors.aliyun.com/alpine/v${VERSION}/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v${VERSION}/community" >> /etc/apk/repositories \
    && apk add --no-cache tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone
    
RUN set -x \
    && apk add --no-cache --virtual .build-deps gcc g++ make libffi-dev openssl-dev geoip-dev php7-dev php7-pear autoconf \
    && apk-install \
         php7-memcached \
    && pecl install yaf hprose \
    && echo -e "yes\nyes\nno\nyes" | pecl install swoole \
    && echo 'extension=yaf.so' > /etc/php7/conf.d/30_yaf.ini\
    && echo 'extension=hprose.so' > /etc/php7/conf.d/30_hprose.ini\
    && echo 'extension=swoole.so' > /etc/php7/conf.d/30_swoole.ini \
    && apk del .build-deps \
    && docker-image-cleanup