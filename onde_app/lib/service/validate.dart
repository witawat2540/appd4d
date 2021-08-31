class MyValidate{
  static String? checkEmpty(String? value){
    if(value!.isEmpty){
      return 'กรุณากรอกช่องนี้';
    }
  }

  static String? checkEmptyPass(String? value){
    if(value!.isEmpty){
      return 'กรุณากรอกช่องนี้';
    }
    if(value.length < 8){
      return 'กรุณากรอกอย่างน้อย 8 ตัว';
    }
    return null;
  }

  static String? checkEmptyIdCard(String? value){
    if(value!.isEmpty){
      return 'กรุณากรอกช่องนี้';
    }
    if(value.length < 8){
      return 'กรุณากรอกอย่างน้อย 13 ตัว';
    }
    return null;
  }

 static String? checkPhone(String value) {
    String patttern = r'(^0)[8,9,6]{1}[0-9]{8}';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return 'กรุณากรอกข้อมูลช่องนี้';
    }
    if (!regExp.hasMatch(value)) {
      return 'เบอร์โทรศัพท์ไม่ถูกต้อง';
    }
  }


 static String? checkTextEmail(String? value) {
    //print('value.length');
    if (value!.isEmpty) {
      return 'กรุณากรอกข้อมูลช่องนี้';
    }
    if (!value.contains('@') && !value.contains('.')) {
      return 'อีเมลไม่ถูกต้อง';
    }
  }
}