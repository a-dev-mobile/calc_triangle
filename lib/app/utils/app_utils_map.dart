class AppUtilsMap {
  /* 
    var updateMap = updateValues(activeParamMap, oldValue, newValue)
      .cast<int, ScaleneTriangle>();

  var updateMap2 = updateValues(activeParamMap2, oldValue2, newValue2)
      .cast<int, RightTriangle>();
     */

  static Map<int, dynamic> updateValues(
      {required Map<int, dynamic> oldMap, required var oldValue, required var newValue}) {
    Map<int, dynamic> newMap = {}..addAll(oldMap);
    List<int> keyList = [];

    for (var e in oldMap.entries) {
      if (e.value == oldValue) {
        keyList.add(e.key);
      }
    }
    for (var key in keyList) {
      newMap[key] = newValue;
    }
    return newMap;
  }

  //получить без последнего значения и начиная с одного
  static dynamic getN<T>(List<T> val) {
    Map<int, dynamic> switchParam = {};
    for (int i = 0; i < val.length - 1; i++) {
      switchParam[i + 1] = val[i];
    }

    return switchParam;
  }
}
