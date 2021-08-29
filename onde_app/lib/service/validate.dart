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
}