#服务描述性的配置
[Unit]
Description=PHP-FPM (FastCGI Process Manager) i
Documentation=https://php-fpm.org/
After=network.target remote-fs.target nss-lookup.target
#服务关键配置
[Service]
Type=forking
#pid文件位置 
#要与nginx配置文件中的pid配置路径一致，这个很重要，否则会服务启动失败
PIDFile=/usr/local/var/run/php-fpm.pid
#启动
ExecStart=/usr/local/sbin/php-fpm -y /usr/local/etc/php-fpm.conf
#重启
ExecReload=$EXEC -s kill -USR2 $MAINPID
#关闭
ExecStop=/bin/kill -INT $MAINPID
PrivateTmp=true
[Install]
WantedBy=multi-user.target