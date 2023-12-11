class Users {
  String? token;
  String? username;
  String? first_name;
  String? last_name;

  Users({
    required this.token,
    required this.username,
    required this.first_name,
    required this.last_name
});

  Map<String, dynamic> usertojson(){
    return {
      "token":this.token,
      "username":this.username,
      "first_name":this.first_name,
      "last_name":this.last_name
    };
  }

  Users.fromJson(Map<String, dynamic> json)  {
    token = json['token'];
    username = json['username'];
    first_name = json['first_name'];
    last_name = json['last_name'];
  }

}