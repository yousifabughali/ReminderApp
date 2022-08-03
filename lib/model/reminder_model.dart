import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reminder_second_project/model/list_model.dart';

class ReminderModel {
  late int id;
  late String title;
  late String content;
  late int? listId;
  DateTime? day;
  DateTime? time;
  // ListModel? listIdModel;

  ReminderModel();

  ReminderModel.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    title = rowMap['title'];
    content = rowMap['content'];
    listId=rowMap['listId'];
    day = DateTime.tryParse(rowMap['day']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['title'] = title;
    map['content'] = content;
    map['listId']=listId;
    map['day'] = day.toString();
    return map;
  }
}
