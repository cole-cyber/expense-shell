log_file="/tmp/expense.log"

echo -e "\e[36m This command installed the webserver (nginx) \e[0m"
dnf install nginx -y &>>$log_file
echo $?

echo -e "\e[32m copying expense.conf file into the service file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?

echo -e "\e[35m removing the content of the installed nginx \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?

echo -e "\e[32m downloading the front end of app code from developer \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
echo $?

echo -e "\e[33m Extract downloaded content \e[0m"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
echo $?

echo -e "\e[32m enable and start the server/nginx \e[0m"
systemctl enable nginx &>>$log_file
echo $?
systemctl restart nginx &>>$log_file
echo $?

