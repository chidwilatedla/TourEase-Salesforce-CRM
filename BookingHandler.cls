public class BookingHandler {

    public static void beforeInsertUpdate(List<Booking__c> newBookings) {
        Set<Id> packageIds = new Set<Id>();

        // Collect all Travel Package Ids from new bookings
        for (Booking__c b : newBookings) {
            if (b.Travel_Package__c != null) {
                packageIds.add(b.Travel_Package__c);
            }
        }

        // Query Travel Packages
        Map<Id, Travel_Package__c> packageMap = new Map<Id, Travel_Package__c>(
            [SELECT Id, Name FROM Travel_Package__c WHERE Id IN :packageIds]
        );

        // Apply business logic
        for (Booking__c b : newBookings) {
            // Default status if not set
            if (String.isBlank(b.Status__c)) {
                b.Status__c = 'Pending';
            }

            // Mark VIP if package is "Premium"
            if (b.Travel_Package__c != null && packageMap.containsKey(b.Travel_Package__c)) {
                Travel_Package__c tp = packageMap.get(b.Travel_Package__c);
                if (tp.Name == 'Premium Package') {
                    b.VIP_Flag__c = true;
                }
            }
        }
    }

    public static void afterInsertUpdate(List<Booking__c> newBookings) {
        // Example notification logic (can be expanded later)
        BookingService.sendNotifications(newBookings);
    }
}
