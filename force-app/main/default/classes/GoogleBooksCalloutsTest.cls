@isTest
private class GoogleBooksCalloutsTest {
    @isTest static void testGetGoogleBooks(){ 
        Test.setMock(HttpCalloutMock.class, new GoogleBooksCalloutsMockData(201));        
        Test.startTest();
         GoogleBooksCallouts.getGoogleBooks();
       // GoogleBooksCallouts.GoogleBooksResponse obj1 = new GoogleBooksCallouts.GoogleBooksResponse();
        //obj1 = GoogleBooksCallouts.getGoogleBooks();
        //obj1.kind = 'ab';
        Test.stopTest();
    } 
    @isTest static void testSearchBooks(){ 
        Test.setMock(HttpCalloutMock.class, new GoogleBooksCalloutsMockData(201));
        Test.startTest();
        GoogleBooksCallouts.searchBooks('hari');
        Test.stopTest();
    } 
    @isTest static void testInsertBooks(){ 
        Test.setMock(HttpCalloutMock.class, new GoogleBooksCalloutsMockData(201));
        Test.startTest();
        GoogleBooksCallouts.insertBooks('7B6cNaP-iwwC');
        Test.stopTest();
    } 
    @isTest static void testDeleteBooks(){ 
        Test.setMock(HttpCalloutMock.class, new GoogleBooksCalloutsMockData(201));
        Test.startTest();
        GoogleBooksCallouts.deleteBooks('7B6cNaP-iwwC');
        Test.stopTest();
    } 
}