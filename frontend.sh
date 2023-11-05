log.file=/tmp/expense.log
color="\e[33m[0m"

echo -e "\e[36m This command installed the webserver (nginx) \e[0m"
dnf install nginx -y &>>log.file

echo -e "\e[32m copying expense.conf file into the service file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>log.file

echo -e "\e[35m removing the content of the installed nginx \e[0m"
rm -rf /usr/share/nginx/html/* &>>log.file

echo -e "\e[31m downloading the front end of app code from developer \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log.file

echo -e "\e[33m Extract downloaded content \e[0m"
cd /usr/share/nginx/html &>>log.file
unzip /tmp/frontend.zip &>>log.file

echo -e "\e[34m enable and start the server/nginx \e[0m"
systemctl enable nginx &>>log.file
systemctl restart nginx &>>log.file

