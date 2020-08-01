public class ScheduledKYCBatchService implements Schedulable {
    
	public void execute(SchedulableContext sc) {
        
        KYCGetCaseDecisionBatch batchInstance = new KYCGetCaseDecisionBatch();
        Database.executebatch(batchInstance, 90);

    }
}