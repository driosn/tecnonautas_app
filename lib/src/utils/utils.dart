class Utils {

  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
  
  String getFileType({String mPath}) {
    if(mPath == null) {
      return '';
    }

    return mPath.split('.').last;
  } 

  bool stringHasData(String str) {
    if (str != null) {
      return str.length > 0;
    }
    return false;
  }

}