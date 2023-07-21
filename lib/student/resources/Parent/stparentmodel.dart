class StudentP {
  var id;
  String firstName;
  String lastName;
  String email;
  var average;
  String? fatherName;
  String? motherName;
  String? parentEmail;
  String? parentPhone;
  String? additional;
  String? studentGrade;
  String? studentClass;
  String? studentClassref;
  String? fees;
  String? phone;
  bool exists;
  String? urlAvatar;
  String? classid;

  StudentP({
    required this.firstName,
    required this.lastName,
    this.email = '',
     this.average,
     this.fatherName,
     this.motherName,
     this.parentEmail,
     this.parentPhone,
     this.studentGrade,
     this.studentClass,
    this.additional = '',
    this.studentClassref,
    this.fees,
    this.id,
    this.phone,
    this.exists=true,
    this.urlAvatar,
    this.classid,
  });
}