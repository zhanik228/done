class TicketModel {
  String? title;
  String? time;
  String? type;
  String? seat;
  String? picture;

  TicketModel(
    this.title,
    this.time,
    this.type,
    this.seat,
    this.picture,
  );

  TicketModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    time = json['time'];
    type = json['type'];
    seat = json['seat'];
    picture = json['picture'];
  }

  toJson() {
    return {
      'title': this.title,
      'time': this.time,
      'type': this.type,
      'seat': this.seat,
      'picture': this.picture,
    };
  }
}