class EventModel {
  String? eventId;
  String? eventTitle;
  String? eventText;
  String? time;
  bool? eventReadStatus;
  List<String>? eventPictures;

  EventModel(
    this.eventId,
    this.eventTitle,
    this.eventText,
    this.eventReadStatus,
    this.eventPictures
  );

  EventModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventTitle = json['eventTitle'];
    eventText = json['eventText'];
    eventReadStatus = json['eventReadStatus'];
    eventPictures = (json['eventPictures'] as List<dynamic>).cast<String>();
  }

  toJson() {
    return {
      eventId: this.eventId,
      eventTitle: this.eventTitle,
    };
  }
}