#!/bin/bash
#author:menpengpeng
#date:2017-10-17
menu(){
	echo "-------欢迎使用PostgreSQL数据库备份脚本---"
	echo "请输入需要备份的数据库名称:"
	read database_name
	#return $database_name
}
createdir()
{
backup_dir=/mnt/postgresqlbackup
backup_log=/mnt/postgresqllog
backup_logfile=/mnt/postgresqllog/backuppg.log
rmbackup_logfile=/mnt/postgresqllog/rmbackuppg.log
if [ ! -d "$backup_dir" ];then 
  mkdir $backup_dir $backup_log
  touch $backup_logfile $rmbackup_logfile
  date >> $backup_logfile
  echo "postgresqlbackup文件夹创建成功" >> $backup_logfile
  chown -R postgres postgresqlbackup/
  chown -R postgres postgresqllog/
else
  echo "文件夹已经存在"
fi
}
database_name=("test" "DataXTest")
#postgresql bakup
backuppgdb(){
	echo "数据库名:$1"
    #postgresql bakup
    #chmod -R 777 /mnt 
    #su postgres
    date_now=`date '+%Y-%m-%d %H:%M:%S'`
	/mnt/postgresql/pgsql/bin/pg_dump -U postgres $1 > /mnt/postgresqlbackup/$1-$date_now.out
	if [ $? = 0 ];then
    	echo "$date_now postgresql backup success:$1" >> /mnt/postgresqllog/backuppg.log
		echo "" >> /mnt/postgresqllog/backuppg.log
    else
    	echo "$date_now postgresql backup failed" >> /mnt/postgresqllog/backuppg.log
		echo "" >> /mnt/postgresqllog/backuppg.log
    fi

	#rm back file 
	find /mnt/postgresqlbackup -mtime +8 -exec rm -fr {} \;
	if [ $? = 0 ];then
          echo "$date_now rm postgresql backup success:$1" >> /mnt/postgresqllog/rmbackuppg.log
          echo "" >> /mnt/postgresqllog/rmbackuppg.log
    else
          echo "$date_now rm postgresql backup failed" >> /mnt/postgresqllog/rmbackuppg.log
          echo "" >> /mnt/postgresqllog/rmbackuppg.log
    fi

}
#menu
createdir
backuppgdb $database_name
