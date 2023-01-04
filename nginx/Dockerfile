FROM nginx:1.22.0

RUN rm -f /etc/nginx/conf.d/*

COPY /nginx/nginx.conf /etc/nginx/conf.d/myapp.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
