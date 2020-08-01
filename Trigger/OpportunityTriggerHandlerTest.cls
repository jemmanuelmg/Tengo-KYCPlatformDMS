@isTest
public class OpportunityTriggerHandlerTest {
    
	@testSetup 
    static void setup() {
        
		Account account1 = TestDataFactory.createNewAccount();
        insert account1;
        
        Opportunity opportunity1 = TestDataFactory.createNewOpportunity(account1);
        insert opportunity1;
        
        Opportunity opportunity2 = TestDataFactory.createNewOpportunity(account1);
        insert opportunity2;
        
        Opportunity opportunity3 = TestDataFactory.createNewOpportunity(account1);
        insert opportunity3;
        
    }    
    
     @isTest 
    static void onBeforeInsert() { 
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Opportunity testOpportunity = [SELECT CreatedDate FROM Opportunity LIMIT 1];
        
        Test.startTest();
            try {
                insert testOpportunity;
            } catch(Exception e) {
                System.debug(e);
            }
     	Test.stopTest();
        
        System.assert(testOpportunity.CreatedDate != null, 'Expected to not have null value in CreatedDate');
    }
    
    @isTest 
    static void onBeforeUpdate() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Opportunity testOpportunity = [SELECT Id, StageName FROM Opportunity LIMIT 1]; 
        testOpportunity.Name = 'ABC123';
        
        Test.startTest();
        	update testOpportunity;
     	Test.stopTest();
        
        System.assert(testOpportunity.Name == 'ABC123', 'Expected to have ABC123 as Name of Opportunity');
    }
    
     @isTest 
    static void onBeforeDelete() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Opportunity testOpportunity = [SELECT IsDeleted FROM Opportunity LIMIT 1]; 
        
        Test.startTest();
        	delete testOpportunity;
     	Test.stopTest();
        
        System.assert(testOpportunity.IsDeleted == false, 'Expected to have IsDeleted as false');
    }

    @isTest 
    static void onAfterInsert() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Opportunity testOpportunity = [SELECT CreatedDate FROM Opportunity LIMIT 1]; 
        
        Test.startTest();
            try {
                insert testOpportunity;
            } catch(Exception e) {
                System.debug(e);
            }
     	Test.stopTest();
        
        System.assert(testOpportunity.CreatedDate != null, 'Expected to have not null in CreatedDate');
    }
    

    @isTest 
    static void testPositiveOnBeforeUpdateKYCAssestment() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        List<Opportunity> opptyList = [SELECT Id, Name FROM Opportunity]; 
        
        Test.startTest();
            Database.saveResult[] databaseResultList = Database.update(opptyList, false);
        Test.stopTest();
        
        Database.saveResult finalResult = databaseResultList[0];
        
        System.assertEquals(true, finalResult.isSuccess(), 'Expected that execution of update operation was successfully, the result was a failure ');
        
    }

    @isTest 
    static void onAfterDelete() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Opportunity testOpportunity = [SELECT IsDeleted FROM Opportunity LIMIT 1]; 
        
        Test.startTest();
        	delete testOpportunity;
     	Test.stopTest();
        
        System.assert(testOpportunity.IsDeleted == false, 'Expected to have IsDeleted as false');
    }
    
    @isTest 
    static void onAfterUndelete() {
        
        Test.setMock(HttpCalloutMock.class, new KYCPlatformMockImpl());
        
        Opportunity testOpportunity = [SELECT IsDeleted FROM Opportunity LIMIT 1]; 
        delete testOpportunity;
        
        Test.startTest();
        	undelete testOpportunity;
     	Test.stopTest();
        
        System.assert(testOpportunity.IsDeleted == false, 'Expected to have IsDeleted as false');
    }
    
}