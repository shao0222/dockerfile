if [[ -n "$PHP_ALLOW_WRITE_DIR" ]];then
    for d in $PHP_ALLOW_WRITE_DIR;do
        chown -R $APPLICATION_GID:$APPLICATION_UID "$d"
    done
fi
