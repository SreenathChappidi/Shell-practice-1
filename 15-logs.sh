#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "Script started executes at: $(date)"


if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script with root prevelage"
    exit 1 # failure is other than 0
fi

VALIDATE(){ # functions receive inputs through atgs just like shell script
    if [ $1 -ne 0 ]; then
       echo -e "Installing $2 ...$R FAILURE $N"
       exit 1
    else
    echo -e "Installing $2 ...$G  SUCCESS $N"
    fi 
}   

dnf list installed mysql &>>$LOGS_FILE
#Install if it is not found
if [ $? -ne 0 ]; then
    dnf install mysql -y &>>$LOGS_FILE
    VALIDATE $? "MYSQL"
else
    echo -e "MYSQL already exist ... $Y SKIPPING $N"
fi


dnf list installed nginx &>>$LOGS_FILE
if [ $? -ne 0 ]; then
    dnf install nginx -y &>>$LOGS_FILE
    VALIDATE $? "Nginx"
else
    echo -e "Nginx already exist ... $Y SKIPPING $N"
fi

dnf list installed Python &>>$LOGS_FILE
if [ $? -ne 0 ]; then
    dnf install python3 -y &>>$LOGS_FILE
    VALIDATE $? "python3"
else
    echo -e "Python3 already exist ... $Y SKIPPING $N"
fi



