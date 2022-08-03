
import 'package:flutter/material.dart';

class ListModel {
  late int id;
  late String title;
  late Color list_color;

  ListModel();

  ListModel.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    title = rowMap['title'];
    list_color = Color(int.parse(rowMap['color']));
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['title'] = title;
    map['color'] = list_color.value.toString();
    return map;
  }

}
