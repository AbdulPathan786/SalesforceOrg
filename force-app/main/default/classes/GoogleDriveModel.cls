//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//
public class GoogleDriveModel {
    public String kind;
    public String nextPageToken;
    public Boolean incompleteSearch;
    public List<Files> files;
    
    public class Files {
        public String kind;
        public String id;
        public String name;
        public String mimeType;
    }
    
    public static GoogleDriveModel parse(String json) {
        return (GoogleDriveModel) System.JSON.deserialize(json, GoogleDriveModel.class);
    }
}