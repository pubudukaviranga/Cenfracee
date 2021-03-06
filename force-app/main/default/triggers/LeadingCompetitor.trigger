trigger LeadingCompetitor on Opportunity (before insert, before update) {

    for (Opportunity opp : Trigger.new) {

        //Add all our prices in a list in order of competitor

        List<Decimal> CompetitorPrices = new List<Decimal>();
        CompetitorPrices.add(opp.Competitor_1_Price__c);
        CompetitorPrices.add(opp.Competitor_2_Price__c);
        CompetitorPrices.add(opp.Competitor_3_Price__c);
        
        //Add all our competitors in a list in order
        List<String> CompetitorNames = new List<String>();
        CompetitorNames.add(opp.Competitor_1__c);
        CompetitorNames.add(opp.Competitor_2__c);
        CompetitorNames.add(opp.Competitor_3__c);

        // loop through all competitors to find the position of the lowest price

        Decimal lowestPrice;
        Integer lowestPricePosition;

        for (Integer i = 0; i < CompetitorPrices.size(); i++) {

            Decimal currentPrice = CompetitorPrices.get(i);
            if(lowestPrice == null || currentPrice < lowestPrice){
                lowestPrice         = currentPrice;
                lowestPricePosition = i;
            }            
        }

        Decimal highestPrice;
        Integer highestPricePosition;

        for (Integer i = 0; i < CompetitorPrices.size(); i++) {

            Decimal currentPrice = CompetitorPrices.get(i);
            if(highestPrice == null || currentPrice > highestPrice){
                highestPrice         = currentPrice;
                highestPricePosition = i;
            }            
        }

        // Populate the leading competitor field with the competitor matching the lowest price position

        System.debug(lowestPricePosition);

        opp.Leading_Competitor__c        = CompetitorNames.get(lowestPricePosition); 
        opp.Leading_Competitor_Price__c  = CompetitorPrices.get(lowestPricePosition);
        
        opp.Most_Expensive_Competitor__c = CompetitorNames.get(highestPricePosition);
        opp.Expensive_Price__c           = CompetitorPrices.get(highestPricePosition);
        
        //System.debug(opp.Competitor_1__c ); 
        
    }

}