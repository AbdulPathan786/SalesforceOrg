/*
* @Name         : DistanceRoutePathController
* @Author       : Abdul Pathan
* @Date         : 10 March, 2020
* @Description  : Distance Route Path
*/
@RestResource(urlMapping='/iBirds/RouteManagements/*')
global class DistanceRoutePathController {
    public String source{get;set;}
    public String destination{get;set;}
    public Decimal totalDistance{get;set;}
    public String mainRoute{get;set;}
    public String fastRoute{get;set;}
    public String timeValue{get;set;}
    
    public List<Route__c> lstRoute{get;set;}
    private Map<String, Route_Station__c> mapRouteStation ;
    public Map<String, Decimal> mapStation{get;set;}
    public List<RouteMapModel> lstRouteMapModel;
    public List<RouteMapModel> lstRouteMap;
    
    // constructor 
    public DistanceRoutePathController(){
       lstRouteMapModel = new List<RouteMapModel>();
        totalDistance = 0.0;
        timeValue = '';
        fastRoute = 'Fastest route, despite the usual traffic';
        lstRoute = new List<Route__c>();
    }
    
    // onchange method
    public void distanceRouteBetween(){
        timeValue = '';
        totalDistance = 0.0;
        //fastRoute = 'Fastest route, despite the usual traffic';
        mapStation = new  Map<String, Decimal>();
        mapRouteStation = new  Map<String, Route_Station__c>();
        lstRoute = [SELECT Name, 
                    (SELECT Name, Distance__c, Previous_Station__r.Name, Main_Route__r.Name FROM Route_Stations__r)
                    FROM Route__c
                   ];
        for(Route__c objRoute : lstRoute ){
            mapRouteStation = new Map<String, Route_Station__c>();
            for(Route_Station__c objStation : objRoute.Route_Stations__r){
                mapRouteStation.put(objStation.Name, objStation);
               // System.debug('mapRouteStation' + mapRouteStation);
                distanceFunction();
                if(totalDistance > 0){
                    mapStation.put(objRoute.Name, totalDistance);
                        System.debug('mapStation' + mapStation);
                }
            } System.debug('mapRouteStation1111111' + mapRouteStation);
            RouteMapModel objMapRoute = new RouteMapModel();
            objMapRoute.destination = destination;
            objMapRoute.source = source;
            objMapRoute.walking = 'walking';
            objMapRoute.highway = 'highway';
            objMapRoute.bicycle = 'bicycle';
            objMapRoute.car = '';
            objMapRoute.train = '';
            objMapRoute.plane ='';
            objMapRoute.walkingTime =0.0; 
            objMapRoute.bicycleTime = 0.0;
            objMapRoute.carTime =  0.0;
            objMapRoute.trainTime = 0.0;
            objMapRoute.planeTime = 0.0;
           // System.debug('objRoute' + objMapRoute);
            }
        }
    
    // call method
    public void  distanceFunction(){
        if(String.isBlank(source) || String.isBlank(destination)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter value'));
        }
        else if(source == destination){
            totalDistance = 0.0;
        }
        else{
            if(mapRouteStation.ContainsKey(source)){//true
                System.debug('mapRouteStation.get(source)   => '+ mapRouteStation.get(source));
                Route_Station__c value = mapRouteStation.get(source);
                totalDistance = value.Distance__c;
                System.debug('value   => '+ value);
                System.debug('totalDistance'+ totalDistance);
                
                while(value.Previous_Station__r.Name != destination){
                    if( mapRouteStation.ContainsKey(value.Previous_Station__r.Name) ){
                        value = mapRouteStation.get(value.Previous_Station__r.Name);
                        System.debug('valuaaaaa :  ' + value);
                        totalDistance = totalDistance + value.Distance__c;
                        mainRoute = value.Main_Route__r.Name;
                        
                        Decimal timeDec = (totalDistance / 60).setScale(2);
                        String str1 = String.valueOf(timeDec);
                        String[] str2 = str1.split('\\.');
                        timeValue = str2[0] + ' h ' + str2[1] + ' min';
                    }
                    else{
                        totalDistance = 0.0;
                        break;  
                    }
                }  
            }
            if(mapRouteStation.ContainsKey(destination) && totalDistance == 0){
                Route_Station__c value = mapRouteStation.get(destination);
                totalDistance = value.Distance__c;
                while(value.Previous_Station__r.name != source){
                    if( mapRouteStation.ContainsKey(value.Previous_Station__r.Name) ){
                        value = mapRouteStation.get(value.Previous_Station__r.Name);
                        totalDistance = totalDistance + value.Distance__c;
                        mainRoute = value.Main_Route__r.Name;
                        Decimal timeDec = (totalDistance / 60).setScale(2);
                        String str1 = String.valueOf(timeDec);
                        String[] str2 = str1.split('\\.');
                        timeValue = str2[0] + ' h ' + str2[1] + ' min';
                    }
                    else{
                        totalDistance = 0.0;
                        break;  
                    }
                }
            }
            
        }            
    }
    /*
    @HttpGet
    global static Route_Station__c doGetRouteStations(){
         // RestRequest request = RestContext.request;
         Route_Station__c result =  [SELECT Id, Previous_Station__c, Distance__c, Main_Route__c, Name
                                    FROM Route_Station__c WHERE Id = : 'a0Q2w0000006fRHEAY'
                                   ];
        return result;
    }*/
    @HttpGet
    global static List<RouteMapModel> getDistance(){
        DistanceRoutePathController rmap = new DistanceRoutePathController();
        rmap.source =  RestContext.request.params.get('source');
        rmap.destination = RestContext.request.params.get('destination');
        //rmap.source =  'Ajmer';
        //rmap.destination = 'Jaipur';
        // system.debug('rmp.source'+rmap.source);
        // system.debug('rmp.source'+rmap.destination);
        rmap.distanceRouteBetween();
        //  return rmp.mapRoute;
        return rmap.lstRouteMapModel;
    }
}