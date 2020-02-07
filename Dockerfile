FROM alpine:latest

LABEL maintainer "LJason <https://ljason.cn>"

RUN apk add --no-cache git build-base openssl python libsodium privoxy tzdata && \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	echo "Asia/Shanghai" > /etc/timezone && \
	git clone --depth=1 https://github.com/LJason77/shadowsocksr.git && \
	git clone --depth=1 https://github.com/jech/polipo.git && \
	cd polipo && make -j2 && \
	install polipo /usr/local/bin/ && \
	mkdir -p /usr/share/polipo/www /var/cache/polipo && \
	apk del -qq --purge git build-base openssl tzdata && \
	rm -rf /polipo && \
	echo -e 'daemonise = true\nproxyAddress = "0.0.0.0"\nsocksParentProxy = "127.0.0.1:1080"\nsocksProxyType = socks5\nchunkHighMark = 50331648\nobjectHighMark = 16384\nserverMaxSlots = 64\nserverSlots = 16\nserverSlots1 = 32' > /polipo

COPY files /etc/privoxy/

EXPOSE 1080 8118 8123

CMD polipo -c /polipo && privoxy /etc/privoxy/config && python /shadowsocksr/shadowsocks/local.py -c /etc/shadowsocks.json start