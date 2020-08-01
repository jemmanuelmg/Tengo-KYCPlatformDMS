public class KYCPlatformService {
    
    public static String createCase(String companyName, String countryCode, String entityType) {
        
        if (String.isBlank(companyName)){
            throw new KYCPlatformServiceException('The company name provided is invalid, it is an empty or null string');
        }
        
        if (String.isBlank(countryCode)) {
            throw new KYCPlatformServiceException('The country code provided is invalid, it is an empty or null string');
        }
                        
        if (String.isBlank(entityType)) {
            throw new KYCPlatformServiceException('The company type provided is invalid, it is an empty or null string');
        }

        
        String rawBody = '{"rawname" : "' + companyName + '", "codeiso31662" : "'+ countryCode +'", "companyType" : "'+ entityType +'"}';
        KYCPlatformSettings__c kycPlatformSetting = KYCPlatformSettings__c.getInstance(UserInfo.getUserId());
        String caseCommonId;
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(kycPlatformSetting.ApiUrl__c + '/v2/companies');
        request.setMethod('POST');
        request.setBody(rawBody);
        request.setHeader('ApiKey', kycPlatformSetting.APIKey__c);
        request.setHeader('Content-Type', 'application/json');
        
        Http http = new Http();
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            
            Map<String, Object> contentMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            Map<String, Object> caseDetail = (Map<String, Object>)contentMap.get('caseDetail');
            Map<String, Object> details = (Map<String, Object>)caseDetail.get('details');
            Map<String, Object> company = (Map<String, Object>)details.get('company');
            caseCommonId = String.valueOf(company.get('caseCommonId'));

        } else {
            throw new KYCPlatformServiceException('Request failed with status: ' + response.getStatusCode() + ' and body: ' + response.getBody());
        }

        return caseCommonId;
    }
    
    
    public static Boolean setCaseProperty(String caseCommonId, String dataType, String dataValue) {
        
        if (String.isBlank(caseCommonId)) {
            throw new KYCPlatformServiceException('The case id provided is invalid. It contains alphanumeric characters, is null or is empty');
        }
        
        if (String.isBlank(dataType)) {
            throw new KYCPlatformServiceException('The property data type provided is invalid, it is an empty or null string');
        }
        
        if (String.isBlank(dataValue)) {
            throw new KYCPlatformServiceException('The property data value provided is invalid, it is an empty or null string');
        }
        
        String rawBody = '[{"dataType" : "' + dataType + '", "data" : "'+ dataValue +'"}]';
        KYCPlatformSettings__c kycPlatformSetting = KYCPlatformSettings__c.getInstance(UserInfo.getUserId());
        
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(kycPlatformSetting.ApiUrl__c + '/v2/companies/'+ caseCommonId + '/properties');
        request.setMethod('POST');
        request.setBody(rawBody);
        request.setHeader('ApiKey', kycPlatformSetting.APIKey__c);
        request.setHeader('Content-Type', 'application/json');
		
        Http http = new Http();
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            return true;
        } else {
            throw new KYCPlatformServiceException('Request failed with status: ' + response.getStatusCode() + ' and body: ' + response.getBody());
        }
        
    }
    
    
    public static String getCaseDecision(String caseCommonId) {
       
        if (String.isBlank(caseCommonId)) {
            throw new KYCPlatformServiceException('The case id provided is invalid. It contains alphanumeric characters, is null or is empty');
        }
        
        KYCPlatformSettings__c kycPlatformSetting = KYCPlatformSettings__c.getInstance(UserInfo.getUserId());
        String caseDesicion;
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(kycPlatformSetting.ApiUrl__c + '/v2/companies/' + caseCommonId);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('ApiKey', kycPlatformSetting.APIKey__c);
        
        Http http = new Http();
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {

            Map<String, Object> contentMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            Map<String, Object> caseDetail = (Map<String, Object>)contentMap.get('caseDetail');
            Map<String, Object> details = (Map<String, Object>)caseDetail.get('details');
            Map<String, Object> company = (Map<String, Object>)details.get('company');
            Map<String, Object> properties = (Map<String, Object>)company.get('properties');
            caseDesicion = String.valueOf(properties.get('Go No Go Decision'));
            
        } else {
            throw new KYCPlatformServiceException('Request failed with status: ' + response.getStatusCode() + ' and body: ' + response.getBody());
        }        
		
		return caseDesicion;        
    }
    
    public static String createCaseAndSetProperty(String companyName, String countryCode, String entityType, String dataType, String dataValue) {
        
        String caseCommonId = createCase(companyName, countryCode, entityType);
        setCaseProperty(caseCommonId, dataType, dataValue);      
        return caseCommonId;
        
    }
    
    @future(callout=true)
    public static void createCasesForOpportunities(List<Id> opportunityIds) {
            
        List<Opportunity> opptyList = [SELECT Id, 
                                       Name, 
                                       EntityType__c,
                                       InvestmentManager__r.Name, 
                                       InvestmentManager__r.ShippingCountryCode, 
                                       BURiskAssessment__c,
                                       KYCCaseID__c,
                                       KYCAssessmentResult__c
                                       FROM Opportunity 
                                       WHERE Id IN :opportunityIds];
        
        List<Opportunity> opptyUpdateList = new List<Opportunity>();
        for (Opportunity currentOppty : opptyList) {
            
            try {
                String caseCommonId = createCaseAndSetProperty(currentOppty.InvestmentManager__r.Name, 
                                                               currentOppty.InvestmentManager__r.ShippingCountryCode, 
                                                               currentOppty.EntityType__c, 
                                                               'Overall Risk Rating', 
                                                               currentOppty.BURiskAssessment__c);
 				currentOppty.KYCCaseID__c = caseCommonId;
            	currentOppty.KYCAssessmentResult__c = 'In Progress';     
                currentOppty.KYCAssessmentError__c = null;
            } catch (Exception e) {
                currentOppty.KYCAssessmentResult__c = 'Error';
                currentOppty.KYCAssessmentError__c = e.getMessage();
            }
            
            opptyUpdateList.add(currentOppty);
            
        }
        
        if (!opptyList.isEmpty()) {
            update opptyList;
        }
            
    }
    
    public static String getCaseDecisionBatchQuery() {
        return 'SELECT Id, Name, KYCAssessmentResponse__c, KYCCaseID__c, KYCAssessmentResult__c FROM Opportunity WHERE KYCCaseID__c != null AND KYCAssessmentResult__c = \'In Progress\'';
    }
    
    public static void getCaseDecisionBatch(List<Opportunity> scope) {
        
        List<Opportunity> opptyListToUpdate = new List<Opportunity>();
        for (Opportunity opportunity : scope) {
        	String caseDecision = KYCPlatformService.getCaseDecision(opportunity.KYCCaseID__c);
            
            if (!String.isBlank(caseDecision)) {
                
                opportunity.KYCAssessmentResult__c = caseDecision;
                opportunity.KYCAssessmentResponse__c = Datetime.now();
                opptyListToUpdate.add(opportunity);
                
            }
        }
        
        if (!opptyListToUpdate.isEmpty()) {
        	update opptyListToUpdate;
        }
        
    }

}