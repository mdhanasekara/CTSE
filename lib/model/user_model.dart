class UserModel {
  String? uid;
  String? email;
  String? fname;
  String? lname;
  String? mobile;

  UserModel({this.uid, this.email, this.fname, this.lname, this.mobile});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fname: map['fname'],
      lname: map['lname'],
      mobile: map['mobile'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fname': fname,
      'lname': lname,
      'mobile': mobile,
    };
  }
}