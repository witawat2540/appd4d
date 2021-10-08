/*
import 'dart:convert';


class Form05DoneModel {
  bool status;
  List<Data> data;
  String filePath;

  Form05DoneModel({this.status, this.data, this.filePath});

  Form05DoneModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['file_path'] = this.filePath;
    return data;
  }
}

class Data {
  int id;
  int userId;
  Null substituteId;
  int assetId;
  int assetCategoriesId;
  String typeStatus;
  String sendStatus;
  String sendDate;
  String objective;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String office;
  String city;
  Null remark;
  Null image;
  String auditDate;
  String approveDate;
  int form07sId;
  int form09sId;
  Null form10sId;
  Null form05sId;
  Null form13sId;
  Null docNotifiesId;
  int docContractsId;
  int docGarunteeId;
  Null reason;
  Contract contract;
  User user;
  Form05 form05;
  Category category;
  Asset asset;

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
        this.contract,
        this.user,
        this.form05,
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
    sendDate = json['send_date'];
    objective = json['objective'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    office = json['office'];
    city = json['city'];
    remark = json['remark'];
    image = json['image'];
    auditDate = json['audit_date'];
    approveDate = json['approve_date'];
    form07sId = json['form07s_id'];
    form09sId = json['form09s_id'];
    form10sId = json['form10s_id'];
    form05sId = json['form05s_id'];
    form13sId = json['form13s_id'];
    docNotifiesId = json['doc_notifies_id'];
    docContractsId = json['doc_contracts_id'];
    docGarunteeId = json['doc_garuntee_id'];
    reason = json['reason'];
    contract = json['contract'] != null
        ? new Contract.fromJson(json['contract'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    form05 =
    json['form05'] != null ? new Form05.fromJson(json['form05']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    asset = json['asset'] != null ? new Asset.fromJson(json['asset']) : null;
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
    if (this.contract != null) {
      data['contract'] = this.contract.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.form05 != null) {
      data['form05'] = this.form05.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.asset != null) {
      data['asset'] = this.asset.toJson();
    }
    return data;
  }
}

class Contract {
  int id;
  String office;
  String city;
  String startDate;
  String stopDate;
  Null remark;
  Null image;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String subDistrict;
  String district;
  String pSName;
  String position;
  Null returnDate;
  String estimateDay;
  String estimateDay2;
  String fines;
  String finesTh;
  String officerName;
  String citizenId;
  String title;
  String firstname;
  String lastname;
  String fullname;
  String contractId;
  String birthday;
  String houseNo;
  String villageNo;
  String alley;
  Null road;
  String subDistrictDisability;
  String districtDisability;
  String provinceDisability;
  String zIPCode;
  Null telHome;
  String telephone;
  String academy;
  String nameAsset;
  Null brandAsset;
  int price;
  Null code;
  String disabilityType;
  String typeStatus;
  String witness1;
  String witness2;
  Null acceptor;
  String witness3;
  String witness4;
  Null guarantorId;
  Null guarantorBirthday;
  Null guarantorAge;
  Null guarantorName;
  Null guarantorHouseNo;
  Null guarantorVillageNo;
  Null guarantorAlley;
  Null guarantorRoad;
  Null guarantorSubDistrict;
  Null guarantorDistrict;
  Null guarantorProvince;
  Null guarantorZIPCode;
  Null guarantorTel;
  Null related;
  Null substituteName;
  Null substituteName2;
  Null substituteCitizenId;
  Null substituteBirthday;
  Null substituteTel;

  Contract(
      {this.id,
        this.office,
        this.city,
        this.startDate,
        this.stopDate,
        this.remark,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.subDistrict,
        this.district,
        this.pSName,
        this.position,
        this.returnDate,
        this.estimateDay,
        this.estimateDay2,
        this.fines,
        this.finesTh,
        this.officerName,
        this.citizenId,
        this.title,
        this.firstname,
        this.lastname,
        this.fullname,
        this.contractId,
        this.birthday,
        this.houseNo,
        this.villageNo,
        this.alley,
        this.road,
        this.subDistrictDisability,
        this.districtDisability,
        this.provinceDisability,
        this.zIPCode,
        this.telHome,
        this.telephone,
        this.academy,
        this.nameAsset,
        this.brandAsset,
        this.price,
        this.code,
        this.disabilityType,
        this.typeStatus,
        this.witness1,
        this.witness2,
        this.acceptor,
        this.witness3,
        this.witness4,
        this.guarantorId,
        this.guarantorBirthday,
        this.guarantorAge,
        this.guarantorName,
        this.guarantorHouseNo,
        this.guarantorVillageNo,
        this.guarantorAlley,
        this.guarantorRoad,
        this.guarantorSubDistrict,
        this.guarantorDistrict,
        this.guarantorProvince,
        this.guarantorZIPCode,
        this.guarantorTel,
        this.related,
        this.substituteName,
        this.substituteName2,
        this.substituteCitizenId,
        this.substituteBirthday,
        this.substituteTel});

  Contract.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    office = json['office'];
    city = json['city'];
    startDate = json['start_date'];
    stopDate = json['stop_date'];
    remark = json['remark'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    subDistrict = json['sub_district'];
    district = json['district'];
    pSName = json['PS_name'];
    position = json['position'];
    returnDate = json['return_date'];
    estimateDay = json['estimate_day'];
    estimateDay2 = json['estimate_day2'];
    fines = json['fines'];
    finesTh = json['fines_th'];
    officerName = json['officer_name'];
    citizenId = json['citizen_id'];
    title = json['title'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    fullname = json['fullname'];
    contractId = json['contract_id'];
    birthday = json['birthday'];
    houseNo = json['house_no'];
    villageNo = json['village_no'];
    alley = json['alley'];
    road = json['road'];
    subDistrictDisability = json['sub_district_disability'];
    districtDisability = json['district_disability'];
    provinceDisability = json['province_disability'];
    zIPCode = json['ZIP_code'];
    telHome = json['tel_home'];
    telephone = json['telephone'];
    academy = json['academy'];
    nameAsset = json['name_asset'];
    brandAsset = json['brand_asset'];
    price = json['price'];
    code = json['code'];
    disabilityType = json['disability_type'];
    typeStatus = json['type_status'];
    witness1 = json['witness1'];
    witness2 = json['witness2'];
    acceptor = json['acceptor'];
    witness3 = json['witness3'];
    witness4 = json['witness4'];
    guarantorId = json['guarantor_id'];
    guarantorBirthday = json['guarantor_birthday'];
    guarantorAge = json['guarantor_age'];
    guarantorName = json['guarantor_name'];
    guarantorHouseNo = json['guarantor_house_no'];
    guarantorVillageNo = json['guarantor_village_no'];
    guarantorAlley = json['guarantor_alley'];
    guarantorRoad = json['guarantor_road'];
    guarantorSubDistrict = json['guarantor_sub_district'];
    guarantorDistrict = json['guarantor_district'];
    guarantorProvince = json['guarantor_province'];
    guarantorZIPCode = json['guarantor_ZIP_code'];
    guarantorTel = json['guarantor_tel'];
    related = json['related'];
    substituteName = json['substitute_name'];
    substituteName2 = json['substitute_name2'];
    substituteCitizenId = json['substitute_citizenId'];
    substituteBirthday = json['substitute_birthday'];
    substituteTel = json['substitute_tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['office'] = this.office;
    data['city'] = this.city;
    data['start_date'] = this.startDate;
    data['stop_date'] = this.stopDate;
    data['remark'] = this.remark;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['sub_district'] = this.subDistrict;
    data['district'] = this.district;
    data['PS_name'] = this.pSName;
    data['position'] = this.position;
    data['return_date'] = this.returnDate;
    data['estimate_day'] = this.estimateDay;
    data['estimate_day2'] = this.estimateDay2;
    data['fines'] = this.fines;
    data['fines_th'] = this.finesTh;
    data['officer_name'] = this.officerName;
    data['citizen_id'] = this.citizenId;
    data['title'] = this.title;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['fullname'] = this.fullname;
    data['contract_id'] = this.contractId;
    data['birthday'] = this.birthday;
    data['house_no'] = this.houseNo;
    data['village_no'] = this.villageNo;
    data['alley'] = this.alley;
    data['road'] = this.road;
    data['sub_district_disability'] = this.subDistrictDisability;
    data['district_disability'] = this.districtDisability;
    data['province_disability'] = this.provinceDisability;
    data['ZIP_code'] = this.zIPCode;
    data['tel_home'] = this.telHome;
    data['telephone'] = this.telephone;
    data['academy'] = this.academy;
    data['name_asset'] = this.nameAsset;
    data['brand_asset'] = this.brandAsset;
    data['price'] = this.price;
    data['code'] = this.code;
    data['disability_type'] = this.disabilityType;
    data['type_status'] = this.typeStatus;
    data['witness1'] = this.witness1;
    data['witness2'] = this.witness2;
    data['acceptor'] = this.acceptor;
    data['witness3'] = this.witness3;
    data['witness4'] = this.witness4;
    data['guarantor_id'] = this.guarantorId;
    data['guarantor_birthday'] = this.guarantorBirthday;
    data['guarantor_age'] = this.guarantorAge;
    data['guarantor_name'] = this.guarantorName;
    data['guarantor_house_no'] = this.guarantorHouseNo;
    data['guarantor_village_no'] = this.guarantorVillageNo;
    data['guarantor_alley'] = this.guarantorAlley;
    data['guarantor_road'] = this.guarantorRoad;
    data['guarantor_sub_district'] = this.guarantorSubDistrict;
    data['guarantor_district'] = this.guarantorDistrict;
    data['guarantor_province'] = this.guarantorProvince;
    data['guarantor_ZIP_code'] = this.guarantorZIPCode;
    data['guarantor_tel'] = this.guarantorTel;
    data['related'] = this.related;
    data['substitute_name'] = this.substituteName;
    data['substitute_name2'] = this.substituteName2;
    data['substitute_citizenId'] = this.substituteCitizenId;
    data['substitute_birthday'] = this.substituteBirthday;
    data['substitute_tel'] = this.substituteTel;
    return data;
  }
}

class User {
  int id;
  String email;
  String emailVerifiedAt;
  String prePassword;
  String title;
  String firstName;
  String lastName;
  String birthday;
  int gender;
  Null avatarName;
  Null avatarPath;
  String citizenId;
  String pwdId;
  int timezone;
  int active;
  Null lastLoginAt;
  Null lastLoginIp;
  Null toBeLoggedOut;
  String createdAt;
  String updatedAt;
  int disabilityTypeId;
  Null pwdPic;
  String systemId;
  String approveDate;

  User(
      {this.id,
        this.email,
        this.emailVerifiedAt,
        this.prePassword,
        this.title,
        this.firstName,
        this.lastName,
        this.birthday,
        this.gender,
        this.avatarName,
        this.avatarPath,
        this.citizenId,
        this.pwdId,
        this.timezone,
        this.active,
        this.lastLoginAt,
        this.lastLoginIp,
        this.toBeLoggedOut,
        this.createdAt,
        this.updatedAt,
        this.disabilityTypeId,
        this.pwdPic,
        this.systemId,
        this.approveDate});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    prePassword = json['pre_password'];
    title = json['title'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    birthday = json['birthday'];
    gender = json['gender'];
    avatarName = json['avatar_name'];
    avatarPath = json['avatar_path'];
    citizenId = json['citizen_id'];
    pwdId = json['pwd_id'];
    timezone = json['timezone'];
    active = json['active'];
    lastLoginAt = json['last_login_at'];
    lastLoginIp = json['last_login_ip'];
    toBeLoggedOut = json['to_be_logged_out'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    disabilityTypeId = json['disability_type_id'];
    pwdPic = json['pwd_pic'];
    systemId = json['system_id'];
    approveDate = json['approve_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['pre_password'] = this.prePassword;
    data['title'] = this.title;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['avatar_name'] = this.avatarName;
    data['avatar_path'] = this.avatarPath;
    data['citizen_id'] = this.citizenId;
    data['pwd_id'] = this.pwdId;
    data['timezone'] = this.timezone;
    data['active'] = this.active;
    data['last_login_at'] = this.lastLoginAt;
    data['last_login_ip'] = this.lastLoginIp;
    data['to_be_logged_out'] = this.toBeLoggedOut;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['disability_type_id'] = this.disabilityTypeId;
    data['pwd_pic'] = this.pwdPic;
    data['system_id'] = this.systemId;
    data['approve_date'] = this.approveDate;
    return data;
  }
}

class Form05 {
  int? id;
  int? form01Id;
  int? form02Id;
  String? writeAt;
  String? deliver;
  dynamic position;
  String? witness1;
  String? witness2;
  String? printDate;
  String? office;
  String? city;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<DocUploads>? docUploads;

  Form05(
      {this.id,
        this.form01Id,
        this.form02Id,
        this.writeAt,
        this.deliver,
        this.position,
        this.witness1,
        this.witness2,
        this.printDate,
        this.office,
        this.city,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.docUploads});

  Form05.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    form01Id = json['form01_id'];
    form02Id = json['form02_id'];
    writeAt = json['write_at'];
    deliver = json['deliver'];
    position = json['position'];
    witness1 = json['witness1'];
    witness2 = json['witness2'];
    printDate = json['print_date'];
    office = json['office'];
    city = json['city'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['doc_uploads'] != null) {
      docUploads = new List<DocUploads>();
      json['doc_uploads'].forEach((v) {
        docUploads!.add(new DocUploads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['form01_id'] = this.form01Id;
    data['form02_id'] = this.form02Id;
    data['write_at'] = this.writeAt;
    data['deliver'] = this.deliver;
    data['position'] = this.position;
    data['witness1'] = this.witness1;
    data['witness2'] = this.witness2;
    data['print_date'] = this.printDate;
    data['office'] = this.office;
    data['city'] = this.city;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.docUploads != null) {
      data['doc_uploads'] = this.docUploads.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocUploads {
  int? id;
  String? cate;
  int? form05Id;
  String? fileName;
  String? filePath;
  String? fileLink;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  DocUploads(
      {this.id,
        this.cate,
        this.form05Id,
        this.fileName,
        this.filePath,
        this.fileLink,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  DocUploads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cate = json['cate'];
    form05Id = json['form05_id'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    fileLink = json['file_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cate'] = this.cate;
    data['form05_id'] = this.form05Id;
    data['file_name'] = this.fileName;
    data['file_path'] = this.filePath;
    data['file_link'] = this.fileLink;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? imageString;

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
}*/
