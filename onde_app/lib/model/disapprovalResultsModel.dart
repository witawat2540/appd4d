import 'dart:convert';

disapprovalResultsModel disapprovalResultsModelModelFromJson(String str) => disapprovalResultsModel.fromJson(json.decode(str));

String disapprovalResultsModelToJson(disapprovalResultsModel data) => json.encode(data.toJson());

class disapprovalResultsModel {
  bool? status;
  List<Data>? data;
  String? filePath;

  disapprovalResultsModel({this.status, this.data, this.filePath});

  factory disapprovalResultsModel.fromJson(Map<String, dynamic> json) => disapprovalResultsModel(
    status: json["status"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    filePath: json["file_path"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "file_path": filePath,
  };
}

class Data {
  int? id;
  int? userId;
  int? substituteId;
  dynamic assetId;
  int? assetCategoriesId;
  String? typeStatus;
  String? sendStatus;
  DateTime? sendDate;
  String? objective;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? office;
  String? city;
  dynamic remark;
  dynamic image;
  DateTime? auditDate;
  DateTime? approveDate;
  int? form07sId;
  dynamic form09sId;
  int? form10sId;
  dynamic form05sId;
  dynamic form13sId;
  dynamic docNotifiesId;
  dynamic docContractsId;
  dynamic docGarunteeId;
  String? reason;
  Category? category;
  Asset? asset;

  Data(
      {this.id,
        this.userId,
        this.substituteId,
        this.assetId,
        this.assetCategoriesId,
        this.typeStatus,
        this.sendStatus,
        this.sendDate,
        this.objective,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.office,
        this.city,
        this.remark,
        this.image,
        this.auditDate,
        this.approveDate,
        this.form07sId,
        this.form09sId,
        this.form10sId,
        this.form05sId,
        this.form13sId,
        this.docNotifiesId,
        this.docContractsId,
        this.docGarunteeId,
        this.reason,
        this.category,
        this.asset});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    substituteId = json['substitute_id'];
    assetId = json['asset_id'];
    assetCategoriesId = json['asset_categories_id'];
    typeStatus = json['type_status'];
    sendStatus = json['send_status'];
    sendDate = DateTime.parse(json['send_date']);
    objective = json['objective'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    deletedAt = json['deleted_at'] == null ? null : DateTime.parse(json['deleted_at']);
    office = json['office'];
    city = json['city'];
    remark = json['remark'];
    image = json['image'];
    auditDate = DateTime.parse(json['audit_date']);
    approveDate = DateTime.parse(json['approve_date']);
    form07sId = json['form07s_id'];
    form09sId = json['form09s_id'];
    form10sId = json['form10s_id'];
    form05sId = json['form05s_id'];
    form13sId = json['form13s_id'];
    docNotifiesId = json['doc_notifies_id'];
    docContractsId = json['doc_contracts_id'];
    docGarunteeId = json['doc_garuntee_id'];
    reason = json['reason'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    asset = json['asset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['substitute_id'] = this.substituteId;
    data['asset_id'] = this.assetId;
    data['asset_categories_id'] = this.assetCategoriesId;
    data['type_status'] = this.typeStatus;
    data['send_status'] = this.sendStatus;
    data['send_date'] = this.sendDate;
    data['objective'] = this.objective;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['office'] = this.office;
    data['city'] = this.city;
    data['remark'] = this.remark;
    data['image'] = this.image;
    data['audit_date'] = this.auditDate;
    data['approve_date'] = this.approveDate;
    data['form07s_id'] = this.form07sId;
    data['form09s_id'] = this.form09sId;
    data['form10s_id'] = this.form10sId;
    data['form05s_id'] = this.form05sId;
    data['form13s_id'] = this.form13sId;
    data['doc_notifies_id'] = this.docNotifiesId;
    data['doc_contracts_id'] = this.docContractsId;
    data['doc_garuntee_id'] = this.docGarunteeId;
    data['reason'] = this.reason;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['asset'] = this.asset;
    return data;
  }
}

class Asset {
  Asset({
    this.id,
    this.code,
    this.description,
  });

  int? id;
  String? code;
  String? description;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    id: json["id"],
    code: json["code"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "description": description,
  };
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