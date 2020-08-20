@isTest
public class KYCPlatformServiceTest {
    
    @testSetup 
    static void setup() {
        
        KYCPlatformSettings__c testCustomSetting = new KYCPlatformSettings__c();
        testCustomSetting.APIKey__c = 'A123-B456-C789-D012';
        testCustomSetting.ApiUrl__c = 'https://api-demo.knowyourcustomer.com';
        testCustomSetting.KYCPlatformInterfaceEnabled__c = true;
        insert testCustomSetting;
        
        Account account1 = TestDataFactory.createAccount('Test Account');  
        account1.BillingCountry = 'United States';
        insert account1;
        
        Account account2 = TestDataFactory.createAccount('Test Account duplicated-kyc-case');  
        account2.BillingCountry = 'United States';
        insert account2;
        
        Account account3 = TestDataFactory.createAccount('Test Account negative');  
        account3.BillingCountry = 'United States';
        insert account3;
        
        Opportunity opportunity1 = TestDataFactory.createOpportunity('Test Opp', account1);
        opportunity1.InvestmentManager__c = account1.Id;
        opportunity1.EntityType__c = 'Trust';
        insert opportunity1;
        
        Opportunity opportunity2 = TestDataFactory.createOpportunity('Test Opp duplicated-kyc-case', account2);
        opportunity2.InvestmentManager__c = account2.Id;
        opportunity2.EntityType__c = 'Trust';
        insert opportunity2;
        
        Opportunity opportunity3 = TestDataFactory.createOpportunity('Test Opp negative', account3);
        opportunity3.InvestmentManager__c = account3.Id;
        opportunity3.EntityType__c = 'Trust';
        insert opportunity3;
        
    }

    @isTest 
    static void testPositiveCreateCase() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Test.startTest();
            String commonCaseId = KYCPlatformService.createCase('Rogers Infrastructure', 'CO', 'Undetermined');
        Test.stopTest();
        
        System.assertEquals('23020', commonCaseId, 'Expected to have a returned Case ID with value 23020');
        
    }
    
    @isTest 
    static void testNegativeCreateCaseError400() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
            
        Test.startTest();
            try {
                String commonCaseId = KYCPlatformService.createCase('Rogers Infrastructure', 'GB', 'Undetermined');
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
                String commonCaseId = KYCPlatformService.createCase('Rogers Infrastructure', null, 'Undetermined');
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
                String commonCaseId = KYCPlatformService.createCase('Rogers Infrastructure', 'CO', null);
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
                                                                  InvestmentManager__r.BillingCountryCode,
                                                                  BURiskAssessment__c
                                                                  FROM Opportunity
                                                                  WHERE Name = 'Test Opp']);
        
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
    static void testPositiveCreateCasesForOpportunitiesExistingKYCCase() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        Map<Id, Opportunity> opptyMap = new Map<Id, Opportunity>([SELECT Id, 
                                                                  Name, 
                                                                  InvestmentManager__r.Name,
                                                                  EntityType__c,
                                                                  InvestmentManager__r.BillingCountryCode,
                                                                  BURiskAssessment__c
                                                                  FROM Opportunity
                                                                  WHERE Name = 'Test Opp duplicated-kyc-case']);
        
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
    static void testPositiveCreateCasesForOpportunitiesNoExistingKYCCase() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean expectedExceptionThrown = false;
        Map<Id, Opportunity> opptyMap = new Map<Id, Opportunity>([SELECT Id, 
                                                                  Name, 
                                                                  InvestmentManager__r.Name,
                                                                  EntityType__c,
                                                                  InvestmentManager__r.BillingCountryCode,
                                                                  BURiskAssessment__c
                                                                  FROM Opportunity
                                                                  WHERE Name = 'Test Opp negative']);
        
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
    static void testPositiveGetCaseDecisionBatch() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        List<Opportunity> oppList = [SELECT Id, Name FROM Opportunity WHERE Name = 'Test Opp'];
        oppList[0].KYCCaseID__c = '1111';
        
        Test.startTest();
            KYCPlatformService.getCaseDecisionBatch(oppList);
        Test.stopTest();
        
        Opportunity resultOppty = [SELECT Id, KYCAssessmentResult__c FROM Opportunity WHERE Name = 'Test Opp'];
        String caseDecision = resultOppty.KYCAssessmentResult__c;
        System.assertEquals(false, String.isBlank(caseDecision), 'Expected to have a case decision in the updated opportunity');
        
    }
    
    @isTest 
    static void testPositiveCheckExistingCasesForCompany() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Test.startTest();
            String commonCaseId = KYCPlatformService.checkExistingCasesForCompany('Rogers Infrastructure -duplicated-kyc-case', 'US');
        Test.stopTest();
        
        System.assertEquals(true, commonCaseId != 'No Existing Case', 'Expected to have a commonCaseId different than 0');
        
    }
    
    @isTest 
    static void testNegativeCheckExistingCasesForCompany() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Test.startTest();
            String commonCaseId = KYCPlatformService.checkExistingCasesForCompany('Rogers Infrastructure -duplicatedKyc-negative', 'US');
        Test.stopTest();
        
        System.assertEquals('No Existing Case', commonCaseId, 'Expected to have a commonCaseId equals to 0');
        
    }
    
    @isTest 
    static void testExceptionCheckExistingCasesForCompany() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean exceptionOccurred = false;
        
        Test.startTest();
            try {
                String commonCaseId = KYCPlatformService.checkExistingCasesForCompany('', 'US');
            } catch(Exception ex) {
                exceptionOccurred = true;
            }
        Test.stopTest();
        
        System.assertEquals(true, exceptionOccurred, 'Expected to have an exception because one of the parameters was blank');
        
    }
    
    @isTest 
    static void testExceptionNo200CheckExistingCasesForCompany() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        Boolean exceptionOccurred = false;
        
        Test.startTest();
            try {
                String commonCaseId = KYCPlatformService.checkExistingCasesForCompany('~Rogers Infrastructure~', 'US');
            } catch(Exception ex) {
                exceptionOccurred = true;
            }
        Test.stopTest();
        
        System.assertEquals(true, exceptionOccurred, 'Expected to have an exception because the Http response had status 400');
        
    }
        
}