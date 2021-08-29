// To parse this JSON data, do
//
//     final dashboardmodel = dashboardmodelFromJson(jsonString);

import 'dart:convert';

Dashboardmodel dashboardmodelFromJson(String str) => Dashboardmodel.fromJson(json.decode(str));

String dashboardmodelToJson(Dashboardmodel data) => json.encode(data.toJson());

class Dashboardmodel {
  Dashboardmodel({
    this.status,
    this.data,
  });

  bool? status;
  Data? data;

  factory Dashboardmodel.fromJson(Map<String, dynamic> json) => Dashboardmodel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.path,
    this.totalAssets,
    this.totalUsers,
    this.totalBookings,
    this.totalEvents,
    this.news,
  });

  String? path;
  int? totalAssets;
  int? totalUsers;
  int? totalBookings;
  int? totalEvents;
  List<News>? news;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    path: json["path"],
    totalAssets: json["total_assets"],
    totalUsers: json["total_users"],
    totalBookings: json["total_bookings"],
    totalEvents: json["total_events"],
    news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "total_assets": totalAssets,
    "total_users": totalUsers,
    "total_bookings": totalBookings,
    "total_events": totalEvents,
    "news": List<dynamic>.from(news!.map((x) => x.toJson())),
  };
}

class News {
  News({
    this.title,
    this.coverName,
  });

  String? title;
  String? coverName;

  factory News.fromJson(Map<String, dynamic> json) => News(
    title: json["title"],
    coverName: json["cover_name"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "cover_name": coverName,
  };
}
