rm -f /opt/docker/etc/httpd/vhost.d/*.conf

if [[ -n "$WEB_EXTRA_VHOST" ]];then
    echo "$WEB_EXTRA_VHOST" | xargs -n 1| while read item;do
        domain=${item%:*}
        document_root=${item##*:}
        if [[ -n "$domain" && -n "$document_root" ]];then
            cat >> "/opt/docker/etc/httpd/vhost.d/10-autoadd-vhost.conf" <<EOF
<VirtualHost *:80>
  ServerName docker.vm
  ServerAlias ${domain}
  DocumentRoot "${document_root}"

  UseCanonicalName Off

  <IfVersion < 2.4>
    Include /opt/docker/etc/httpd/vhost.common.d/*.conf
  </IfVersion>
  <IfVersion >= 2.4>
    IncludeOptional /opt/docker/etc/httpd/vhost.common.d/*.conf
  </IfVersion>

</VirtualHost>

<VirtualHost *:443>
  ServerName docker.vm
  ServerAlias ${domain}
  DocumentRoot "${document_root}"

  UseCanonicalName Off

  <IfVersion < 2.4>
    Include /opt/docker/etc/httpd/vhost.common.d/*.conf
  </IfVersion>
  <IfVersion >= 2.4>
    IncludeOptional /opt/docker/etc/httpd/vhost.common.d/*.conf
  </IfVersion>

  Include /opt/docker/etc/httpd/vhost.ssl.conf
</VirtualHost>
EOF
        fi
    done
fi
