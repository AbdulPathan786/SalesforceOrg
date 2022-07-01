global class RouteMapModel {
    public String requestStatus;
    public String errorMessage;
    public String source{get;set;}
    public String destination{get;set;}
    public String highway{get;set;}
    public Decimal totalDistance;
    public String walking, bicycle, car, train, plane;
    public Double walkingTime, bicycleTime, carTime, trainTime, planeTime;
}

/*
    @HttpGet
    global static Route_Station__c doGetRouteStations(){
         // RestRequest request = RestContext.request;
         Route_Station__c result =  [SELECT Id, Previous_Station__c, Distance__c, Main_Route__c, Name
                                    FROM Route_Station__c WHERE Id = : 'a0Q2w0000006fRHEAY'
                                   ];
        return result;*/
       /* Route_Station__c station = new Route_Station__c();
            map<String, String> paramMap=new RestContext.request.params;
            String stationId = paramMap.get('id');
            station =  [SELECT Id, Previous_Station__c, Distance__c, Main_Route__c, Name
                        FROM Route_Station__c WHERE Id = : 'a0Q2w0000006fRHEAY'
                       ];
            return station;*/
 /*   }
    @httpPost
    global static String doCreateRouteStations(){
        return 'a';
    }
    @httpDelete
    global static String doDeleteRouteStations(){
        return 'b';
    }
    @HttpPut
    global static String doputRouteStations(){
        return 'c';
    }    
    @httpPatch
    global static String doUpsertRouteStations(){
        return 'd';
    }
 */
// /services/apexrest/iBirds/BookManagement/