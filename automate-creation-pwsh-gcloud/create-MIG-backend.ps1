# Variables
$projectID = "multicloudstech-417802"
$region = "us-central1"
$zone = "us-central1-f"
$templateName = "mig-template-01"
$instanceGroupName = "multiclouds-mig-01"
$port = "80"
$protocol = "http"

gcloud config set compute/region $region
gcloud config set compute/zone $zone

# Set the project
gcloud config set project $projectID

# 0. Create Startup script for the Template: 
$startupScriptContent = @"
#! /bin/bash
apt-get update
apt-get install -y nginx
service nginx start
sed -i -- 's/nginx/Google Cloud Platform - \`$HOSTNAME/' /var/www/html/index.nginx-debian.html
"@

$startupScriptContent | Out-File -FilePath "startup.sh" -Encoding ASCII

# 1. Create an Instance Template
gcloud compute instance-templates create $templateName `
    --machine-type=e2-medium `
    --image-family=debian-11 `
    --image-project=debian-cloud `
    --tags=http-server `
    --metadata-from-file startup-script=startup.sh

# 2. Create a Managed Instance Group and named port
gcloud compute instance-groups managed create $instanceGroupName `
    --base-instance-name=instance `
    --template=$templateName `
    --size=2 `
    --zone=$zone
# 2.b Named Port 
gcloud compute instance-groups managed set-named-ports $instanceGroupName --named-ports "${protocol}:${port}" --zone $zone

Write-Host "Managed Instance Group backend configuration complete."
