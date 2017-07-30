Mulit php version supported  by TekinTian

This script is written using the shell, in order to quickly deploy `LEMP`/`LAMP`/`LNMP`/`LNMPA`(Linux, Nginx/Tengine/OpenResty, MySQL in a production environment/MariaDB/Percona, PHP), applicable to CentOS 5~7(including redhat), Debian 6~8, Ubuntu 12~16 of 32 and 64. 

Script properties:
- Continually updated
- Source compiler installation, most stable source is the latest version, and download from the official site
- Some security optimization
- Providing a plurality of database versions (MySQL-5.7, MySQL-5.6, MySQL-5.5, MariaDB-10.1, MariaDB-10.0, MariaDB-5.5, Percona-5.7, Percona-5.6, Percona-5.5, AliSQL-5.6)
- Providing multiple PHP versions (PHP-7.1, PHP-7.0, PHP-5.6, PHP-5.5, PHP-5.4, PHP-5.3)
- Provide Nginx, Tengine, OpenResty
- Providing a plurality of Apache version (Apache-2.4, Apache-2.2)
- According to their needs to install PHP Cache Accelerator provides ZendOPcache, xcache, apcu, eAccelerator. And php encryption and decryption tool ionCube, ZendGuardLoader
- Installation Pureftpd, phpMyAdmin according to their needs
- Install memcached, redis according to their needs
- Jemalloc optimize MySQL, Nginx
- Providing add a virtual host script, include Let's Encrypt SSL certificate
- Provide Nginx/Tengine/OpenResty, MySQL/MariaDB/Percona, PHP, Redis, Memcached, phpMyAdmin upgrade script
- Provide local backup and remote backup (rsync between servers) script
- Provided under HHVM install CentOS 6,7

## How to use

