# Variables
$projectID = "multicloudstech-417802"
$region = "us-central1"
$zone = "us-central1-f"
$healthCheckName = "http-basic-check"
$backendServiceName = "nginx-backend"
$urlMapName = "web-map-http"
$httpProxyName = "http-lb-proxy"
$forwardingRuleName = "http-content-rule"
$instanceGroupName = "multiclouds-mig-01"
$healthCheckName = "http-health-check"
$backendServiceName = "mb-backend-service"
$network = "default"
$portName = "http"
$port = "80"
$protocol = "HTTP"

gcloud config set compute/region $region
gcloud config set compute/zone $zone

# Set GCloud Project
gcloud config set project $projectID

# Create Health Check
gcloud compute health-checks create http $healthCheckName --port=80

# Create Backend Service
gcloud compute backend-services create $backendServiceName `
    --protocol=HTTP `
    --port-name=http `
    --health-checks=$healthCheckName `
    --global

# Add Backend to Backend Service
gcloud compute backend-services add-backend $backendServiceName `
    --instance-group=$instanceGroupName `
    --instance-group-zone=$zone `
    --global

# Create URL Map
gcloud compute url-maps create $urlMapName `
    --default-service $backendServiceName

# Create HTTP Proxy
gcloud compute target-http-proxies create $httpProxyName `
    --url-map=$urlMapName

# Create Forwarding Rule
gcloud compute forwarding-rules create $forwardingRuleName `
    --global `
    --target-http-proxy=$httpProxyName `
    --ports=80
    
# Create HTTP Firewall Rule
gcloud compute firewall-rules create allow-http --network=$network --allow=tcp:80 --target-tags=http-server

# Output the created resources
Write-Host "Created Health Check: $healthCheckName"
Write-Host "Created Backend Service: $backendServiceName"
Write-Host "Added Backend: $instanceGroupName to $backendServiceName"
Write-Host "Created URL Map: $urlMapName"
Write-Host "Created HTTP Proxy: $httpProxyName"
Write-Host "Created Forwarding Rule: $forwardingRuleName"
