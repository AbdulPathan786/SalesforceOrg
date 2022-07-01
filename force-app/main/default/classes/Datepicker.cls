public class Datepicker {
    public Set<String> disabledDates {get; set;}
    public String datesJson {get;set;}
    public Datepicker(){
        disabledDates =  new Set<String>();
        for(Contact con: [SELECT Birthdate FROM Contact WHERE Birthdate != NULL]){
            disabledDates.add(String.valueOf(con.Birthdate));
        }
        System.debug('dateValue' + (disabledDates));
        datesJson = JSON.serialize(disabledDates);
    }
}