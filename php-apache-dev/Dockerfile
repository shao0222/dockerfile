FROM shao0222/php-apache:alpine-php5

ENV WEB_DOCUMENT_ROOT=/app \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.vm \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET="" \
    WEB_PHP_SOCKET=127.0.0.1:9000\
    WEB_NO_CACHE_PATTERN="\.(css|js|gif|png|jpg|svg|json|xml)$"

COPY conf/ /opt/docker/

RUN apk update && apk add graphviz vim\
    && apk add --virtual .build-deps gcc g++ make libffi-dev openssl-dev php5-dev php5-pear autoconf libmemcached-dev cyrus-sasl-dev \
    && wget -O /tmp/tideways.tgz https://github.com/tideways/php-xhprof-extension/archive/v4.1.6.tar.gz \
    && tar -xvzf /tmp/tideways.tgz -C /tmp \
    && cd /tmp/php-xhprof-extension-4.1.6 \
    && phpize && ./configure \
    && make && make install \
    && cd - \
    && pecl install xdebug-2.5.5 \
    && apk del .build-deps\
    && echo 'extension=tideways.so' > /etc/php5/conf.d/tideways.ini\
    && echo 'zend_extension=xdebug.so' > /etc/php5/conf.d/xdebug.ini\
    && echo "let &termencoding=&encoding" >> /etc/vim/vimrc\
    && echo "set fileencodings=utf-8,gb18030,gbk,gb2312,big5" >> /etc/vim/vimrc\
    && echo "set mouse-=a" >> /etc/vim/vimrc \
    && docker-service disable postfix ssh syslog \
    && /opt/docker/bin/bootstrap.sh \
    && docker-image-cleanup
