class NotificationModel {
  final Data data;

  NotificationModel({
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<Notification> notification;

  Data({
    required this.notification,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notification: List<Notification>.from(json["notification"].map((x) => Notification.fromJson(x))),
  );
}

class Notification {
  final int id;
  final Message message;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.message,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    message: Message.fromJson(json["message"]),
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class Message {
  final String title;
  final String payment;
  final String wallet;
  final String code;
  final double amount;
  final int status;
  final String success;

  Message({
    required this.title,
    required this.payment,
    required this.wallet,
    required this.code,
    required this.amount,
    required this.status,
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    title: json["title"],
    payment: json["payment"] ?? "",
    wallet: json["wallet"],
    code: json["code"],
    amount: double.parse(json["amount"].toString()),
    status: json["status"] ?? 0,
    success: json["success"],
  );
}
