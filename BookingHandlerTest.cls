@IsTest
public class BookingHandlerTest {

    @IsTest static void testBookingLogic(){

        // Create a Travel Package
        Travel_Package__c tp = new Travel_Package__c(
            Name = 'Premium Package'
        );
        insert tp;

        // Create Booking
        Booking__c b = new Booking__c(
            Travel_Package__c = tp.Id, // use Id instead of string
            Booking_Date__c = Date.today()
        );
        insert b;

        // Query inserted booking
        Booking__c insertedBooking = [SELECT Status__c, VIP_Flag__c FROM Booking__c WHERE Id=:b.Id];
        System.assertEquals('Pending', insertedBooking.Status__c);
        System.assertEquals(true, insertedBooking.VIP_Flag__c);
    }
}
