FROM webdevops/php-apache-dev:alpine-php5

ENV TZ Asia/Shanghai

RUN echo 'http://mirrors.aliyun.com/alpine/v3.5/main' > /etc/apk/repositories \
    && echo 'http://mirrors.aliyun.com/alpine/v3.5/community' >> /etc/apk/repositories \
    && apk add --no-cache tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN apk add --no-cache php5-imap php5-phar libmemcached openssl\
    && apk add --no-cache --virtual .build-deps gcc g++ make libffi-dev openssl-dev php5-dev php5-pear autoconf libmemcached-dev cyrus-sasl-dev \
    && pecl install redis mongodb igbinary \
    && pecl install --onlyreqdeps --nobuild memcached-2.2.0 \
    && cd "$(pecl config-get temp_dir)/memcached" \
    && phpize \
    && ./configure --enable-memcached-igbinary \
    && make && make install \
    && cd - \
    && wget -O /tmp/tideways.tgz https://github.com/tideways/php-xhprof-extension/archive/v4.1.6.tar.gz \
    && tar -xvzf /tmp/tideways.tgz -C /tmp \
    && cd /tmp/php-xhprof-extension-4.1.6 \
    && phpize && ./configure \
    && make && make install \
    && cd - \
    && apk del .build-deps\
    && echo 'extension=memcached.so' > /etc/php5/conf.d/memcached.ini\
    && echo 'extension=redis.so' > /etc/php5/conf.d/redis.ini\
    && echo 'extension=mongodb.so' > /etc/php5/conf.d/mongodb.ini\
    && echo 'extension=igbinary.so' > /etc/php5/conf.d/igbinary.ini\
    && echo 'extension=tideways.so' > /etc/php5/conf.d/tideways.ini\
    && echo "let &termencoding=&encoding" >> /etc/vim/vimrc\
    && echo "set fileencodings=utf-8,gb18030,gbk,gb2312,big5" >> /etc/vim/vimrc\
    && docker-image-cleanup
