trigger LeadingCompetitor on Opportunity (before insert, before update) {

    for (Opportunity opp : Trigger.new) {

        System.debug(opp.Competitor_1__c ); 


        
    }

}