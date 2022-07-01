public class StudentSummaryController {
    public List<AggregateResult> lstStudentsSummary {get;set;}
    
    public StudentSummaryController(){
        
       lstStudentsSummary = [ SELECT  count(Id) cnt, sum(Fee__c) sum, avg(Fee__c) avg, max(Fee__c) max, min(Fee__c) min, city__c
                          		FROM Student__c
                          		group by city__c
                         		order by city__c desc
                            ];
        if ( lstStudentsSummary.size() > 0){
            for(AggregateResult obj : lstStudentsSummary)    {
                System.debug(obj.get('city__c') + ' : Count = ' + obj.get('cnt')+ ' : Sum = ' + obj.get('sum') + ' : Average = ' + obj.get('avg') + ' : Maximum = ' + obj.get('max') + ' : Minimum = ' + obj.get('min'));
            } 
        }
    }
}