@isTest
global class GoogleBooksCalloutsMockData implements HttpCalloutMock {
    Private Integer StatusCode; 
    global GoogleBooksCalloutsMockData(Integer StatusCode){
        this.StatusCode = StatusCode;
    }
    //Implement this interface method
    global HTTPResponse respond(HTTPRequest request){
        //Creating a fake response by the status code
        HttpResponse response = new HttpResponse();
        string responseBody = '{"kind": null, "totalItems": 2, "items": [{"kind": null, "id": "7B6cNaP-iwwC","etag": null, "selfLink": null,"volumeInfo": { "title": null,"authors": [ null],"publishedDate": null,"description": null,"pageCount": null, "printType": null, "categories": [ null ], "averageRating": null,"ratingsCount": null, "imageLinks": { "smallThumbnail": null,"thumbnail": null}}}]}';
        //String responseBody = '{"kind": "books#volumes", "totalItems": 2, "items": [{"kind": "books#volume", "id": "7B6cNaP-iwwC","etag": "2y0J8BwfAoA", "selfLink": "https://content-books.googleapis.com/books/v1/volumes/7B6cNaP-iwwC","volumeInfo": { "title": "Dont Touch", "authors": [ "Elise VanCise"],"publishedDate": "2008-07-24", "description": "Dr Ryan Reign has unlocked a gift she calls a curse. Detective Jackson Prince and his partner need her help to stop a serial killer before he kills again. One problem Dr. Reign cant touch or be touched. Can the hard as nails cop Jackson find a ...","pageCount": 184, "printType": "BOOK", "categories": [ "Florida" ], "averageRating": 5,"ratingsCount": 1, "imageLinks": { "smallThumbnail": "http://books.google.com/books/content?id=7B6cNaP-iwwC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api","thumbnail": "http://books.google.com/books/content?id=7B6cNaP-iwwC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"}}}]}';
        // String jsonString = '{"kind": "books#volumes", "totalItems": 2, "items": [{"kind": "books#volume", "id": "7B6cNaP-iwwC","etag": "2y0J8BwfAoA", "selfLink": "https://content-books.googleapis.com/books/v1/volumes/7B6cNaP-iwwC","volumeInfo": { "title": "Dont Touch", "authors": [ "Elise VanCise"],"publishedDate": "2008-07-24", "description": "Dr Ryan Reign has unlocked a gift she calls a curse. Detective Jackson Prince and his partner need her help to stop a serial killer before he kills again. One problem Dr. Reign cant touch or be touched. Can the hard as nails cop Jackson find a ...","pageCount": 184, "printType": "BOOK", "categories": [ "Florida" ], "averageRating": 5,"ratingsCount": 1, "imageLinks": { "smallThumbnail": "http://books.google.com/books/content?id=7B6cNaP-iwwC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api","thumbnail": "http://books.google.com/books/content?id=7B6cNaP-iwwC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"}}}]}';
        // GoogleBooksCallouts.GoogleBooksResponse obj1 = (GoogleBooksCallouts.GoogleBooksResponse) JSON.deserialize(jsonString, GoogleBooksCallouts.GoogleBooksResponse.Class);
        // String responseBody = JSON.serialize(obj1);
        response.setHeader('Accept', 'application/json');
        response.setHeader('Content-Type', 'application/json');
        response.setHeader('Content-Length', '0');
        if(StatusCode == 201){
            response.setBody(responseBody);
            response.setStatusCode(201);
            response.setStatus('Ok');
        }else{
            response.setBody(responseBody);
            response.setStatusCode(200);
            response.setStatus('Ok');
        }
        return response;
    }     
}

    
    /*
    //searchBooks
    global HTTPResponse searchBooksRespond(HTTPRequest req) {
        HttpResponse response  = new HttpResponse();
        String responseBody = '{"kind":"books#volumes","totalItems":4351,"items":[{"kind":"books#volume","id":"3K3JU4qmRCkC","etag":"EV7JZX8Xbfw","selfLink":"https://content-books.googleapis.com/books/v1/volumes/3K3JU4qmRCkC","volumeInfo":{"title":"How to Read a Person Like a Book","authors":["Gerard Nierenberg","Henry H. Calero"],"publisher":"Simon and Schuster","publishedDate":"1971","description":"Text and illustrations provide instructions on how to interpret the body language of others.","industryIdentifiers":[{"type":"ISBN_13","identifier":"9780671735579"},{"type":"ISBN_10","identifier":"0671735578"}],"readingModes":{"text":false,"image":false},"pageCount":180,"printType":"BOOK","categories":["Business & Economics"],"averageRating":4.5,"ratingsCount":4,"maturityRating":"NOT_MATURE","allowAnonLogging":false,"contentVersion":"preview-1.0.0","imageLinks":{"smallThumbnail":"http://books.google.com/books/content?id=3K3JU4qmRCkC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api","thumbnail":"http://books.google.com/books/content?id=3K3JU4qmRCkC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"},"language":"en","previewLink":"http://books.google.co.in/books?id=3K3JU4qmRCkC&printsec=frontcover&dq=a&hl=&cd=1&source=gbs_api","infoLink":"http://books.google.co.in/books?id=3K3JU4qmRCkC&dq=a&hl=&source=gbs_api","canonicalVolumeLink":"https://books.google.com/books/about/How_to_Read_a_Person_Like_a_Book.html?hl=&id=3K3JU4qmRCkC"},"saleInfo":{"country":"IN","saleability":"NOT_FOR_SALE","isEbook":false},"accessInfo":{"country":"IN","viewability":"PARTIAL","embeddable":true,"publicDomain":false,"textToSpeechPermission":"ALLOWED_FOR_ACCESSIBILITY","epub":{"isAvailable":false},"pdf":{"isAvailable":false},"webReaderLink":"http://play.google.com/books/reader?id=3K3JU4qmRCkC&hl=&printsec=frontcover&source=gbs_api","accessViewStatus":"SAMPLE","quoteSharingAllowed":false},"searchInfo":{"textSnippet":"Text and illustrations provide instructions on how to interpret the body language of others."}}]}';
        response .setHeader('Accept', 'application/json');
        response .setHeader('Content-Type', 'application/json');
        response .setBody(responseBody);
        response .setStatusCode(200);
        response .setStatus('Ok');
        return response ;
    }
    
    //insertBooks deleteBooks
    global HTTPResponse insertBooks(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        String responseBody = '{"kind":"books#volume","id":"Y7sOAAAAIAAJ","etag":"MMrvOJp8dJo","selfLink":"https://content-books.googleapis.com/books/v1/volumes/Y7sOAAAAIAAJ","volumeInfo":{"title":"Alices Adventures in Wonderland","authors":["Lewis Carroll"],"publisher":"W.B. Conkey","publishedDate":"1920","description":"In the most renowned novel by English author Lewis Carroll, restless young Alice literally stumbles into adventure when she follows the hurried, time-obsessed White Rabbit down a hole and into a fantastical realm where animals are quite verbose, logic is in short supply, and royalty tends to be exceedingly unpleasant. Each playfully engaging chapter presents absurd scenarios involving an unforgettable cast of characters, including the grinning Cheshire Cat and the short-tempered Queen of Hearts, and every stop on peculiar journey is marked by sharp social satire and wondrously witty wordplay.","readingModes":{"text":true,"image":true},"pageCount":200,"printedPageCount":230,"dimensions":{"height":"18.00 cm"},"printType":"BOOK","averageRating":4,"ratingsCount":1532,"maturityRating":"NOT_MATURE","allowAnonLogging":false,"contentVersion":"1.6.8.0.full.3","panelizationSummary":{"containsEpubBubbles":false,"containsImageBubbles":false},"imageLinks":{"smallThumbnail":"http://books.google.com/books/content?id=Y7sOAAAAIAAJ&printsec=frontcover&img=1&zoom=5&edge=curl&imgtk=AFLRE70QhL_1xs0W4z1gFLpRpVU-zGuX3gz56TL-bwyufm3OeNIfp-VRP3NPl4_m9WvQ_g8E3dKnXQINDdXRfOnWh0yHgGXbnNudHW_lBPRUjloW9KYSdS0&source=gbs_api","thumbnail":"http://books.google.com/books/content?id=Y7sOAAAAIAAJ&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE73a_ZSJH-WRVBKtgAmenPsYDbstfbi_WIwxMiGEb_h3X9uu6SDJmgtn9HU600epddhAHu7BpIjEdaUBAuN5dYdMP6oTwhpo7MhSuRQWC60c2g8vrNo&source=gbs_api","small":"http://books.google.com/books/content?id=Y7sOAAAAIAAJ&printsec=frontcover&img=1&zoom=2&edge=curl&imgtk=AFLRE73djLqE-Sqxp1jpaSL0FYd5ZROMM6fDcLdrPexn9xhkpYfPhQWCOT-7sk7iaKacSnqxyeE5hVod3rg-9jN1A9ReKDmVAfaxGJ0Vpj6JamrNps4RJ_c&source=gbs_api","medium":"http://books.google.com/books/content?id=Y7sOAAAAIAAJ&printsec=frontcover&img=1&zoom=3&edge=curl&imgtk=AFLRE70eY7-Gw2AFaG7Ycclv48nYTZwAEgyCF01b7xZ-TY_Ybko3vgmvii8F9mYGP_u0P3jXRHZk_R-felJkldtCpFWe_tIj6HUmIJ2TEBdg7JwdtTRn5kk&source=gbs_api","large":"http://books.google.com/books/content?id=Y7sOAAAAIAAJ&printsec=frontcover&img=1&zoom=4&edge=curl&imgtk=AFLRE70KNoCG9snWGdALxeObCT9qtl9GAruvp6ot9AkBCbZGYZQVs2vmTxBwkBCvJ8-fCGu8CqW7S7-8xOnLQE0DXh4LceL_hEfZvAy1cxXhPP8qsFrNcCY&source=gbs_api","extraLarge":"http://books.google.com/books/content?id=Y7sOAAAAIAAJ&printsec=frontcover&img=1&zoom=6&edge=curl&imgtk=AFLRE73agfJ61KsKPyVuVYXzfGm9W0fR8N9OCwmbWWfHgdS_NIRvTw3fAlDnscpxGu611QWF9llTdD7YJOFwGbewjml3-5fp3vW9Pmqdlj1vJOC-1jinIgk&source=gbs_api"},"language":"en","previewLink":"http://books.google.co.in/books?id=Y7sOAAAAIAAJ&hl=&source=gbs_api","infoLink":"https://play.google.com/store/books/details?id=Y7sOAAAAIAAJ&source=gbs_api","canonicalVolumeLink":"https://play.google.com/store/books/details?id=Y7sOAAAAIAAJ"},"layerInfo":{"layers":[{"layerId":"geo","volumeAnnotationsVersion":"24"}]},"userInfo":{"updated":"2022-01-05T12:50:52.617Z"},"saleInfo":{"country":"IN","saleability":"FREE","isEbook":true,"buyLink":"https://play.google.com/store/books/details?id=Y7sOAAAAIAAJ&rdid=book-Y7sOAAAAIAAJ&rdot=1&source=gbs_api"},"accessInfo":{"country":"IN","viewability":"ALL_PAGES","embeddable":true,"publicDomain":true,"textToSpeechPermission":"ALLOWED","epub":{"isAvailable":true,"downloadLink":"http://books.google.co.in/books/download/Alice_s_Adventures_in_Wonderland.epub?id=Y7sOAAAAIAAJ&hl=&output=epub&source=gbs_api"},"pdf":{"isAvailable":true,"downloadLink":"http://books.google.co.in/books/download/Alice_s_Adventures_in_Wonderland.pdf?id=Y7sOAAAAIAAJ&hl=&output=pdf&sig=ACfU3U0LJuWczqOh8hN2H4-DDF1Ym-Vr7g&source=gbs_api"},"webReaderLink":"http://play.google.com/books/reader?id=Y7sOAAAAIAAJ&hl=&printsec=frontcover&source=gbs_api","accessViewStatus":"FULL_PUBLIC_DOMAIN","quoteSharingAllowed":false}}';
       
        req.setHeader('Content-Length', '0');
        res.setBody(responseBody);
        res.setStatusCode(200);
        res.setStatus('Ok');
        return res;
    }*/// req.setHeader('Accept', '*/*');