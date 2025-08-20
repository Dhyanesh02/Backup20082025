@echo off
echo Deploying Knowledge Article Components...

REM Deploy the Apex classes
sfdx force:source:deploy -p force-app/main/default/classes/KnowledgeArticleController.cls
sfdx force:source:deploy -p force-app/main/default/classes/KnowledgeArticleControllerTest.cls
sfdx force:source:deploy -p force-app/main/default/classes/VoiceCallTranscriptHelper.cls

REM Deploy the LWC component
sfdx force:source:deploy -p force-app/main/default/lwc/voiceCallKnowledgeArticles/

echo Deployment completed!
pause
