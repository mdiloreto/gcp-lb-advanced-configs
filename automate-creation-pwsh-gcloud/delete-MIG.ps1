# Variables
$projectID = "multicloudstech-417802"
$zone = "us-central1-f"
$instanceGroupName = "multiclouds-mig-01"
$templateName = "mig-template-01"

# Set GCloud Project
gcloud config set project $projectID

# Set the compute zone
gcloud config set compute/zone $zone

# Delete Managed Instance Group
gcloud compute instance-groups managed delete $instanceGroupName --zone=$zone -q

# Delete Instance Template
gcloud compute instance-templates delete $templateName -q

Write-Host "Managed Instance Group $instanceGroupName deleted."