If your server system: CentOS/Redhat (Do not enter "//" and "// subsequent sentence)
```bash
yum -y install wget screen python git  // For CentOS / Redhat
git clone https://bitbucket.org/tekintian/lnmp.git  // Contains the source code
cd lnmp    // If you need to modify the directory (installation, data storage, Nginx logs), modify options.conf file
screen -S lnmp    // if network interruption, you can execute the command `screen -r lnmp` reconnect install window
./install.sh   // Do not sh install.sh or bash install.sh such execution
```
If your server system: Debian/Ubuntu (Do not enter "//" and "// subsequent sentence)
```bash
apt-get -y install wget screen python git  // For Debian / Ubuntu
git clone https://bitbucket.org/tekintian/lnmp.git   // Contains the source code
cd lnmp    // If you need to modify the directory (installation, data storage, Nginx logs), modify options.conf file
screen -S lnmp    // if network interruption, you can execute the command `screen -r lnmp` reconnect install window
./install.sh   // Do not sh install.sh or bash install.sh such execution
```
如果在选择PHP版本的时候不是选择的php5.6版本,则安装完成后需要修改相应的站点配置文件为自己所选择的PHP版本

## 多版本PHP安装
执行 install.sh完成后 在执行下面的命令安装其他的PHP工存版本[必须为 PHP-FPM模式]; 

```bash
./install_php.sh

```
安装完成后将 config目录下的 phpXX.conf 对应的PHP版本配置文件复制到 /usr/local/nginx/conf 目录



## How to add Extensions

```bash
cd ~/lnmp    // Must enter the directory execution under lnmp
./addons.sh    // Do not sh addons.sh or bash addons.sh such execution
```

## How to add a virtual host

```bash
cd ~/lnmp    // Must enter the directory execution under lnmp
./vhost.sh    // Do not sh vhost.sh or bash vhost.sh such execution
```

## How to delete a virtual host

```bash
cd ~/lnmp
./vhost.sh del
```

## How to add FTP virtual user 

```bash
cd ~/lnmp
./pureftpd_vhost.sh
```

## How to backup

```bash
cd ~/lnmp
./backup_setup.sh    // Backup parameters 
./backup.sh    // Perform the backup immediately 
crontab -l    // Can be added to scheduled tasks, such as automatic backups every day 1:00 
  0 1 * * * cd ~/lnmp;./backup.sh  > /dev/null 2>&1 &
```

## How to manage service

Nginx/Tengine/OpenResty:
```bash
service nginx {start|stop|status|restart|reload|configtest}
```
MySQL/MariaDB/Percona:
```bash
service mysqld {start|stop|restart|reload|status}
```
PHP: PHP VERSION: 53  54 55 56 70 71
```bash
service php56-fpm {start|stop|restart|reload|status}
```
HHVM:
```bash
service supervisord {start|stop|status|restart|reload}
```
Apache:
```bash
service httpd {start|restart|stop}
```
Pure-Ftpd:
```bash
service pureftpd {start|stop|restart|status}
```
Redis:
```bash
service redis-server {start|stop|status|restart|reload}
```
Memcached:
```bash
service memcached {start|stop|status|restart|reload}
```

## How to upgrade 

```bash
./upgrade.sh
```

## How to uninstall 

```bash
./uninstall.sh
```

## Installation

Follow the instructions in [Wiki Installation page](https://bitbucket.org/tekintian/lnmp/wiki/Installation)<br />

For feedback, questions, and to follow the progress of the project (Chinese): <br />
[lnmp最新源码一键安装脚本](https://bitbucket.org/tekintian/lnmp)<br />


在 nginx配置文件目录的 fastcgi.conf 文件中增加

# 防止跨站安全设置
fastcgi_param PHP_ADMIN_VALUE "open_basedir=$document_root/:/tmp/:/proc/";


# 放到主机配置文件中,防止指定的目录执行脚本文件
location ~* .*\/(download|upload|static|images)\/.*\.(php|php5|phps|asp|aspx|jsp)$ {
	deny all;
}

# webmin Install

---------------webmin---------------------
Using the Webmin APT repository
If you like to install and update Webmin via APT, edit the /etc/apt/sources.list file on your system and add the line :
```bash
deb http://download.webmin.com/download/repository sarge contrib
```
You should also fetch and install my GPG key with which the repository is signed, with the commands :

```bash
cd /root
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
apt-get update
apt-get install apt-transport-https
apt-get install webmin
```
All dependencies should be resolved automatically.

## webmin themes
http://theme.winfuture.it/bwtheme.wbt.gz

http://webmin-theme-stressfree.googlecode.com/files/theme-stressfree-2.10.tar.gz

http://cdn.turnkeylinux.org/files/attachments/theme-metal.tar

# 防火墙配置
保存IPTABLES配置信息
```bash
iptables-save > /root/iptables.rules
```
# 常用LINUX命令
如果要查看磁盘还剩多少空间。
```bash
df -h 
```
查看当前目录的空间占用情况
```bash
du -h  --max-depth=1
```
看上面使用了du --max-depth=1 -h的命令来查找磁盘的使用情况，因为后面没有跟路径，它就默认是当前的路径。这个命令的-h参数是为了方便你读懂每个文件的大小，如果没有这个参数显示的文件大小就没有k,M,G等。执行命令后，前面n-1行的是该目录下每个文件夹的大小。最后一行显示的是该目录总的大小。

# LINUX 硬盘挂载

硬盘分区与挂载

硬盘分区及挂载操作步骤：

1. 查看未挂载的硬盘（名称为/dev/xvdb）
```bash
fdisk -l 
```
Disk /dev/xvdb doesn't contain a valid partition table

2. 创建分区
```bash
fdisk /dev/xvdb

...

输入n

Command (m for help):n

输入p

Command action
e extended
p primary partition (1-4)
p

输入1

Partition number (1-4): 1

回车

First cylinder (1-2610, default 1): 
Using default value 1

回车

Last cylinder, +cylinders or +size{K,M,G} (1-2610, default 2610): 
Using default value 2610

输入w

Command (m for help): w
The partition table has been altered!

```

3. 格式化分区

# mkfs.ext3 /dev/xvdb1

4. 建立挂载目录

# mkdir /data

5. 挂载分区

# mount /dev/xvdb1 /data

6. 设置开机自动挂载

vi /etc/fstab

在vi中输入i进入INERT模式，将光标移至文件结尾处并回车，将下面的内容复制/粘贴，然后按Esc键，输入:x保存并退出

/dev/vdb1  /home  ext4  defaults  0 0

 mount /dev/vdb1 /home

7. 确认是否挂载成功

重启服务器

# reboot

查看硬盘分区

# df

/dev/xvdb1            20635700    176196  19411268   1% /data
