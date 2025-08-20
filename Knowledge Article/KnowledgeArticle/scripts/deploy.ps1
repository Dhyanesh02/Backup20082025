# Salesforce DX Deployment Script for Voice Call Knowledge Articles Component
# This script deploys the Apex class and LWC component to your Salesforce org

param(
    [Parameter(Mandatory=$true)]
    [string]$OrgAlias,
    
    [Parameter(Mandatory=$false)]
    [string]$SourcePath = "force-app/main/default"
)

Write-Host "Starting deployment to org: $OrgAlias" -ForegroundColor Green

# Check if SFDX CLI is installed
try {
    $sfdxVersion = sfdx --version
    Write-Host "SFDX CLI Version: $sfdxVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: SFDX CLI is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Salesforce CLI from: https://developer.salesforce.com/tools/sfdxcli" -ForegroundColor Yellow
    exit 1
}

# Validate org connection
Write-Host "Validating org connection..." -ForegroundColor Yellow
try {
    sfdx force:org:display --targetusername $OrgAlias
} catch {
    Write-Host "Error: Cannot connect to org $OrgAlias" -ForegroundColor Red
    Write-Host "Please ensure the org alias is correct and you have proper authentication" -ForegroundColor Yellow
    exit 1
}

# Deploy the components
Write-Host "Deploying components..." -ForegroundColor Yellow

# Deploy Apex classes
Write-Host "Deploying Apex Controller..." -ForegroundColor Cyan
try {
    sfdx force:source:deploy --sourcepath "$SourcePath/classes/KnowledgeArticleController.cls" --targetusername $OrgAlias
    Write-Host "✓ Apex Controller deployed successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to deploy Apex Controller" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

Write-Host "Deploying Test Class..." -ForegroundColor Cyan
try {
    sfdx force:source:deploy --sourcepath "$SourcePath/classes/KnowledgeArticleControllerTest.cls" --targetusername $OrgAlias
    Write-Host "✓ Test Class deployed successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to deploy Test Class" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

# Deploy LWC component
Write-Host "Deploying LWC Component..." -ForegroundColor Cyan
try {
    sfdx force:source:deploy --sourcepath "$SourcePath/lwc/voiceCallKnowledgeArticles" --targetusername $OrgAlias
    Write-Host "✓ LWC Component deployed successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to deploy LWC Component" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

Write-Host "`nDeployment completed successfully!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Open your Salesforce org" -ForegroundColor White
Write-Host "2. Go to Setup > Lightning App Builder" -ForegroundColor White
Write-Host "3. Edit a VoiceCall record page" -ForegroundColor White
Write-Host "4. Add the 'Voice Call Knowledge Articles' component" -ForegroundColor White
Write-Host "5. Save and activate the page" -ForegroundColor White
Write-Host "`nFor more information, see the README.md file" -ForegroundColor Cyan
