FROM nginx:1.23.3

RUN apt-get update && apt-get install -y make curl git

WORKDIR /usr/share/nginx/html

RUN curl -L -o hugo.deb https://github.com/gohugoio/hugo/releases/download/v0.123.3/hugo_extended_0.123.3_linux-amd64.deb

RUN dpkg -i  hugo.deb && rm hugo.deb

RUN git clone https://github.com/chazapis/hy548.git

RUN cd hy548 && git submodule init && git submodule update && make

RUN cp -R hy548/html/public/ /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
