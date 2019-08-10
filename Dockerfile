FROM alpine:latest

LABEL maintainer "LJason <https://ljason.cn>"

RUN apk add -qq --no-cache git build-base openssl python libsodium \
	&& wget https://github.com/LJason77/shadowsocksr/archive/master.zip -O shadowsocksr.zip \
	&& unzip shadowsocksr.zip \
	&& mv shadowsocksr-master /shadowsocksr \
	&& wget https://github.com/jech/polipo/archive/master.zip -O polipo.zip \
	&& unzip polipo.zip \
	&& cd polipo-master \
	&& make \
	&& install polipo /usr/local/bin/ \
	&& cd .. \
	&& rm -rf polipo.zip polipo-master shadowsocksr.zip \
	&& mkdir -p /usr/share/polipo/www /var/cache/polipo \
	&& apk del --purge git build-base openssl \
	&& rm -rf /var/cache/apk/* \
	&& echo -e 'daemonise = true\nproxyAddress = "0.0.0.0"\nsocksParentProxy = "127.0.0.1:1080"\nsocksProxyType = socks5\nchunkHighMark = 50331648\nobjectHighMark = 16384\nserverMaxSlots = 64\nserverSlots = 16\nserverSlots1 = 32' > /polipo

EXPOSE 1080 8123

CMD polipo -c /polipo && python /shadowsocksr/shadowsocks/local.py -c /etc/shadowsocks.json start