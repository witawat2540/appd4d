import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddFormReceiveModel {
  int? substituteId;
  List<int> accessorieList = [];
  List<String> accessorieName = [];
  int type = 1;
  TextEditingController objective1 = TextEditingController();
  TextEditingController nameFilesCopyCard = TextEditingController();
  TextEditingController nameFilesHouseRes = TextEditingController();
  TextEditingController nameFileCopyTrain = TextEditingController();
  TextEditingController nameFileSubCopyCitizenId = TextEditingController();
  TextEditingController nameFilePowerAttorney = TextEditingController();
  XFile? filePowerAttorney;
  XFile? fileSubCopyCitizenId;
  XFile? fileCopyTrain;
  XFile? fileHouseRes;
  XFile? fileCopyCard;
  int? mainGroupsId;
  int? subGroupsId;
  List<Future<MultipartFile>?> image = [];

  Future setFile() async {

    if(fileCopyCard != null){
      image.add(
          http.MultipartFile.fromPath('files_copy_card', fileCopyCard!.path));
    }
    if(fileHouseRes != null){
      image.add(
          http.MultipartFile.fromPath('files_house_res', fileHouseRes!.path));
    }
    if(fileCopyTrain != null){
      image.add(
          http.MultipartFile.fromPath('file_copy_train', fileCopyTrain!.path));
    }
    if(fileSubCopyCitizenId != null){
      image.add(http.MultipartFile.fromPath(
          'file_sub_copy_citizen_id', fileSubCopyCitizenId!.path));
    }
    if(filePowerAttorney != null){
      image.add(http.MultipartFile.fromPath(
          'file_power_attorney', filePowerAttorney!.path));
    }
  }

  Map<String,String> toJson() => {
    'substitute_id': substituteId == null ? '':substituteId.toString(),
    'accessorie_list': accessorieList.toString(),
    'type': type.toString(),
    'objective1': objective1.text
  };
}