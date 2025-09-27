public with sharing class TravelPackageController {

    // Fetch all Travel_Package__c records
    @AuraEnabled(cacheable=true)
    public static List<Travel_Package__c> getTravelPackages() {
        try {
            // Query only fields that exist in your org
            List<Travel_Package__c> packages = [
                SELECT Id, Package_Name__c, Destination__c, Price__c, Start_Date__c, End_Date__c, 
                       Total_Seats__c, Available_Seats__c, Booked_Seats__c, Remaining_Seats__c
                FROM Travel_Package__c
                ORDER BY Package_Name__c
            ];
            return packages;
        } catch(Exception e) {
            System.debug('Error fetching travel packages: ' + e.getMessage());
            return new List<Travel_Package__c>();
        }
    }
}
