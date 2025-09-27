public class BookingService {
    public static void sendNotifications(List<Booking__c> bookings){
        for(Booking__c b : bookings){
            if(b.Contact__c != null){
                List<Contact> contacts = [
                    SELECT Id, Email 
                    FROM Contact 
                    WHERE Id = :b.Contact__c
                    LIMIT 1
                ];
                if(!contacts.isEmpty()){
                    Contact c = contacts[0];
                    System.debug('📧 Sending notification to: ' + c.Email);
                }
            }
        }
    }
}
