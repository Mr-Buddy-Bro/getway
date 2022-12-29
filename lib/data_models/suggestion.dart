class SuggestionModel{
  late final String docId;
  late final String text;
  late final String senderName;

  SuggestionModel(String docId, String text,String senderName,){
    this.text = text;
    this.senderName = senderName;
    this.docId = docId;
  }

  Map<String, dynamic> toJson() =>{
    'text':text,
    'senderName':senderName,
    'docId':docId,
  
  };
}