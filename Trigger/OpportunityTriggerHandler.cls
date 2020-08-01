public class OpportunityTriggerHandler implements ITriggerHandler{

    public OpportunityTriggerHandler() { 
    }
    
    public void onBeforeInsert(List<SObject> newItems) {
        OpportunityService.calculateRiskIndicator(newItems, null);
        OpportunityService.setKYCRequestDateTimeOnInsert(newItems);
    }

    public void onBeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) { 
        OpportunityService.setKYCRequestDateTime(newItems, oldItems);
        OpportunityService.calculateRiskIndicator(newItems.values(), (Map<Id, Opportunity>) oldItems); 
    }
    
    public void onBeforeDelete(Map<Id, SObject> deletedOpptyLineItems) {
    }

    public void onAfterInsert(Map<Id, SObject> newItems) {
        OpportunityService.setInitialSalesRep(newItems.values());
        OpportunityService.initiateKYCAssessmentOnInsert(newItems);
    }

    public void onAfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        OpportunityService.initiateKYCAssessment(newItems, oldItems);        
    }

    public void onAfterDelete(Map<Id, SObject> newItems) {
    }
    
    public void onAfterUnDelete(Map<Id, SObject> newItems) {
    }
    
}