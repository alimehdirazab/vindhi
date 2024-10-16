class OTPResponse {
  int status;
  String message;
  User? user; // Make user optional by using a nullable type

  OTPResponse({
    required this.status,
    required this.message,
    this.user, // User is now optional
  });

  factory OTPResponse.fromJson(Map<String, dynamic> json) {
    return OTPResponse(
      status: json['status'],
      message: json['message'],
      user: json.containsKey('user') && json['user'] != null
          ? User.fromJson(json['user'])
          : null, // Check if user exists and is not null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      if (user != null)
        'user': user!.toJson(), // Only include user if it is not null
    };
  }
}

class User {
  int id;
  String registerNo;
  String panNo;
  String aadharNo;
  String name;
  String dob;
  String? doj;
  String? designation;
  String? zone;
  String? grade;
  String address;
  String mobile;
  String? gst;
  String? email;
  String? password;
  String? gender;
  String? city;
  String? state;
  String? pincode;
  String? y;
  String? image;
  String status;
  String? otp;
  String otpExpiresAt;
  String type;
  String? salery;
  String? createdAt;
  String? updatedAt;

  User({
    required this.id,
    required this.registerNo,
    required this.panNo,
    required this.aadharNo,
    required this.name,
    required this.dob,
    this.doj,
    this.designation,
    this.zone,
    this.grade,
    required this.address,
    required this.mobile,
    this.gst,
    this.email,
    this.password,
    this.gender,
    this.city,
    this.state,
    this.pincode,
    this.y,
    this.image,
    required this.status,
    this.otp,
    required this.otpExpiresAt,
    required this.type,
    this.salery,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      registerNo: json['register_no'],
      panNo: json['pan_no'],
      aadharNo: json['aadhar_no'],
      name: json['name'],
      dob: json['dob'],
      doj: json['doj'],
      designation: json['designation'],
      zone: json['zone'],
      grade: json['grade'],
      address: json['address'],
      mobile: json['mobile'],
      gst: json['gst'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      y: json['y'],
      image: json['image'],
      status: json['status'],
      otp: json['otp'],
      otpExpiresAt: json['otp_expires_at'],
      type: json['type'],
      salery: json['salery'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'register_no': registerNo,
      'pan_no': panNo,
      'aadhar_no': aadharNo,
      'name': name,
      'dob': dob,
      'doj': doj,
      'designation': designation,
      'zone': zone,
      'grade': grade,
      'address': address,
      'mobile': mobile,
      'gst': gst,
      'email': email,
      'password': password,
      'gender': gender,
      'city': city,
      'state': state,
      'pincode': pincode,
      'y': y,
      'image': image,
      'status': status,
      'otp': otp,
      'otp_expires_at': otpExpiresAt,
      'type': type,
      'salery': salery,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
