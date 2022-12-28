class RoomModel{
  late final String docId;
  late final String roomLabel;
  late final String blockName;
  late final String floor;
  late final String contactNo;
  late final String description;

  RoomModel(String roomLabel, String blockName, String floor, String contactNo, String description, String docId){
    this.roomLabel = roomLabel;
    this.blockName = blockName;
    this.floor = floor;
    this.contactNo = contactNo;
    this.description = description;
    this.docId = docId;
  }

  Map<String, dynamic> toJson() =>{
    'roomLabel':roomLabel,
    'blockName':blockName,
    'floor':floor,
    'contactNo':contactNo,
    'description':description,
    'docId':docId,
  
  };
}