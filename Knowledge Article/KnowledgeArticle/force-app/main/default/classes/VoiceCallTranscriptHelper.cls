public with sharing class VoiceCallTranscriptHelper {
    public static String getTranscript(Id voiceCallId) {
        Map<String, Object> inputs = new Map<String, Object>();
        inputs.put('recordId', voiceCallId);

        // Replace with your actual flow API name
        Flow.Interview.VHS_Conversation_Entry_Messages flowRun =
            new Flow.Interview.VHS_Conversation_Entry_Messages(inputs);

        flowRun.start();

        String transcript = (String) flowRun.getVariableValue('formattedTranscript');
        System.debug('📝 Clean Transcript: ' + transcript);

        return transcript;
    }
}
