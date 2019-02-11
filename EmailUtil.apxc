public class EmailUtil {
    private static final String Boundary = '----WebKitFormBoundary7MA4YWxkTrZu0gW';//'---------------------------7db1851cd1158';	
	
    public static void sendOnboardingEmail(Map<String,String> accountNameByEmailAddress) {
        sendEmail(accountNameByEmailAddress, 'OnBoarding Email', 'Welcome to XYZ Inc.');
    }
    
    public static void sendEmailUpdateConfirmation(Map<String,String> accountNameByEmailAddress) {
        sendEmail(accountNameByEmailAddress, 'Email update notification', 'Thank you !! Your email address has been successfully update');
    } 
    
	@future(callout=true)
    public static void sendEmail(Map<String,String> accountNameByEmailAddress, String subject, String emailBody) {
        String requestBody = generateRequestBody(accountNameByEmailAddress.keySet(), subject, emailBody);
        
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:Mailgun');
        request.setHeader('Content-Type', 'multipart/form-data; boundary=' + Boundary);
        request.setBody(requestBody); 
        
        System.debug('HTTP Request ='+ request.getBody());
        
        Integer maximunRetries = 3;
		for (Integer retryCounter=1; retryCounter <= maximunRetries; retryCounter++) {
            HTTPResponse response;
            try {
                System.debug(LoggingLevel.DEBUG, 'Try number '+ retryCounter + ' out of ' + maximunRetries + ' request body ='+ request.getEndpoint()+
                             ' header '+ request.getHeader('Authorization'));
                Http http = new Http();
                response = http.send(request);
                System.debug(response.getBody());
                
                if(response.getStatusCode() == 200) 
                	break;
                if(retryCounter == 3)
                    throw new MailGunEmailDeliveryException('Email could not be sent through MailGun, status = '+ response.getStatus() + 
                                                            ' Status code = ' + response.getStatusCode());
            } catch(Exception ex) {
                System.debug('Exception Occured during send email operation due to '+ ex.getCause() + 
                             ' with stack trace ' + ex.getStackTraceString() + ' Exception = '+ex);
                if(!Test.isRunningTest())
                	throw ex;
            }
            
        }
    }
    
    private static String generateRequestBody(Set<String> emailAddresses, String subject, String emailBody) {
		List<String> toEmailAddresses = new List<String>();
        toEmailAddresses.addAll(emailAddresses);
        
		String requestBody = '';
        requestBody += addFormField('from', 'postmaster@sandboxe49e556b7a9b4b5bbf9b21b52875ce98.mailgun.org');
        requestBody += addFormField('to', String.join(toEmailAddresses, ','));
        requestBody += addFormField('subject', subject);
        requestBody += addFormField('text', emailBody);
        requestBody += '------WebKitFormBoundary7MA4YWxkTrZu0gW--';
        
        return requestBody;
    }
    
    private static String addFormField(String fieldName, String fieldValue){
        String temp = '--' + Boundary + '\r\n';
        temp += 'Content-Disposition: form-data; name=\"' + fieldName + '\"\r\n\r\n';
        temp +=fieldValue + '\r\n';
        return temp;
    }
    
    public class MailGunEmailDeliveryException extends Exception {}
}
