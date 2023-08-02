FROM nginx:latest

COPY ./server/nginx.conf /etc/nginx/nginx.conf
COPY ./server/server.c server.c
COPY ./server/script.sh script.sh

RUN apt-get update && apt-get install -y \
    gcc \
    libfcgi-dev\
    spawn-fcgi\
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/*\
    && chmod +x script.sh\
    && gcc server.c -o server.out -lfcgi\
    && chmod 777 /var/cache/nginx/ /var/run/ server.out

    

USER nginx

EXPOSE 81

ENTRYPOINT ["./script.sh"]