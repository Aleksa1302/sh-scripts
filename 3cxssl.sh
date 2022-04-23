
#!/bin/bash
# 3cxssl.sh
# 3cx certbot auto Certificate
clear
#Variables
comp=1
certbot=n
skip=y
status
#End Variables
#Functions

function stop(){
read -p "$*"
}
#strart of script
echo '####################################################'
echo '3CX Certbot automation script for debian! by eyecay'
echo '####################################################'
echo 'Hi we made this script to speed up our deployments please use it on your own risk. This script will run apt-get update && apt-get upgrade before proceding!'
stop 'Press [Enter] key to continue or ctrl+c to cancel!!!'
echo 'Do you want to skip info stops if you dont you will need to press enter after each? There is 14 stops we created to explain what script is doing'

read -p "Answer: Y/N " checkskip
echo 'Info Skip enabled: ' $checkskip

function pause(){
if [[ "$skip" = "$checkskip" ]]; then
    echo 'info skiped.'
else
  read -p "$*"
fi
}
echo 'Do you have Certbot-auto instaled? Y/N'

read -p "Answer: " CHCK

if [[ "$certbot" == "$CHCK" ]]; then

echo 'We will now do apt-get update && apt-get upgrade'
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
apt-get update && apt-get upgrade
echo 'We will instal apt-get install wget'
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
apt-get install wget
echo 'now we will download https://dl.eff.org/certbot-auto'
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
wget https://dl.eff.org/certbot-auto
echo 'we will enable permissions for Certbot-auto chmod a+x ./certbot-auto' 
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
chmod a+x ./certbot-auto
echo 'We installing it ./certbot-auto --install-only'
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
./certbot-auto --install-only

echo 'Please enter domain name? example pbx.mycorp.com'
read domain
echo 'Is this correct?'
echo $domain
stop 'Press [Enter] key to continue or ctrl+c to cancel!!!'

./certbot-auto -d $domain --manual --preferred-challenges dns certonly
echo 'removing old cerificate'
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
rm /var/lib/3cxpbx/Bin/nginx/conf/Instance1/$domain-crt.pem
rm /var/lib/3cxpbx/Bin/nginx/conf/Instance1/$domain-key.pem

echo 'copy new certificate'
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
cp /etc/letsencrypt/live/$domain/cert.pem  /var/lib/3cxpbx/Bin/nginx/conf/Instance1/$domain-crt.pem
cp /etc/letsencrypt/live/$domain/privkey.pem  /var/lib/3cxpbx/Bin/nginx/conf/Instance1/$domain-key.pem
echo 'restarting nginx'
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
systemctl stop nginx
systemctl start nginx
status=$((status+1))

else

echo 'We will check for updates'
echo 'We will  now do apt-get update && apt-get upgrade'
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
apt-get update && apt-get upgrade

echo Please enter domain name? examplepbx.mycorp.com
read domain
echo Is this correct?
echo $domain
stop 'Press [Enter] key to continue or ctrl+c to cancel!!!'
./certbot-auto -d $domain --manual --preferred-challenges dns certonly
echo 'removing old cerificate'
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
rm /var/lib/3cxpbx/Bin/nginx/conf/Instance1/$domain-crt.pem
rm /var/lib/3cxpbx/Bin/nginx/conf/Instance1/$domain-key.pem
echo 'copy new certificate'
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
cp /etc/letsencrypt/live/$domain/cert.pem  /var/lib/3cxpbx/Bin/nginx/conf/Instance1/$domain-crt.pem
cp /etc/letsencrypt/live/$domain/privkey.pem  /var/lib/3cxpbx/Bin/nginx/conf/Instance1/$domain-key.pem
echo 'restarting nginx'
pause 'Press [Enter] key to continue or ctrl+c to cancel!!!'
systemctl stop nginx
systemctl start nginx

status=$((status+1))
fi

clear
function complete(){
if [[ "$comp" == "$status" ]]; then
echo 'Operation Completed, We recomend that you reboot your server!'
else
echo 'Operation Faild'
fi
}

complete

#END


