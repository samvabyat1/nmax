class ChatMessageModel {
    ChatMessageModel({
        required this.toId,
        required this.msg,
        required this.read,
        required this.type,
        required this.sent,
        required this.fromId,
    });

    final String? toId;
    final String? msg;
    final String? read;
    final String? type;
    final String? sent;
    final String? fromId;

    factory ChatMessageModel.fromJson(Map<String, dynamic> json){ 
        return ChatMessageModel(
            toId: json["toId"],
            msg: json["msg"],
            read: json["read"],
            type: json["type"],
            sent: json["sent"],
            fromId: json["fromId"],
        );
    }

    Map<String, dynamic> toJson() => {
        "toId": toId,
        "msg": msg,
        "read": read,
        "type": type,
        "sent": sent,
        "fromId": fromId,
    };

}
