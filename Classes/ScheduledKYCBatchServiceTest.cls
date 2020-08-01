@isTest 
public class ScheduledKYCBatchServiceTest {
    
    @testSetup
    static void testSetup() {
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
    static void testSchedule() {

		Test.StartTest();
        	ScheduledKYCBatchService scheduleJob = new ScheduledKYCBatchService();
			String schedule = '0 0 23 * * ?'; 
        	String jobId = System.schedule('Test 1', schedule, scheduleJob);
        Test.StopTest();
        
        System.assertEquals(false, String.isBlank(jobId), 'Expected to have a job id different than null or empty string');
        
    }
    
}