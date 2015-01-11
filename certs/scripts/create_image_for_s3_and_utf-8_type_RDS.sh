apt-get install ec2-api-tools
apt-get install ec2-ami-tools
export EC2_URL=https://us-west-1.ec2.amazonaws.com
export BUNDLE_NAME=fbloadbal25jan2012
export JAVA_HOME=/usr
ec2-bundle-vol -d /mnt -k /var/www/FacebookAppsHQ/certs/26oct/aws/pk-6E7Y7QZL4OUREXGYWKGWP572VNBARVBT.pem  --cert /var/www/FacebookAppsHQ/certs/26oct/aws/cert-6E7Y7QZL4OUREXGYWKGWP572VNBARVBT.pem  -u 5189-1792-6413
#ec2-migrate-manifest -k /var/www/FacebookAppsHQ/certs/26oct/aws/pk-6E7Y7QZL4OUREXGYWKGWP572VNBARVBT.pem  --cert /var/www/FacebookAppsHQ/certs/26oct/aws/cert-6E7Y7QZL4OUREXGYWKGWP572VNBARVBT.pem -m /mnt/image.manifest.xml  --region=us-west-1 -a 0P0MEP0BGQS7SS8D3ER2 -s aJ6eYoHviQuMuNsRxsRe2T6yia+ZQ6eamaLWbkN2
ec2-upload-bundle -b $BUNDLE_NAME -m /mnt/image.manifest.xml -a 0P0MEP0BGQS7SS8D3ER2 -s aJ6eYoHviQuMuNsRxsRe2T6yia+ZQ6eamaLWbkN2 --location us-west-1 --batch
ec2-register $BUNDLE_NAME/image.manifest.xml -K /var/www/FacebookAppsHQ/certs/26oct/aws/pk-6E7Y7QZL4OUREXGYWKGWP572VNBARVBT.pem -C /var/www/FacebookAppsHQ/certs/26oct/aws/cert-6E7Y7QZL4OUREXGYWKGWP572VNBARVBT.pem -U https://us-west-1.ec2.amazonaws.com

# set up of rds db parameters
# http://matthew.mceachen.us/blog/howto-configure-an-amazon-rds-instance-to-use-utf-8-925.html

# download RDS tools
cd
wget 'http://s3.amazonaws.com/rds-downloads/RDSCli.zip'
unzip RDSCli.zip

# set global env
export JAVA_HOME=/usr
export EC2_URL=https://us-west-1.ec2.amazonaws.com
export EC2_REGION=us-west-1
export AWS_RDS_HOME=/home/ubuntu/RDSCli-1.9.002
export EC2_PRIVATE_KEY=/var/www/facebookappshq/certs/26oct/aws/pk-6E7Y7QZL4OUREXGYWKGWP572VNBARVBT.pem
export EC2_CERT=/var/www/FacebookAppsHQ/certs/26oct/aws/cert-6E7Y7QZL4OUREXGYWKGWP572VNBARVBT.pem
export PATH=$AWS_RDS_HOME/bin:$PATH

# create paramater group -d=description, -f = DB engine type (i think), first one is group name
rds-create-db-parameter-group utf8 -f mysql5.5 -d utf8

rds-modify-db-parameter-group utf8 \
  --parameters="name=character_set_server, value=utf8, method=immediate" \
  --parameters="name=collation_server, value=utf8_general_ci, method=immediate"

# change forums to proper db name
rds-modify-db-instance forums --db-parameter-group-name utf8
rds-modify-db-instance emails --db-parameter-group-name utf8
rds-modify-db-instance socialreader --db-parameter-group-name utf8

# give it a reboot
rds-reboot-db-instance db1

