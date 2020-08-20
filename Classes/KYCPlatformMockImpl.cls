@isTest
public class KYCPlatformMockImpl implements HttpCalloutMock {
    
    public HTTPResponse respond(HTTPRequest req) {
                   
        if (req.getBody().contains('GB') || req.getBody().contains('~') || req.getEndpoint().contains('~')){
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"result":"Error"}');
            res.setStatusCode(400);
            return res;
            
        } else if (req.getEndpoint().contains('duplicated-kyc-case')) {
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[ { "company":{ "id":2, "caseCompanyId":2, "countryCodeISO31662":"US", "entityName":"ATKINSON LEGAL SERVICES", "type":"Liability Company (LLC) (Non-Cayman or Cayman)", "description":"Case Generated from API", "userId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c", "caseCommonId":2, "creatorId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c", "properties":{ "Company Type":"Liability Company (LLC) (Non-Cayman or Cayman)", "Overall Risk Rating":"Medium" }, "createdDatetime":"2020-05-19T18:02:08.553" }, "isCaseAMLPositive":false, "caseAmlSummary":null, "caseCloseDate":null, "caseReviewDate":null, "common":{ "caseCommonId":2, "caseCustomerId":2, "caseDecision":null, "customerId":365, "customerName":"DMS Demo", "type":1, "typeString":"Company", "scoring":0, "complete":60, "edit":true, "status":"Open", "statusChangedDatetime":null, "statusChangedBy":null, "statusId":3, "isVisible":true, "creatorId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c", "creatorUserName":"peter@tengo.co", "createdDatetime":"2020-05-19T18:02:08.54", "updatedBySystem":"2020-08-17T14:39:35.18", "isAMLCase":true, "updatedByUser":"2020-08-17T14:40:03.137", "countryRisk":null, "assignedUserId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c", "assignedUserName":"peter@tengo.co", "link":"https://dms-dem.knowyourcustomer.com/casecompany/2/detail", "statusName":"Ready", "isDeactivated":false, "caseProcessingType":null, "isComplexStructure":false, "caseDrillDownLevel":2, "hasMoreLayers":false, "isApproved":null, "source":null }, "caseAddress":{ "caseAddressId":2, "caseCommonId":2, "addressLine1":null, "addressLine2":null, "city":null, "stateProvince":null, "postcode":null, "country":"United States", "countryCodeISO31662":"US", "countryId":226, "rawAddress":"United States", "address":"United States", "userId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c", "creatorName":"peter@tengo.co", "createdDatetime":"2020-05-19T18:02:08.553", "deviceLng":null, "deviceLat":null, "geolocationVerified":null }, "risks":{ "client":null, "channel":null, "product":null, "country":null, "total":null } }, { "company":{ "id":6, "caseCompanyId":6, "countryCodeISO31662":"US", "entityName":"ATKINSON LEGAL SERVICES", "type":"Unit Trust (Cayman)", "description":"Case Generated from API", "userId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c", "caseCommonId":6, "creatorId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c", "properties":{ "Company Type":"Unit Trust (Cayman)", "Overall Risk Rating":"Low" }, "createdDatetime":"2020-05-19T18:15:02.83" }, "isCaseAMLPositive":false, "caseAmlSummary":null, "caseCloseDate":null, "caseReviewDate":null, "common":{ "caseCommonId":6, "caseCustomerId":6, "caseDecision":null, "customerId":365, "customerName":"DMS Demo", "type":1, "typeString":"Company", "scoring":0, "complete":25, "edit":true, "status":"Open", "statusChangedDatetime":null, "statusChangedBy":null, "statusId":3, "isVisible":true, "creatorId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c", "creatorUserName":"peter@tengo.co", "createdDatetime":"2020-05-19T18:15:02.813", "updatedBySystem":"2020-05-19T18:15:48.533", "isAMLCase":true, "updatedByUser":null, "countryRisk":null, "assignedUserId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c", "assignedUserName":"peter@tengo.co", "link":"https://dms-dem.knowyourcustomer.com/casecompany/6/detail", "statusName":"Ready", "isDeactivated":false, "caseProcessingType":null, "isComplexStructure":false, "caseDrillDownLevel":1, "hasMoreLayers":false, "isApproved":null, "source":null }, "caseAddress":{ "caseAddressId":6, "caseCommonId":6, "addressLine1":null, "addressLine2":null, "city":null, "stateProvince":null, "postcode":null, "country":"United States", "countryCodeISO31662":"US", "countryId":226, "rawAddress":"United States", "address":"United States", "userId":"24d4ecac-ce94-4e6b-b7b0-0cb8133ed81c", "creatorName":"peter@tengo.co", "createdDatetime":"2020-05-19T18:15:02.83", "deviceLng":null, "deviceLat":null, "geolocationVerified":null }, "risks":{ "client":null, "channel":null, "product":null, "country":null, "total":null } } ]');            
            res.setStatusCode(200);
            return res;
            
        } else if (req.getEndpoint().contains('negative')) {
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[]');            
            res.setStatusCode(200);
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