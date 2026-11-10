FROM nginx:latest

WORKDIR /server

COPY ./server/main.c /server/main.c
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./run.sh /server/run.sh


RUN apt-get update && \
    apt-get install -y gcc libfcgi-dev spawn-fcgi && \
    rm -rf /var/lib/apt/lists/* && \
    chmod u-s,g-s /usr/bin/passwd /usr/bin/chfn /usr/bin/gpasswd /usr/bin/expiry \
                  /usr/bin/newgrp /usr/bin/umount /usr/bin/chsh /usr/bin/su \
                  /usr/bin/chage /usr/bin/mount /usr/sbin/unix_chkpwd && \
    useradd -d /home/nginx_user -m -s /bin/bash nginx_user && \
    chown -R nginx_user:nginx_user /server /etc/nginx /var/cache/nginx /var/run /run && \
    chmod +x /server/run.sh


USER nginx_user


HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost:81/ || exit 1

ENTRYPOINT ["bash", "/server/run.sh"]