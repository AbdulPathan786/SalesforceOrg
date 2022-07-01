public class ContactRichTextArea {
    public Contact objContact{get;set;}
    public string textStr {get;set;}
    
    public ContactRichTextArea(){
        objContact = [SELECT Id, Rich_Text_Area__c FROM Contact WHERE Id = '0032w00000eRD4MAAW'];
        textStr = objContact.Rich_Text_Area__c.stripHtmlTags();
    }
}
//https://salesforceglobe4u.blogspot.com/2016/04/how-to-remove-html-tags-from-rich-text.html