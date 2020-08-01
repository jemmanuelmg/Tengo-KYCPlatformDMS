@isTest
public class KYCPlatformServiceTest {
    
    @testSetup 
    static void setup() {
        
        KYCPlatformSettings__c testCustomSetting = new KYCPlatformSettings__c();
        testCustomSetting.APIKey__c = 'A123-B456-C789-D012';
        testCustomSetting.ApiUrl__c = 'https://api-demo.knowyourcustomer.com';
        testCustomSetting.KYCPlatformInterfaceEnabled__c = true;
        insert testCustomSetting;
        
        Account account1 = TestDataFactory.createNewAccount();  
        account1.ShippingCountry = 'United States';
        insert account1;
        
        Opportunity opportunity1 = TestDataFactory.createNewOpportunity(account1);
        opportunity1.InvestmentManager__c = account1.Id;
        opportunity1.EntityType__c = 'General partnership';
        opportunity1.InitialBURiskAssessment__c = 'Medium';
        insert opportunity1;
        
    }

    @isTest 
    static void testPositiveCreateCase() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Test.startTest();
        	String commonCaseId = KYCPlatformService.createCase('Rogers Infraestructure', 'CO', 'Undetermined');
        Test.stopTest();
        
        System.assertEquals('23020', commonCaseId, 'Expected to have a returned Case ID with value 23020');
        
    }
    
    @isTest 
    static void testNegativeCreateCaseError400() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
            
        Test.startTest();
            try {
                String commonCaseId = KYCPlatformService.createCase('Rogers Infraestructure', 'GB', 'Undetermined');
            } catch(Exception ex) {
                expectedExceptionThrown = true;
            }
        Test.stopTest();
        
        System.AssertEquals(true, expectedExceptionThrown, 'Expected to have an Exception of type KYCPlatformServiceException');
        
    }
    
    @isTest 
    static void testNegativeCreateCaseInvalidParameters1() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        
        Test.startTest();
            try {
                String commonCaseId = KYCPlatformService.createCase(null, 'CO', 'Undetermined');
            } catch(Exception ex) {
                expectedExceptionThrown = true;
            }
        Test.stopTest();
        
        System.AssertEquals(true, expectedExceptionThrown, 'Expected to have an Exception of type KYCPlatformServiceException');
    }
    
    @isTest 
    static void testNegativeCreateCaseInvalidParameters2() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        
        Test.startTest();
            try {
                String commonCaseId = KYCPlatformService.createCase('Rogers Infraestructure', null, 'Undetermined');
            } catch(Exception ex) {
                expectedExceptionThrown = true;
            }
        Test.stopTest();
        
        System.AssertEquals(true, expectedExceptionThrown, 'Expected to have an Exception of type KYCPlatformServiceException');
        
    }
    
    @isTest 
    static void testNegativeCreateCaseInvalidParameters3() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        
        Test.startTest();
            try {
                String commonCaseId = KYCPlatformService.createCase('Rogers Infraestructure', 'CO', null);
            } catch(Exception ex) {
                expectedExceptionThrown = true;
            }
        Test.stopTest();
        
        System.AssertEquals(true, expectedExceptionThrown, 'Expected to have an Exception of type KYCPlatformServiceException');
        
    }
    
    @isTest
    static void testPositiveSetCaseProperty() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Test.startTest();
        	Boolean result = KYCPlatformService.setCaseProperty('23012', 'Custom Test Property', 'High Priority');
        Test.stopTest();
        
        System.assertEquals(true, result, 'Expected to have a successful response from the server');
        
    }
    
    @isTest
    static void testNegativeSetCasePropertyError400() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        
        Test.startTest();
            try {
                Boolean result = KYCPlatformService.setCaseProperty('23012', '~~Custom Test Property~~', 'High Priority');
            } catch(Exception ex) {
                expectedExceptionThrown = true;
            }
        Test.stopTest();
        
        System.AssertEquals(true, expectedExceptionThrown, 'Expected to have an Exception of type KYCPlatformServiceException');
        
        
    }
    
    @isTest 
    static void testNegativeSetCasePropertyInvalidParameters1() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        
        Test.startTest();
            try {
                Boolean result = KYCPlatformService.setCaseProperty('', 'Custom Test Property', 'High Priority');
            } catch(Exception ex) {
                expectedExceptionThrown = true;
            }
        Test.stopTest();
        
        System.AssertEquals(true, expectedExceptionThrown, 'Expected to have an Exception of type KYCPlatformServiceException');
        
    }
    
    @isTest 
    static void testNegativeSetCasePropertyInvalidParameters2() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        
        Test.startTest();
            try {
                Boolean result = KYCPlatformService.setCaseProperty('23012', '', 'High Priority');
            } catch(Exception ex) {
                expectedExceptionThrown = true;
            }
        Test.stopTest();
        
        System.AssertEquals(true, expectedExceptionThrown, 'Expected to have an Exception of type KYCPlatformServiceException');
        
    }
    
    @isTest 
    static void testNegativeSetCasePropertyInvalidParameters3() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        
        Test.startTest();
            try {
                Boolean result = KYCPlatformService.setCaseProperty('23012', 'Custom Test Property', '');
            } catch(Exception ex) {
                expectedExceptionThrown = true;
            }
        Test.stopTest();
        
        System.AssertEquals(true, expectedExceptionThrown, 'Expected to have an Exception of type KYCPlatformServiceException');
        
    }
    
    @isTest
    static void testPositiveGetCaseDecision() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Test.startTest();
        	String result = KYCPlatformService.getCaseDecision('23012');
        Test.stopTest();
        
        System.assertEquals('Go', result, 'Expected to have a successful response and a case desicion with value Approved Case');
        
    }
    
    @isTest 
    static void testNegativeGetCaseDecisionError400() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        
        Test.startTest();
            try {
                String result = KYCPlatformService.getCaseDecision('23012~~');
            } catch(Exception ex) {
                expectedExceptionThrown = true;
            }
        Test.stopTest();
        
        System.AssertEquals(true, expectedExceptionThrown, 'Expected to have an Exception of type KYCPlatformServiceException');
        
    }
        
    @isTest 
    static void testNegativeGetCaseDecisionInvalidParameters() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        
        Test.startTest();
            try {
                String result = KYCPlatformService.getCaseDecision('');
            } catch(Exception ex) {
                expectedExceptionThrown = true;
            }
        Test.stopTest();
        
        System.AssertEquals(true, expectedExceptionThrown, 'Expected to have an Exception of type KYCPlatformServiceException');
        
    }
    
    @isTest
    static void testPositiveCreateCaseAndSetProperty() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Test.startTest();
        	String commonCaseId = KYCPlatformService.createCaseAndSetProperty('Rogers Infraestructure', 'CO', 'Undetermined', 'Custom Test Property', 'High Priority');
        Test.stopTest();
        
        System.assertEquals('23020', commonCaseId, 'Expected to have a returned Case ID with value 23020');
        
    }
    
    @isTest
    static void testPositiveCreateCasesForOpportunities() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        Map<Id, Opportunity> opptyMap = new Map<Id, Opportunity>([SELECT Id, 
                                                                  Name, 
                                                                  InvestmentManager__r.Name,
                                                                  EntityType__c,
                                                                  InvestmentManager__r.ShippingCountryCode,
                                                                  InitialBURiskAssessment__c
                                                                  FROM Opportunity]);
        
        Test.startTest();
            try {
                List<Id> idList = new List<Id>(opptyMap.keySet());
        		KYCPlatformService.createCasesForOpportunities(idList);
            } catch(Exception ex) {
                expectedExceptionThrown = true;
            }
        Test.stopTest();
        
        System.AssertEquals(false, expectedExceptionThrown, 'Expected to complete the process without exceptions');
        
    }
    
    @isTest
    static void testPositiveGetCaseDecisionBatchQuery() {
        
        String query = KYCPlatformService.getCaseDecisionBatchQuery();
        System.assertEquals(false, String.isBlank(query), 'Expected to have a returned query with a value');
        
    }
    
    @isTest
    static void testPositivegGetCaseDecisionBatchQuery() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        List<Opportunity> oppList = [SELECT Id FROM Opportunity];
        oppList[0].KYCCaseID__c = '1111';
        
        Test.startTest();
            KYCPlatformService.getCaseDecisionBatch(oppList);
        Test.stopTest();
        
        Opportunity resultOppty = [SELECT Id, KYCAssessmentResult__c FROM Opportunity LIMIT 1];
        String caseDecision = resultOppty.KYCAssessmentResult__c;
        System.assertEquals(false, String.isBlank(caseDecision), 'Expected to have a case decision in the updated opportunity');
        
    }
        
}