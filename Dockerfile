FROM httpd:2.4
COPY ./public-html/ /usr/local/apache2/htdocs/
docker build -t my-apache2 .
docker run -dit --name my-running-app -p 8080:80 my-apache2
# FROM nginx:1.11.9-alpine

# for htpasswd command
# RUN apk add --no-cache --update \
      apache2-utils
# RUN rm -f /etc/nginx/conf.d/*

ENV SERVER_NAME example.com
ENV PORT 80
ENV CLIENT_MAX_BODY_SIZE 1m
ENV PROXY_READ_TIMEOUT 60s
ENV WORKER_PROCESSES auto

COPY files/run.sh /
COPY files/nginx.conf.tmpl /

# use SIGQUIT for graceful shutdown
# c.f. http://nginx.org/en/docs/control.html
STOPSIGNAL SIGQUIT

ENTRYPOINT ["/run.sh"]
