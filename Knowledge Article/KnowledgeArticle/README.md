# Voice Call Knowledge Articles Component

This Salesforce Lightning Web Component (LWC) displays related knowledge articles based on voice call conversation content. It analyzes the conversation messages from a VoiceCall record and finds relevant Knowledge articles using keyword matching and relevance scoring.

## Features

- **Intelligent Search**: Analyzes conversation content to extract relevant keywords
- **Relevance Scoring**: Ranks articles based on keyword matches in title, summary, details, question, and answer fields
- **Hover Popup**: Shows detailed article information when hovering over article titles
- **Click Navigation**: Navigate to the full knowledge article page by clicking on titles
- **Refresh Functionality**: Refresh the article list using the refresh button
- **Record Type Support**: Supports both "FAQ" and "How To" record types with appropriate icons and styling
- **Responsive Design**: Works on desktop and mobile devices

## Components

### 1. Apex Controller (`KnowledgeArticleController.cls`)

The controller provides two main methods:

- `getRelatedKnowledgeArticles(String voiceCallId)`: Retrieves conversation entries and finds related knowledge articles
- `getKnowledgeArticleDetails(String articleId)`: Gets detailed information for a specific article

**Key Features:**
- Extracts keywords from conversation messages
- Filters out common words to improve search relevance
- Searches across multiple fields (Title, Summary, Details, Question, Answer)
- Calculates relevance scores based on keyword matches
- Supports both FAQ and How To record types

### 2. LWC Component (`voiceCallKnowledgeArticles`)

The Lightning Web Component that provides the user interface.

**Key Features:**
- Displays articles in a card-based layout
- Shows relevance scores and record type badges
- Hover popup with detailed article information
- Click navigation to full article pages
- Refresh functionality with loading states
- Error handling and empty states

## Installation

1. Deploy the Apex class and LWC component to your Salesforce org
2. Add the component to VoiceCall record pages using the Lightning App Builder
3. The component will automatically detect the VoiceCall ID and display related articles

## Usage

### Adding to VoiceCall Record Pages

1. Open the Lightning App Builder
2. Edit a VoiceCall record page
3. Drag the "Voice Call Knowledge Articles" component to the desired location
4. Save and activate the page

### Component Behavior

- **Automatic Loading**: The component automatically loads when a VoiceCall record is viewed
- **Hover for Details**: Hover over article titles to see a detailed popup
- **Click to Navigate**: Click on article titles to open the full article page
- **Refresh**: Use the refresh button to reload the article list

## Configuration

### Knowledge Article Visibility

The component respects the visibility settings of knowledge articles:
- Visible In Internal App
- Visible In Public Knowledge Base
- Visible to Customer
- Visible to Partner

Only articles with `PublishStatus = 'Online'` and appropriate visibility settings are displayed.

### Search Algorithm

The search algorithm:
1. Extracts keywords from conversation messages
2. Filters out common words (the, and, or, etc.)
3. Searches for keywords in article content
4. Calculates relevance scores based on keyword frequency
5. Sorts articles by relevance score

## Customization

### Styling

The component uses SLDS (Salesforce Lightning Design System) classes and custom CSS. You can customize the appearance by modifying the CSS file.

### Search Logic

To modify the search algorithm, edit the `extractKeywords` and `calculateRelevanceScore` methods in the Apex controller.

### Record Types

The component automatically detects and displays different icons and colors for:
- **FAQ**: Question icon with brand color
- **How To**: Article icon with success color

## Troubleshooting

### Common Issues

1. **No Articles Found**: Ensure knowledge articles are published and have appropriate visibility settings
2. **Permission Errors**: Verify the user has access to Knowledge articles and VoiceCall records
3. **Component Not Loading**: Check that the component is properly added to the VoiceCall record page

### Debug Information

Enable debug logs in Salesforce to troubleshoot issues:
1. Go to Setup > Debug Logs
2. Add your user to the debug log list
3. Reproduce the issue
4. Check the debug logs for error messages

## Dependencies

- Salesforce API Version 58.0 or higher
- Knowledge object with custom fields (Question__c, Answer__c, Details__c)
- VoiceCall and ConversationEntry objects
- Lightning Web Components framework

## Support

For issues or questions, please check the debug logs and ensure all dependencies are properly configured.
