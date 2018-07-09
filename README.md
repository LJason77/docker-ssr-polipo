# 科学上网容器 #

基于最新的 alpine 镜像，使用最后一版的 SSR 和 最新的 polipo。

## 端口流量类型 ##

|  类型  | 端口 |
| :----: | :--: |
| socks5 | 1080 |
|  http  | 8123 |

## 使用 ##

* 如需使用 socks5 类型的流量，则代理 `127.0.0.1:1080`
* 如需使用 http 类型的流量，则代理 `127.0.0.1:8123`

## 配置 ##

创建 json 文件，如： shadowsocks.json，写上自己的配置：

```json
{
	"server": "your.server",
	"server_port": 7777,
	"local_address": "0.0.0.0",
	"local_port": 1080,
	"password": "12345678",
	"timeout": 600,
	"udp_timeout": 90,
	"method": "aes-256-cfb",
	"protocol": "auth_aes128_md5",
	"protocol_param": "",
	"obfs": "http_simple",
	"obfs_param": "your.obfs_param",
	"fast_open": true,
	"workers": 1
}
```

**注意：** `local_address` 和 `local_port` 必须要是 **0.0.0.0** 和 **1080**。


## 安装 ##

### 方法一 ###

```bash
git clone https://github.com/LJason77/docker-ssr-polipo.git
cd docker-ssr-polipo
docker build -t docker-ssr-polipo .
```

### 方法二 ###

```bash
docker pull ljason/docker-ssr-polipo
```

## 运行 ##

```bash
# 方法一安装
docker run -d --restart always --name docker-ssr-polipo -v /your/path/shadowsocks.json:/etc/shadowsocks.json -p 1080:1080 -p 8123:8123 docker-ssr-polipo
# 方法二安装
docker run -d --restart always --name docker-ssr-polipo -v /your/path/shadowsocks.json:/etc/shadowsocks.json -p 1080:1080 -p 8123:8123 ljason/docker-ssr-polipo
```