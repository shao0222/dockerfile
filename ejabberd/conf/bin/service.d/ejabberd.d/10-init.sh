find /opt/docker/etc/ejabberd/ -depth -maxdepth 1 | while read FILE; do
    ln -sf "$FILE" "/usr/local/etc/ejabberd/$(basename $FILE)"
done
