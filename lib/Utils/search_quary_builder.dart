class SearchQuaryBuilder {
  static List searchQuaryBuilder(String? quaryString) {
    List quaryList = [];
    String tempQuary = "";
    for (var i = 0; i < quaryString!.length; i++) {
      tempQuary = tempQuary + quaryString[i].toUpperCase();
      quaryList.add(tempQuary);
    }
    return quaryList;
  }
}
