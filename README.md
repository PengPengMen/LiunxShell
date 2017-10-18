# LiunxShell
这是我在Liunx环境上进行工作写的脚本

https://mozillazg.github.io/2014/06/hello-postgresql.html
条件：
Linux用户名:root
PostgreSQL用户：postgres
postgresql 版本查看：

查看所有数据库
postgres=# \l
文件目录结构

1:/mnt/pgdbshell 为脚本文件存放位置
2:/mnt/postgresqlbackup 为数据库备份文件存放位置
3:/mnt/postgresqllog 为备份数据库日志文件 
backup.log 为备份日志文件
rmbackup.log 为定期清除日志文件

编写PostgreSQL备份脚本 名为PG_backup.sh
然后运行
[root@localhost mnt]# chmod -R 777 pgdbshell/backup_pgdb.sh
上述脚本为手动输入数据库名称进行备份的脚本，如果想自动定时备份。需要将脚本中的menu方法进行修改。定义一个数据库变量的数组。进行上面的代码进行修改。
定时任务
每天午夜12:00 进行数据库备份
crontab -u postgres –e 0 23 * * * /mnt/pgdbshell/backup_pgdb.sh
