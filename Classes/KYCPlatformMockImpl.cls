@isTest
public class KYCPlatformMockImpl implements HttpCalloutMock {
    
    public HTTPResponse respond(HTTPRequest req) {
                   
        if (req.getBody().contains('GB') || req.getBody().contains('~') || req.getEndpoint().contains('~')){
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"result":"Error"}');
            res.setStatusCode(400);
            return res;
            
        } else {
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"caseDetail":{"details":{"company":{"id":7862,"caseCompanyId":7862,"countryCodeISO31662":"CO","entityName":"WILLIAMS ACCOUNTING SERVICES","type":"Undetermined","description":"Case Generated from API","userId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c","caseCommonId":23020,"creatorId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c","properties":{"Company Type":"Undetermined", "Go No Go Decision": "Go"},"createdDatetime":"2020-04-16T23:31:38.94"},"isCaseAMLPositive":false,"common":{"caseCommonId":23020,"caseCustomerId":11,"caseDecision":"Approved Case","customerId":365,"customerName":"DMS Demo","type":1,"typeString":"Company","scoring":0,"complete":67,"edit":true,"status":"Open","statusChangedDatetime":null,"statusChangedBy":null,"statusId":0,"isVisible":true,"creatorId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c","creatorUserName":"peter@tengo.co","createdDatetime":"2020-04-16T23:31:38.907","updatedBySystem":"2020-04-16T23:31:39","isAMLCase":false,"updatedByUser":null,"countryRisk":4.42,"assignedUserId":null,"assignedUserName":null,"link":"https://dms-dem.knowyourcustomer.com/casecompany/23020/detail","statusName":"Initializing Case","isDeactivated":false,"caseProcessingType":"","isComplexStructure":false,"caseDrillDownLevel":null,"hasMoreLayers":null,"isApproved":null,"source":null},"caseAddress":{"caseAddressId":11,"caseCommonId":23020,"addressLine1":null,"addressLine2":null,"city":null,"stateProvince":null,"postcode":null,"country":null,"countryCodeISO31662":null,"countryId":null,"rawAddress":null,"address":null,"userId":null,"creatorName":null,"createdDatetime":"2020-04-16T23:31:38.94","deviceLng":null,"deviceLat":null,"geolocationVerified":null}}}}');
            res.setStatusCode(200);
            return res;
            
        }
        
    }
    
}