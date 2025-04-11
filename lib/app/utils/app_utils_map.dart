class AppUtilsMap {
  /* 
    var updateMap = updateValues(activeParamMap, oldValue, newValue)
      .cast<int, ScaleneTriangle>();

  var updateMap2 = updateValues(activeParamMap2, oldValue2, newValue2)
      .cast<int, RightTriangle>();
     */

  static Map<int, dynamic> updateValues({
    required Map<int, dynamic> oldMap,
    required var oldValue,
    required var newValue,
  }) {
    Map<int, dynamic> newMap = <int, dynamic>{}..addAll(oldMap);
    List<int> keyList = <int>[];

    for (MapEntry<int, dynamic> e in oldMap.entries) {
      if (e.value == oldValue) {
        keyList.add(e.key);
      }
    }
    for (int key in keyList) {
      newMap[key] = newValue;
    }
    return newMap;
  }

  static Map<int, dynamic> moveValue({
    required Map<int, dynamic> oldMap,
    required var moveValue,
    required bool isPositionStart,
  }) {
    // if (!oldMap.containsValue(moveValue) || oldMap.isEmpty) {
    //   throw Exception(
    //       "{{{{{{{{{{ map empty or not contains value = $moveValue }}}}}}}}}}");
    // }

    Map<int, dynamic> mapWithoutMoveValue = <int, dynamic>{};
    List<int> keyListMoveValue = <int>[];

    int i = 1;

    for (MapEntry<int, dynamic> e in oldMap.entries) {
      if (e.value == moveValue) {
        keyListMoveValue.add(e.key);
      } else {
        mapWithoutMoveValue[i] = e.value;
        i++;
      }
    }
    Map<int, dynamic> mapWithMoveValue = <int, dynamic>{};
    i = 1;

    if (isPositionStart) {
      for (int key in keyListMoveValue) {
        mapWithMoveValue[i] = moveValue;
        i++;
      }
      for (MapEntry<int, dynamic> e in mapWithoutMoveValue.entries) {
        mapWithMoveValue[i] = e.value;
        i++;
      }
    } else {
      for (MapEntry<int, dynamic> e in mapWithoutMoveValue.entries) {
        mapWithMoveValue[i] = e.value;
        i++;
      }
      for (int key in keyListMoveValue) {
        mapWithMoveValue[i] = moveValue;
        i++;
      }
    }

    return mapWithMoveValue;
  }
}
