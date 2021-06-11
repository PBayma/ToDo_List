class ToDo {
  late String id;
  late String title;
  late String description;
  late bool isDone;

  ToDo(this.id, this.title, this.description, this.isDone);

  ToDo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isDone = json['isDone'] == 0 ? false : true;
  }

  Map<String, Object?> toJson() {
    final Map<String, Object?> data = new Map<String, Object?>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['isDone'] = this.isDone == false ? 0 : 1;
    return data;
  }
}
