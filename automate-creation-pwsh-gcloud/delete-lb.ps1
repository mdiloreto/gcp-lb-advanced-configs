# Variables
$projectID = "multicloudstech-417802"
$region = "us-central1"
$healthCheckName = "http-health-check"
$backendServiceName = "mb-backend-service"
$urlMapName = "web-map-http"
$httpProxyName = "http-lb-proxy"
$forwardingRuleName = "http-content-rule"
$firewallRuleName = "allow-http"

# Set GCloud Project
gcloud config set project $projectID

# Set the compute region
gcloud config set compute/region $region

# Delete Forwarding Rule
gcloud compute forwarding-rules delete $forwardingRuleName --global -q

# Delete HTTP Proxy
gcloud compute target-http-proxies delete $httpProxyName -q

# Delete URL Map
gcloud compute url-maps delete $urlMapName -q

# Delete Backend Service
gcloud compute backend-services delete $backendServiceName --global -q

# Delete Health Check
gcloud compute health-checks delete $healthCheckName -q

# Delete HTTP Firewall Rule
gcloud compute firewall-rules delete $firewallRuleName -q

Write-Host "Load Balancer and all related components deleted."
