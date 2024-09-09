import 'dart:convert';

class CategoryEntity {
  final String title;
  final int id;
  final List<ChannelEntity> channelList;
  CategoryEntity({
    required this.title,
    required this.id,
    required this.channelList,
  });
}

List<ChannelEntity> channelEntityFromJson(String str) =>
    List<ChannelEntity>.from(
        json.decode(str).map((x) => ChannelEntity.fromJson(x)));

String channelEntityToJson(List<ChannelEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChannelEntity {
  final String title;
  final String url;
  final int id;
  final String logo;

  ChannelEntity({
    required this.title,
    required this.url,
    required this.id,
    required this.logo,
  });

  ChannelEntity copyWith({
    String? title,
    String? url,
    int? id,
    String? logo,
  }) =>
      ChannelEntity(
        title: title ?? this.title,
        url: url ?? this.url,
        id: id ?? this.id,
        logo: logo ?? this.logo,
      );

  factory ChannelEntity.fromJson(Map<String, dynamic> json) => ChannelEntity(
        title: json["title"],
        url: json["url"],
        id: json["id"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "id": id,
        "logo": logo,
      };
}

const fileLocation = "assets/tv/";

List<CategoryEntity> categoryList = [
  CategoryEntity(
    title: "Dibujo",
    id: 1,
    channelList: [],
  ),
];
