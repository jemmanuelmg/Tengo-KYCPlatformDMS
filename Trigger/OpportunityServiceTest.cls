@isTest
private class OpportunityServiceTest {
    
    @testSetup 
    static void setup() {
        
        KYCPlatformSettings__c testCustomSetting = new KYCPlatformSettings__c();
        testCustomSetting.APIKey__c = 'A123-B456-C789-D012';
        testCustomSetting.ApiUrl__c = 'https://api-demo.knowyourcustomer.com';
        testCustomSetting.KYCPlatformInterfaceEnabled__c = true;
        insert testCustomSetting;
        
        Account account1 = TestDataFactory.createAccount('Test Account');         
        insert account1;
        
        Opportunity opportunity1 = TestDataFactory.createOpportunity('Test Opportunity', account1);
        opportunity1.InitiateKYCAssessment__c = true;
        opportunity1.InvestmentManager__c = account1.Id;
        opportunity1.AMLDelegate__c = account1.Id;
        opportunity1.EntityType__c = 'Trust';
        opportunity1.Strategy__c = 'Activist';
        opportunity1.Domicile__c = 'Afghanistan';
        insert opportunity1;
        
        Opportunity opportunity2 = TestDataFactory.createOpportunity('Test Opportunity1', account1);
        opportunity2.InitiateKYCAssessment__c = false;
        opportunity2.InvestmentManager__c = account1.Id;
        opportunity2.AMLDelegate__c = account1.Id;
        opportunity2.EntityType__c = 'Trust';
        opportunity2.Strategy__c = 'Activist';
        opportunity2.Domicile__c = 'Afghanistan';
        insert opportunity2;
        
    }
    
    @isTest 
    static void testSetKYCRequestDateTime() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());             
        Opportunity opp = [SELECT InitiateKYCAssessment__c FROM Opportunity WHERE InitiateKYCAssessment__c = false];
        Test.startTest();
            opp.InitiateKYCAssessment__c = true;
            update opp;         
        Test.stopTest();

        Opportunity updOpp = [SELECT Id, Name, KYCAssessmentRequest__c FROM Opportunity WHERE Id = :opp.Id];        
        
        Date returnedDate1 = Date.newInstance(updOpp.KYCAssessmentRequest__c.year(), updOpp.KYCAssessmentRequest__c.month(), updOpp.KYCAssessmentRequest__c.day());
        Date currentDate = Date.newInstance(System.now().year(), System.now().month(), System.now().day()); 
        
        System.assertEquals(returnedDate1, currentDate, 'Expected to have a KYCAssessmentRequest__c date with same value of today');
        
    }
    
    @isTest 
    static void testSetKYCRequestDateTimeOnInsert() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());             
        
        Account account1 = TestDataFactory.createAccount('Test Account');         
        insert account1;
        
        Opportunity testOppty = TestDataFactory.createOpportunity('Test Opportunity 3', account1);
        testOppty.InitiateKYCAssessment__c = true;
        testOppty.InvestmentManager__c = account1.Id;
        testOppty.AMLDelegate__c = account1.Id;
        testOppty.EntityType__c = 'Trust';
        testOppty.Strategy__c = 'Activist';
        testOppty.Domicile__c = 'Afghanistan';
        
        Test.startTest();
            insert testOppty;       
        Test.stopTest();        
        
        Opportunity updOpp = [SELECT Id, Name, KYCAssessmentRequest__c FROM Opportunity WHERE Name = 'Test Opportunity 3'];  
        
        Date returnedDate1 = Date.newInstance(updOpp.KYCAssessmentRequest__c.year(), updOpp.KYCAssessmentRequest__c.month(), updOpp.KYCAssessmentRequest__c.day());
        Date currentDate = Date.newInstance(System.now().year(), System.now().month(), System.now().day()); 
        
        System.assertEquals(returnedDate1, currentDate, 'Expected to have a KYCAssessmentRequest__c date with same value of today');
        
    }
    
    @isTest 
    static void testiInitiateKYCAssessment() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());             
        Opportunity opp = [SELECT InitiateKYCAssessment__c FROM Opportunity WHERE InitiateKYCAssessment__c = false];
        Test.startTest();
            opp.InitiateKYCAssessment__c = true;
            update opp;         
        Test.stopTest();

        Opportunity updOpp = [SELECT Id, Name, KYCCaseID__c FROM Opportunity WHERE Id = :opp.Id];        
        
        System.assertEquals(false, String.IsBlank(updOpp.KYCCaseID__c), 'Expected to have a not blank KYCCaseID__c');
        
    }
    
    @isTest 
    static void testInitiateKYCAssessmentOnInsert() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());             
        
        Account account1 = TestDataFactory.createAccount('Test Account');         
        insert account1;
        
        Opportunity testOppty = TestDataFactory.createOpportunity('Test Opportunity 4', account1);
        testOppty.InitiateKYCAssessment__c = true;
        testOppty.InvestmentManager__c = account1.Id;
        testOppty.AMLDelegate__c = account1.Id;
        testOppty.EntityType__c = 'Trust';
        testOppty.Strategy__c = 'Activist';
        testOppty.Domicile__c = 'Afghanistan';
        
        Test.startTest();
            insert testOppty;       
        Test.stopTest();        
        
        Opportunity updOpp = [SELECT Id, Name, KYCCaseID__c FROM Opportunity WHERE Name = 'Test Opportunity 4'];  
        
        System.assertEquals(false, String.IsBlank(updOpp.KYCCaseID__c), 'Expected to have a not blank KYCCaseID__c');
        
    }
    
}