import 'dart:convert';

class PushNotificationResponse {
  String? senderId;
  String? eventType;
  String? eventData;
  String? notificationType;
  MessageData? messageData;
  String? messageID;
  bool? isAppActive;
  bool? isTerminated;

  PushNotificationResponse({
    this.senderId,
    this.eventType,
    this.eventData,
    this.notificationType,
    this.messageData,
    this.messageID,
    this.isAppActive,
    this.isTerminated,
  });

  PushNotificationResponse.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    eventType = json['eventType'];
    eventData = json['eventData'];
    notificationType = json['notification_type'];
    messageID = json['messageID'];
    isAppActive = json['isAppActive'];
    isTerminated = json['isTerminated'];
    messageData = json['messageData'] != null
        ? MessageData.fromJson(jsonDecode(json['messageData']))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderId'] = senderId;
    data['eventType'] = eventType;
    data['eventData'] = eventData;
    data['notification_type'] = notificationType;
    data['messageID'] = messageID;
    data['isAppActive'] = isAppActive;
    data['isTerminated'] = isTerminated;
    if (messageData != null) {
      data['messageData'] = messageData!.toJson();
    }
    return data;
  }
}

class MessageData {
  String? senderId;
  String? senderFullName;
  String? senderAvatar;
  String? chatRoomId;
  String? chatType;
  String? chatModel;

  MessageData(
      {this.senderId,
      this.senderFullName,
      this.senderAvatar,
      this.chatRoomId,
      this.chatType,
      this.chatModel});

  MessageData.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    senderFullName = json['senderFullName'];
    senderAvatar = json['senderAvatar'];
    chatRoomId = json['chatRoomId'];
    chatType = json['chatType'];
    chatModel = json['chatModel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderId'] = senderId;
    data['senderFullName'] = senderFullName;
    data['senderAvatar'] = senderAvatar;
    data['chatRoomId'] = chatRoomId;
    data['chatType'] = chatType;
    data['chatModel'] = chatModel;
    return data;
  }
}
