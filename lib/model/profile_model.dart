class ProfileModel {
  final String username;
  final String useremail;
  final String userphoneNo;

  ProfileModel({
    required this.useremail,
    required this.username,
    required this.userphoneNo,
  });

  Map<String, dynamic> toJson() => {
        'email': useremail,
        'name': username,
        'phonenum': userphoneNo,
      };

  static ProfileModel fromJson(Map<String, dynamic> json) => ProfileModel(
        useremail: json['email'],
        username: json['name'],
        userphoneNo: json['phonenum'],
      );
}
