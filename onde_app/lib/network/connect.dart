import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectAPI {
  String url = 'https://pwds.d4dthai.com/api/';

  //String urlpic = 'http://www.jpos2.com:1800';
  //String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZmI3ZjQzNTc3OGE5ODQwNWQyMjY5YTc0Y2YyMjg2ZDEwZmU5ZDU3MjQ2MGJkY2U4N2E3YmJjNmNmYTlhZTYwZGIyMTJkNWFmOGIxZjE0YWIiLCJpYXQiOjE2Mjg4NjEzNzMuOTQ4Nzk4ODk0ODgyMjAyMTQ4NDM3NSwibmJmIjoxNjI4ODYxMzczLjk0ODgwMTk5NDMyMzczMDQ2ODc1LCJleHAiOjE2NjAzOTczNzMuOTQyNjY4OTE0Nzk0OTIxODc1LCJzdWIiOiIxMyIsInNjb3BlcyI6W119.Gh6znOOZnF9euMYfxVJaDDV5Kd55bwgysEeQJs-Mup8xBnZLCpuI_DYY2TCKXQ6c1LGnUqBpWe6K8BHdi7S2RaVaKqp6Ql_GKshULiq5faK-rZA27P6-GAJwb1ea03JJcC4ZVRMIgZSSOb_ucrIr5EAU1KW9kLc5-nnaY2T5WxlSDC0EZIUtBPhvCmBoKLBHcehZFQJqNuOtlC3Tgjb6si8mHN6IPG3ykhg8IwAwWlSmHpDElQYCuGsF-pTuo46cDayMqIrZyoENrQGlPxUxpJMcTBvVDtE9-egJMGan3qKZrLWUsPaPiOcNO32bLJiHcHe8D0Kb5g9PiWjvh0sdF8TTY4JOnMz7FNiUf-mYtAJ6VSrfF1D6TrLlJee4YG4zxHK4u29m1ZM4x-LcHSMleX2SC9ZMG5a3kMG_7hT1861GbGmY_OAuBa9UJ1HW4KCdL_Zf-pn3lXjg8Jy4ZnENwaXcU-AbleNqfe9wza1-qnHaB_eo0dtYzLm7LMstbxyQcH1aCivYhVUKmHYinmbfKrfqMXSB-hIO3vHN-6Wktt1hmiyFU74N54C0AAtqGt2ODitk-S57mCnyMM6K6t7x0Do26M9kbi6_Vq-eR85GEbSvMEI4tJnXtj309BoySIQUnQITODmLxkavvRNviTK57NKGaGGabMtPiCxoU9jhHms";
  var headers = {HttpHeaders.contentTypeHeader: "application/json"};
  static Future<SharedPreferences> prefer = SharedPreferences.getInstance();

  Future<http.Response> post(String data, String path) async {
    try {
      http.Response response =
          await http.post(Uri.parse(url + path), body: data, headers: headers);

      return response;
    } catch (err) {
      print(err);
      return throw Exception('Not connect Network');
    }
  }

  Future<http.StreamedResponse> httpMultiForm(
      Map<String, String> data, List<Future<MultipartFile>?> pathImage, String uri) async {
    var request = http.MultipartRequest('POST', Uri.parse(url + uri));
    request.fields.addAll(data);
    if(pathImage.isNotEmpty){
      for(var item in pathImage){
        request.files.add(await item!.then((value) => value));
      }
    }
      //request.files.add(await http.MultipartFile.fromPath('pwd_pic', pathImage));
      //request.files.add(await );

    http.StreamedResponse response = await request.send();

    try {
      return response;
    } catch (err) {
      return throw Exception('Not connect Network');
    }
  }

  Future<http.Response> postHeaders(String data, String path) async {
    try {
      await gettoken();
      http.Response response =
          await http.post(Uri.parse(url + path), body: data, headers: headers);
      return response;
    } catch (err) {
      print(err);
      return throw Exception('Not connect Network');
    }
  }

  Future<http.Response> deleteHeaders(String data, String path) async {
    try {
      await gettoken();
      http.Response response = await http.delete(Uri.parse(url + path),
          body: data, headers: headers);
      return response;
    } catch (err) {
      print(err);
      return throw Exception('Not connect Network');
    }
  }

  Future<http.Response> get(String path) async {
    try {
      await gettoken();
      http.Response response =
          await http.get(Uri.parse(url + path), headers: headers);

      return response;
    } catch (err) {
      print(err);
      return throw Exception('Not connect Network');
    }
  }

  gettoken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    headers[HttpHeaders.authorizationHeader] =
        'Bearer ' + preferences.getString('token').toString();
    //print(haerder);
    //return '';
  }


  Future<http.StreamedResponse> httpMultiFormHeaders(
      Map<String, String> data, List<Future<MultipartFile>?> pathImage, String uri) async {
    var request = http.MultipartRequest('POST', Uri.parse(url + uri));
    await gettoken();
    request.headers.addAll(headers);
    request.fields.addAll(data);
    if(pathImage.isNotEmpty){
      for(var item in pathImage){
        request.files.add(await item!.then((value) => value));
      }
    }
    //request.files.add(await http.MultipartFile.fromPath('pwd_pic', pathImage));
    //request.files.add(await );

    http.StreamedResponse response = await request.send();

    try {
      return response;
    } catch (err) {
      return throw Exception('Not connect Network');
    }
  }
}
