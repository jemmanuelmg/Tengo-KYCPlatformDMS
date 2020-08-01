global class KYCGetCaseDecisionBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        
        String query = KYCPlatformService.getCaseDecisionBatchQuery();
        return Database.getQueryLocator(query);
        
    }
    
    global void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        
        KYCPlatformService.getCaseDecisionBatch(scope);
        
    }   
    
    global void finish(Database.BatchableContext bc) {
        
    }
    
}