class FriendModel {
  String? messageText;
  String? friendMail;
  String? friendName;
  String? uid;
  DateTime? date;

  FriendModel({
    this.messageText,
    this.friendMail,
    this.friendName,
    this.uid,
    this.date,
  });

  factory FriendModel.fromMap(Map<String, dynamic> map) => FriendModel(
    messageText: map['messageText'],
    friendMail: map['senderMail'],
    friendName: map['senderName'],
    uid: map['uid'],
    date: map['date'],
  );

  Map<String, dynamic> toMap(FriendModel user) => {
    "messageText": messageText,
    "senderMail": friendMail,
    "senderName": friendName,
    "uid": uid,
    'date': date,
  };
}