
class WebUser {

  String? userID;
  String? email;
  String? name;
  String? createAt;

  WebUser({
    this.userID,
    this.email,
    this.createAt,
    this.name,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['email'] = email;
    map['name'] = name ;
    map['createAt'] =  createAt;
    return map;
  }

  factory WebUser.fromJson(dynamic json) {
    return WebUser(
        userID: json['userID'],
        email:json['email'],
        name:json['name'],
        createAt: json['createAt']
    );
  }
}
