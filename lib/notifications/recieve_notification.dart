class RecieveNotification {
  final int id;
  final String? title;
  final String? body;
  final String? imageUrl;
  final String? payload;

  RecieveNotification(
      this.id, this.title, this.body, this.imageUrl, this.payload);

  @override
  String toString() {
    return 'RecieveNotification(id: $id, title: $title, body: $body, imageUrl: $imageUrl, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecieveNotification &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.imageUrl == imageUrl &&
        other.payload == payload;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        imageUrl.hashCode ^
        payload.hashCode;
  }
}
