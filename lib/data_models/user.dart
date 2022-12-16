class UserModel{
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String username;
  late final String password;

  UserModel(String firstName, String lastName, String email, String username, String password){
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.username = username;
    this.password = password;
  }

  Map<String, dynamic> toJson() =>{
    'firstname':firstName,
    'lastname':lastName,
    'email':email,
    'username':username,
    'password':password,
  };
}