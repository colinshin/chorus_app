import 'dart:convert';

List<Song> songFromJson(String str) =>
    List<Song>.from(json.decode(str).map((x) => Song.fromJson(x)));

String songToJson(List<Song> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Song {
  Song({this.id, this.title, this.song, this.type});

  int id;
  String title;
  String song;
  String type;

  factory Song.fromJson(Map<String, dynamic> json) => Song(
      id: json["id"],
      title: json["title"],
      song: json["song"],
      type: json["type"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "title": title, "song": song, "type": type};
}
