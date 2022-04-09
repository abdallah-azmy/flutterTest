class MessageModel {
  String? messageText;
  String? senderMail;
  String? senderName;
  String? uid;
  DateTime? date;

  MessageModel({
    this.messageText,
    this.senderMail,
    this.senderName,
    this.uid,
    this.date,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
    messageText: map['messageText'],
    senderMail: map['senderMail'],
    senderName: map['senderName'],
    uid: map['uid'],
    date: map['date'],
  );

  Map<String, dynamic> toMap(MessageModel user) => {
    "messageText": messageText,
    "senderMail": senderMail,
    "senderName": senderName,
    "uid": uid,
    'date': date,
  };
}