class Users {
  String? username;
  String? email;
  String? id; 
  int? selctedProfile;
  Users({this.username, this.email, this.id, this.selctedProfile});
  Map<String, dynamic> toFirestore() {
    return {
      'name': username,
      'email': email,
      'id': id,
      'profile': selctedProfile,
    };
  }
  factory Users.fromFirestore(Map<String, dynamic> json, String id) {
    return Users(
      id: id,
      username: json['name'] ?? '',
      email: json['email'] ?? '',
      selctedProfile: json['profile'] ?? 0,
    );
  }
}
