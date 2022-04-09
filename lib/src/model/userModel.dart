class UserModel {
  String? name;
  String? email;
  String? uid;
  DateTime? date;

  UserModel({this.name, this.email, this.uid, this.date});

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        email: map['email'],
        name: map['name'],
        uid: map['uid'],
        date: map['date'],
      );

  Map<String, dynamic> toMap(UserModel user) => {
        'email': user.email,
        'name': user.name,
        'uid': user.uid,
        'date': user.date,
      };
}
