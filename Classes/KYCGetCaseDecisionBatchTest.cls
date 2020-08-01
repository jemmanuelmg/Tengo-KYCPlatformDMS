@isTest
public class KYCGetCaseDecisionBatchTest {
    
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
        opportunity1.KYCAssessmentResult__c = null;
        opportunity1.KYCAssessmentResponse__c = null;
        opportunity1.StageName = 'Initial Lead';
        insert opportunity1;        
        
    }
    
    @isTest
    static void testBatchService() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        KYCGetCaseDecisionBatch batchJob = new KYCGetCaseDecisionBatch();
        Test.startTest();
            Id batchJobId = DataBase.executeBatch(batchJob); 
        Test.stopTest();
                
        AsyncApexJob resultOfExecution = [SELECT Status, NumberOfErrors 
                                          FROM AsyncApexJob 
                                          WHERE Id =:batchJobId];
        System.assertEquals(0, resultOfExecution.NumberOfErrors, 'Expected to have 0 errors at the batch job execution');
        
    }
    
    @isTest
    static void testBatchExecuteMethod() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        KYCGetCaseDecisionBatch batchJob = new KYCGetCaseDecisionBatch();
        List<Opportunity> oppList = [SELECT Id FROM Opportunity];
        oppList[0].KYCCaseID__c = '1111';
        
        Test.startTest();
            batchJob.execute(null, oppList);
        Test.stopTest();
        
    }
    
    @isTest
    static void testBatchFinishMethod() {
        
        KYCGetCaseDecisionBatch batchJob = new KYCGetCaseDecisionBatch();
        
        Test.startTest();
            batchJob.finish(null);
        Test.stopTest();
        
    }
    
}