FROM centos:7

RUN yum update -y && \
    yum install -y httpd

# Apache自動起動
RUN systemctl enable httpd.service
    
RUN yum install -y epel-release
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum -y install --enablerepo=remi,epel,remi-php74 php php-mysqlnd php-mbstring php-gd php-xml php-xmlrpc php-pecl-mcrypt php-fpm php-opcache php-apcu php-pear php-pdo php-zip php-unzip php-pecl-zip phpMyAdmin

RUN yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm && \
    yum -y install mysql-community-server

# RUN yum -y install mod_ssl && \
    # yum -y install firewalld && \
    # yum -y install certbot python2-certbot-apache


RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer self-update 1.8.3

# RUN yum -y install git

# node.js 導入
RUN yum install -y https://rpm.nodesource.com/pub_12.x/el/7/x86_64/nodesource-release-el7-1.noarch.rpm
RUN yum install -y nodejs \
    yum install -y vim

# グローバル にgulpを導入
RUN npm install -g gulp

# ホストで用意した設定ファイルを反映
COPY ./copy/httpd.conf /etc/httpd/conf/httpd.conf
COPY ./copy/v_host.conf /etc/httpd/conf.d/v_host.conf
COPY ./copy/php.ini /etc/php.ini
COPY ./copy/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf

# ディレクトリの所有者、グループを変更する。
# RUN chown apache:apache /var/www/html/php_error.log


#公開ポート番号
EXPOSE 80