FROM shao0222/base-app:alpine

ENV EJABBERD_BRANCH=18.01

COPY conf/ /opt/docker/

RUN apk-install bash \
        bind-tools \
        ca-certificates \
        elixir \
        erlang-erts erlang-mnesia erlang-snmp erlang-ssl erlang-ssh \
        erlang-tools erlang-xmerl erlang-diameter erlang-eldap \
        erlang-syntax-tools erlang-eunit erlang-ic erlang-odbc erlang-os-mon \
        erlang-parsetools erlang-crypto erlang-hipe \
        erlang-runtime-tools erlang-reltool \
        imagemagick \
        inotify-tools \
        libgd \
        libwebp \
        openssl \
        yaml \
        php7 \
        php7-curl \
    && docker-image-cleanup
RUN apk-install -t .build-dep \
        automake \
        autoconf \
        build-base \
        dpkg \
        erlang-dev \
        git \
        gnupg \
        expat-dev \
        gd-dev \
        jpeg-dev \
        libpng-dev \
        libwebp-dev \
        openssl-dev \
        shadow \
        sqlite-dev \
        yaml-dev \
        wget \
        zlib-dev \
    && cd /tmp \
    && git clone https://github.com/processone/ejabberd.git \
        --branch $EJABBERD_BRANCH --single-branch --depth=1 \
    && cd ejabberd \
    && chmod +x ./autogen.sh \
    && ./autogen.sh \
    && ./configure --enable-all --disable-pam \
    && make && make install \
    && apk del -r --purge .build-dep \
    && docker-service enable ejabberd \
    && docker-run-bootstrap \
    && docker-image-cleanup
