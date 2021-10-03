// To parse this JSON data, do
//
//     final getTutorialModel = getTutorialModelFromJson(jsonString);

import 'dart:convert';

GetTutorialModel getTutorialModelFromJson(String str) =>
    GetTutorialModel.fromJson(json.decode(str));

String getTutorialModelToJson(GetTutorialModel data) =>
    json.encode(data.toJson());

class GetTutorialModel {
  GetTutorialModel({
    this.status,
    this.hasbooking,
    this.data,
  });

  bool? status;
  Hasbooking? hasbooking;
  Data? data;

  factory GetTutorialModel.fromJson(Map<String, dynamic> json) =>
      GetTutorialModel(
        status: json["status"],
        hasbooking:json['hasbooking']==null?null: Hasbooking.fromJson(json["hasbooking"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "hasbooking": hasbooking!.toJson(),
        "data": data!.toJson(),
      };

  List setDetail({
    required Map<String, dynamic> data,
    required Map<String, dynamic> dataDevice,
    required Map<String, dynamic> image,
    required Map<String, dynamic> doc,
    required Map<String, dynamic> assetId,
    required Map<String, dynamic> url,
  }) {
    var newData = [];
    //print(image);
    data.forEach((key, value) {
      var newData2 = [];
      Map<String, dynamic>.from(dataDevice[key]).forEach((key2, value2) {
        //print(image[key2]);
        String? _doc;
        if(doc[key2] != null){
          _doc = doc[key2].toString().replaceAll('public/', 'storage/');
          //print(_doc);
        }
        print(url[key2]);

        newData2.add({
          'name': key2,
          'count': value2,
          'image': image[key2],
          'doc':_doc,
          'url':url[key2],
          'id':assetId[key2]
        });
      });

      newData.add(
          {'nameDevice': key, 'totalDevice': value, 'detailDevice': newData2});
    });
    return newData;
  }
}

class Data {
  Data({
    this.sum,
  });

  int? sum;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sum: json["sum"],
      );

  Map<String, dynamic> toJson() => {
        "sum": sum,
      };
}

class Hasbooking {
  Hasbooking({
    this.id,
    this.userId,
    this.assetCategoriesId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  int? userId;
  int? assetCategoriesId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Hasbooking.fromJson(Map<String, dynamic> json) => Hasbooking(
        id: json["id"],
        userId: json["user_id"],
        assetCategoriesId: json["asset_categories_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "asset_categories_id": assetCategoriesId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
