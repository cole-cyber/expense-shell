source common.sh

MYSQL_ROOT_PASSWORD=$1

echo -e "${color} Disable mysql default version \e[0m"
dnf module disable mysql -y &>>$log_file
status_check

echo -e "${color} copy mysql repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
status_check

echo -e "${color} Install mysql community server \e[0m"
dnf install mysql-community-server -y &>>$log_file
status_check

echo -e "${color} Enable and start msql server\e[0m"
systemctl enable mysqld &>>$log_file
status_check
systemctl start mysqld &>>$log_file
status_check

echo -e "${color} set password for root user \e[0m"
mysql_secure_installation --set-root-pass ${MYSQL_ROOT_PASSWORD} &>>$log_file
status_check