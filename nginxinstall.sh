#! /bin/bash
##Date:2017-11-20
##Author:menpengpeng
######Nginx1.8.0一键安装脚本

####首先安装依赖包####
yum -y install gcc gcc-c++ autoconf automake make
yum -y install zlib zlib-devel openssl 
yum -y install openssl-devel pcre pcre-devel

###Ngixn安装
cd /usr/local/
wget http://nginx.org/download/nginx-1.8.0.tar.gz
tar -zxvf nginx-1.8.0.tar.gz
cd nginx-1.8.0
./configure --prefix=/usr/local/nginx
make
make install
echo "Nginx 安装完成"

###关闭防火墙或者开启80端口
systemctl stop firewalld.service
systemctl disable firewalld.service
echo "防火墙关闭成功"

###设置Nginx开机自动启动##
cd /lib/systemd/system
touch nginx.service
echo "
[Unit]  
Description=nginx  
After=network.target  
   
[Service]  
Type=forking  
ExecStart=/usr/local/nginx/sbin/nginx 
ExecReload=/usr/local/nginx/sbin/nginx -s reload  
ExecStop=/usr/local/nginx/sbin/nginx -s stop
PrivateTmp=true  
   
[Install]  
WantedBy=multi-user.target
" > nginx.service

systemctl enable nginx.service
echo "Nginx开机自动启动设置成功"

