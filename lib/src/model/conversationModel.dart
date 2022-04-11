class ConversationModel {
  String? messageText;
  String? senderMail;
  String? senderName;
  String? uid;
  DateTime? date;

  ConversationModel({
    this.messageText,
    this.senderMail,
    this.senderName,
    this.uid,
    this.date,
  });

  factory ConversationModel.fromMap(Map<String, dynamic> map) =>
      ConversationModel(
        messageText: map['messageText'],
        senderMail: map['senderMail'],
        senderName: map['senderName'],
        uid: map['uid'],
        date: map['date'].toDate(),
      );
}
