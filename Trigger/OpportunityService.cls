public class OpportunityService {
    
    public static void setKYCRequestDateTime(Map<Id, SObject> newOpportunitiesMap, Map<Id, SObject> oldOpportunitiesMap) {
                
        for (Id currentId : newOpportunitiesMap.keySet()) {
            Opportunity currentOppty = (Opportunity) newOpportunitiesMap.get(currentId);
            Opportunity oldValue = (Opportunity) oldOpportunitiesMap.get(currentId);
            if ((oldValue.InitiateKYCAssessment__c == false && currentOppty.InitiateKYCAssessment__c == true) && currentOppty.KYCAssessmentRequest__c == null) {
                currentOppty.KYCAssessmentRequest__c = Datetime.now();
            }
        }
        
    }
    
    public static void setKYCRequestDateTimeOnInsert(List<Opportunity> opptyList) {
                
        for (Opportunity currentOppty : opptyList) {
            if ((currentOppty.InitiateKYCAssessment__c == true) && currentOppty.KYCAssessmentRequest__c == null) {
                currentOppty.KYCAssessmentRequest__c = Datetime.now();
            }
        }
        
    }
    
    public static void initiateKYCAssessment(Map<Id, SObject> newOpportunitiesMap, Map<Id, SObject> oldOpportunitiesMap) {
        
        List<id> opptyIds = new List<id>();
        for (Id currentId : newOpportunitiesMap.keySet()) {
            Opportunity currentOppty = (Opportunity) newOpportunitiesMap.get(currentId);
            Opportunity oldValue = (Opportunity) oldOpportunitiesMap.get(currentId);
            if ((oldValue.InitiateKYCAssessment__c == false && currentOppty.InitiateKYCAssessment__c == true) && String.isBlank(currentOppty.KYCCaseID__c)) {       
                opptyIds.add(currentId);
            }
        }
        
        if (!opptyIds.isEmpty()) {
            KYCPlatformService.createCasesForOpportunities(opptyIds);
        }
        
    }
    
    public static void initiateKYCAssessmentOnInsert(Map<Id, SObject> newOpportunitiesMap) {
        
        List<id> opptyIds = new List<id>();
        for (Id currentId : newOpportunitiesMap.keySet()) {
            Opportunity currentOppty = (Opportunity) newOpportunitiesMap.get(currentId);
            if ((currentOppty.InitiateKYCAssessment__c == true) && String.isBlank(currentOppty.KYCCaseID__c)) {       
                opptyIds.add(currentId);
            }
        }
        
        if (!opptyIds.isEmpty()) {
            KYCPlatformService.createCasesForOpportunities(opptyIds);
        } 
        
    }
    
    public static void setInitialSalesRep(List<Opportunity> newItems) {
        List<OpportunityTeamMember> updOpptm = new List<OpportunityTeamMember>();
        Set<Id> oppIds = new Set<Id>();
        for (Opportunity opp: newItems) {
            oppIds.add(opp.Id);
        }
        List<OpportunityTeamMember> allTm = [SELECT Id, TeamMemberRole, UserId, SalesRep__c FROM OpportunityTeamMember WHERE OpportunityId IN :oppIds];

        if (!allTm.isEmpty()) {
            for (OpportunityTeamMember otm: allTm) {
                if (otm.TeamMemberRole != 'Sales Rep' && otm.SalesRep__c == true) {
                    otm.TeamMemberRole = 'Sales Rep';
                    updOpptm.add(otm);
                }
            }
            if (!updOpptm.isEmpty()) {
                update updOpptm;
            }
        }
    }

    public static void calculateRiskIndicator(List<Opportunity> newItems, Map<Id, Opportunity> oldItems) {
        List<Opportunity> updOpp = new List<Opportunity>();
        Set<Id> oppCountry = new Set<Id>();
        Set<Id> oppStrategy = new Set<Id>();
        Set<Id> oppRegulator = new Set<Id>();
        Set<Id> oppAML = new Set<Id>();
        Set<Id> oppDomicile = new Set<Id>();        
        Set<Opportunity> opportunityInvolved = new Set<Opportunity>();
        for (Opportunity opp: newItems) {
            Boolean isInsert = (oldItems== null ? true : false);
            if ((isInsert && opp.InvestmentManager__c != null) || (!isInsert && (opp.InvestmentManager__c != oldItems.get(opp.Id).InvestmentManager__c))) {
                oppCountry.add(opp.Id);
                oppRegulator.add(opp.Id);
                opportunityInvolved.add(opp);
            }
            if ((isInsert && opp.AMLDelegate__c != null) || (!isInsert && (opp.AMLDelegate__c != oldItems.get(opp.Id).AMLDelegate__c))
            || (isInsert && opp.Administrator__c != null) || (!isInsert && (opp.Administrator__c != oldItems.get(opp.Id).Administrator__c))) {
                oppAML.add(opp.Id);
                opportunityInvolved.add(opp);
            }
            if ((isInsert && opp.Strategy__c != null) || (!isInsert && (opp.Strategy__c != oldItems.get(opp.Id).Strategy__c))) {
                oppStrategy.add(opp.Id);
                opportunityInvolved.add(opp);
            }            
            if ((isInsert && opp.Domicile__c != null) || (!isInsert && (opp.Domicile__c != oldItems.get(opp.Id).Domicile__c))) {
                oppDomicile.add(opp.Id);
                opportunityInvolved.add(opp);
            }
        }

        if (!opportunityInvolved.isEmpty()) {
            List<Opportunity> oppList = new List<Opportunity>(opportunityInvolved);
            Map<Id,Map<String,String>> oppRisk = RiskAssessmentService.calculateOpportunityRisk(oppList);
            for (Opportunity opp: opportunityInvolved) {
                if (oppCountry.contains(opp.Id)) {
                    String imRisk = oppRisk.get(opp.Id).get('IM Domicile Risk');
                    if (imRisk.contains(';')) {
                        imRisk = imRisk.removeEnd(';');
                        opp.AMLDelegateDomicileRisk__c = 'High';
                    }                    
                    opp.InvestmentManagerDomicileRisk__c = imRisk;                                        
                }
                if (oppStrategy.contains(opp.Id)) {
                    opp.StrategyRisk__c = oppRisk.get(opp.Id).get('Strategy Risk');                                        
                }
                if (oppRegulator.contains(opp.Id)) {
                    opp.InvestmentManagerRegulatorRisk__c = oppRisk.get(opp.Id).get('Regulator Risk');
                }
                if (oppDomicile.contains(opp.Id)) {
                    opp.ClientEntityDomicileRisk__c = oppRisk.get(opp.Id).get('Domicile Risk');
                }
                if (oppAML.contains(opp.Id)) {
                    opp.AMLDelegateDomicileRisk__c = oppRisk.get(opp.Id).get('AML Domicile Risk');                                                                                
                }                                
            }        
        }        
    }    
}