class UserModel{
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String username;
  late final String password;
  late final String photoUrl;

  UserModel(String firstName, String lastName, String email, String username, String password, String photoUrl){
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.username = username;
    this.password = password;
    this.photoUrl = photoUrl;
  }

  Map<String, dynamic> toJson() =>{
    'firstname':firstName,
    'lastname':lastName,
    'email':email,
    'username':username,
    'password':password,
    'photoUrl':photoUrl,
  };
}