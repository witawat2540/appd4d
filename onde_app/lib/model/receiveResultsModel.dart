import 'dart:convert';

ReceiveResultsModel receiveResultsModelFromJson(String str) => ReceiveResultsModel.fromJson(json.decode(str));

String receiveResultsModelToJson(ReceiveResultsModel data) => json.encode(data.toJson());

class ReceiveResultsModel {
  bool? status;
  List<Data>? data;
  String? filePath;

  ReceiveResultsModel({this.status, this.data, this.filePath});

  factory ReceiveResultsModel.fromJson(Map<String, dynamic> json) => ReceiveResultsModel(
    status: json["status"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    filePath: json["file_path"],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['file_path'] = this.filePath;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? substituteId;
  int? assetsId;
  int? assetCategoriesId;
  String? typeStatus;
  String? sendStatus;
  DateTime? sendDate;
  String? objective;
  String? office;
  String? city;
  String? remark;
  dynamic image;
  DateTime? auditDate;
  DateTime? approveDate;
  DateTime? considerationDate;
  int? form08sId;
  int? form11sId;
  int? form12sId;
  int? form05sId;
  int? form14sId;
  int? procurementsId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic reason;
  Form02Lists? form02Lists;

  Data(
      {this.id,
        this.userId,
        this.substituteId,
        this.assetsId,
        this.assetCategoriesId,
        this.typeStatus,
        this.sendStatus,
        this.sendDate,
        this.objective,
        this.office,
        this.city,
        this.remark,
        this.image,
        this.auditDate,
        this.approveDate,
        this.considerationDate,
        this.form08sId,
        this.form11sId,
        this.form12sId,
        this.form05sId,
        this.form14sId,
        this.procurementsId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.reason,
        this.form02Lists});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    substituteId = json['substitute_id'];
    assetsId = json['assets_id'];
    assetCategoriesId = json['asset_categories_id'];
    typeStatus = json['type_status'];
    sendStatus = json['send_status'];
    sendDate = DateTime.parse(json['send_date']);
    objective = json['objective'];
    office = json['office'];
    city = json['city'];
    remark = json['remark'];
    image = json['image'];
    auditDate = DateTime.parse(json['audit_date']);
    approveDate = DateTime.parse(json['approve_date']);
    considerationDate = DateTime.parse(json['consideration_date']);
    form08sId = json['form08s_id'];
    form11sId = json['form11s_id'];
    form12sId = json['form12s_id'];
    form05sId = json['form05s_id'];
    form14sId = json['form14s_id'];
    procurementsId = json['procurements_id'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    deletedAt = json['deleted_at'] == null ? null : DateTime.parse(json['deleted_at']);
    reason = json['reason'];
    form02Lists = json['form02_lists'] != null
        ? new Form02Lists.fromJson(json['form02_lists'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['substitute_id'] = this.substituteId;
    data['assets_id'] = this.assetsId;
    data['asset_categories_id'] = this.assetCategoriesId;
    data['type_status'] = this.typeStatus;
    data['send_status'] = this.sendStatus;
    data['send_date'] = this.sendDate;
    data['objective'] = this.objective;
    data['office'] = this.office;
    data['city'] = this.city;
    data['remark'] = this.remark;
    data['image'] = this.image;
    data['audit_date'] = this.auditDate;
    data['approve_date'] = this.approveDate;
    data['consideration_date'] = this.considerationDate;
    data['form08s_id'] = this.form08sId;
    data['form11s_id'] = this.form11sId;
    data['form12s_id'] = this.form12sId;
    data['form05s_id'] = this.form05sId;
    data['form14s_id'] = this.form14sId;
    data['procurements_id'] = this.procurementsId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['reason'] = this.reason;
    if (this.form02Lists != null) {
      data['form02_lists'] = this.form02Lists!.toJson();
    }
    return data;
  }
}

class Form02Lists {
  int? id;
  int? form02sId;
  int? assetsId;
  int? assetCategoriesId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Category? category;
  Asset? asset;

  Form02Lists(
      {this.id,
        this.form02sId,
        this.assetsId,
        this.assetCategoriesId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.category,
        this.asset});

  Form02Lists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    form02sId = json['form02s_id'];
    assetsId = json['assets_id'];
    assetCategoriesId = json['asset_categories_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    asset = json['asset'] != null ? new Asset.fromJson(json['asset']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['form02s_id'] = this.form02sId;
    data['assets_id'] = this.assetsId;
    data['asset_categories_id'] = this.assetCategoriesId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.asset != null) {
      data['asset'] = this.asset!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  dynamic imageString;

  Category({this.id, this.name, this.imageString});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageString = json['imageString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageString'] = this.imageString;
    return data;
  }
}

class Asset {
  int? id;
  String? code;
  String? description;

  Asset({this.id, this.code, this.description});

  Asset.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}