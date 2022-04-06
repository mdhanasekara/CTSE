class UserModel {
  String? uid;
  String? email;
  String? fname;
  String? lname;
  String? mobile;
  String? type;

  UserModel(
      {this.uid, this.email, this.fname, this.lname, this.mobile, this.type});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fname: map['fname'],
      lname: map['lname'],
      mobile: map['mobile'],
      type: map['type'],
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
      'type': type,
    };
  }
}
