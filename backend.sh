log_file="/tmp/expense.log"
color="\e[33m"

echo -e "${color} Disable default version of nodejs \e[0m"
dnf module disable nodejs -y &>>$log_file
echo $?

echo -e "${color} Enable nodejs:18 as required \e[0m"
dnf module enable nodejs:18 -y &>>$log_file
echo $?

echo -e "${color} Installing nodejs nodejs \e[0m"
dnf install nodejs -y &>>$log_file
echo $?

echo -e "${color}) copying backend service file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

echo -e "${color} Add application user \e[0m"
useradd expense &>>$log_file
echo $?

echo -e "${color} Create application directory \e[0m"
mkdir /app &>>$log_file
echo $?

echo -e "${color} Delete old application content \e[0m"
rm -rf /app/* &>>$log_file
echo $?

echo -e "${color} Downloading application content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
echo $?

echo -e "${color} extracting application zip file into application directory\e[0m"
cd /app &>>$log_file
echo $?
unzip /tmp/backend.zip &>>$log_file
echo $?

echo -e "${color} Installing nodejs dependencies \e[0m"
npm install &>>$log_file
echo $?

echo -e "${color} Install mysql client to load schema \e[0m"
dnf install mysql -y &>>$log_file
echo $?

echo -e "${color} load schema and change default password \e[0m"
mysql -h mysql-dev.mrkole.tech -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?

echo -e "${color} Reload Daemon \e[0m"
systemctl daemon-reload &>>$log_file
echo $?

echo -e "${color} Enable and restart backend service \e[0m"
systemctl enable backend &>>$log_file
echo $?
systemctl restart backend &>>$log_file
echo $?

