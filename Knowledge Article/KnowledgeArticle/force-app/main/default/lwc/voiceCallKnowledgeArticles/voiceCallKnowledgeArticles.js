import { LightningElement, api, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getRelatedKnowledgeArticles from '@salesforce/apex/KnowledgeArticleController.getRelatedKnowledgeArticles';

export default class VoiceCallKnowledgeArticles extends NavigationMixin(LightningElement) {
    @api recordId; 
    @api voiceCallId; 
    @track articles = [];
    @track isLoading = false;
    @track error;
    pollingInterval;
    wiredArticlesResult;
    
    // Get the actual voice call ID to use
    get actualVoiceCallId() {
        const id = this.voiceCallId || this.recordId;
        console.log('actualVoiceCallId getter called:', id);
        return id;
    }

    @wire(getRelatedKnowledgeArticles, { voiceCallId: '$actualVoiceCallId' })
    wiredArticles(result) {
        this.wiredArticlesResult = result;
        this.isLoading = true;
        
        if (result.data) {
            // Transform Apex data to match component expectations
            this.articles = result.data.map(article => ({
                id: article.Id,
                title: article.Title,
                urlName: article.UrlName,
                recordType: article.RecordType || 'Article',
                recordTypeVariant: article.RecordTypeVariant || 'success',
                articleNumber: article.ArticleNumber || '',
                publishStatus: article.PublishStatus || 'Online'
            }));
            this.error = undefined;
            this.isLoading = false;
        } else if (result.error) {
            this.error = result.error;
            this.articles = [];
            this.isLoading = false;
            this.showToast('Error', 'Failed to load related knowledge articles', 'error');
        }
    }
    
    handleRefresh() {
        this.isLoading = true;
        return refreshApex(this.wiredArticlesResult).then(() => {
            this.isLoading = false;
            this.showToast('Success', 'Knowledge articles refreshed successfully', 'success');
        }).catch(error => {
            this.isLoading = false;
            this.showToast('Error', 'Failed to refresh knowledge articles', 'error');
        });
    }

    handleArticleClick(event) {
        const articleId = event.currentTarget.dataset.id;
        this.navigateToArticle(articleId);
    }

    navigateToArticle(articleId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: articleId,
                objectApiName: 'Knowledge__kav',
                actionName: 'view'
            }
        });
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }

    get hasArticles() {
        return this.articles && this.articles.length > 0;
    }

    get articleCount() {
        return this.articles ? this.articles.length : 0;
    }

    get articleCountText() {
        return this.articleCount === 1 ? '' : 's';
    }
}
