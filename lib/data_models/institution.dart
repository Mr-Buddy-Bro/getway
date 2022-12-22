class InstitutionModel{
  late final String displayName;
  late final String description;
  late final String hoi;
  late final String contactNo;
  late final String shortName;
  late final String landmark;
  late final String city;
  late final String district;
  late final String pincode;
  late final String username;
  late final String photoUrl;

  InstitutionModel(String displayName, String description, String hoi, String contactNo, String shortName, 
  String landmark, String city, String district, String pincode, String username, String photoUrl){
    this.displayName = displayName;
    this.description = description;
    this.hoi = hoi;
    this.contactNo = contactNo;
    this.shortName = shortName;
    this.landmark = landmark;
    this.city = city;
    this.district = district;
    this.pincode = pincode;
    this.username = username;
    this.photoUrl = photoUrl;
  }

  Map<String, dynamic> toJson() =>{
    'displayName':displayName,
    'description':description,
    'hoi':hoi,
    'contactNo':contactNo,
    'shortName':shortName,
    'landmark':landmark,
    'city':city,
    'district':district,
    'pincode':pincode,
    'username':username,
    'photoUrl':photoUrl,
  };


}