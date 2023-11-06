log_file="/tmp/expense.log"
color="\e[33m"

echo -e "${color} Disable default version of nodejs \e[0m"
dnf module disable nodejs -y &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} Enable nodejs:18 as required \e[0m"
dnf module enable nodejs:18 -y &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} Installing nodejs nodejs \e[0m"
dnf install nodejs -y &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color}) copying backend service file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} Add application user \e[0m"
useradd expense &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} Create application directory \e[0m"
mkdir /app &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} Delete old application content \e[0m"
rm -rf /app/* &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} Downloading application content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} extracting application zip file into application directory\e[0m"
cd /app &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi
unzip /tmp/backend.zip &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} Installing nodejs dependencies \e[0m"
npm install &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} Install mysql client to load schema \e[0m"
dnf install mysql -y &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} load schema and change default password \e[0m"
mysql -h mysql-dev.mrkole.tech -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} Reload Daemon \e[0m"
systemctl daemon-reload &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

echo -e "${color} Enable and restart backend service \e[0m"
systemctl enable backend &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi
systemctl restart backend &>>$log_file
if [ $? -eq 0  ]; then
  echo -e "\e[32m Sucess \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
fi

