log_file="/tmp/expense.log"
color="\e[33m"

echo -e "${color} Disable mysql default version \e[0m"
dnf module disable mysql -y &>>$log_file
if [ $? -eq 0 ]; then
echo -e "\e[32m Success \e[0m"
fi

echo -e "${color} copy mysql repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
if [ $? -eq 0 ]; then
echo -e "\e[32m Success \e[0m"
fi

echo -e "${color} Install mysql community server \e[0m"
dnf install mysql-community-server -y &>>$log_file
if [ $? -eq 0 ]; then
echo -e "\e[32m Success \e[0m"
fi

echo -e "${color} Enable and start msql server\e[0m"
systemctl enable mysqld &>>$log_file
if [ $? -eq 0 ]; then
echo -e "\e[32m Success \e[0m"
fi
systemctl start mysqld &>>$log_file
if [ $? -eq 0 ]; then
echo -e "\e[32m Success \e[0m"
fi

echo -e "${color} set password for root user \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
if [ $? -eq 0 ]; then
echo -e "\e[32m Success \e[0m"
fi