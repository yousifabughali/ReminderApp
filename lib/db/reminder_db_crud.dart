

import 'package:reminder_second_project/db/create_db.dart';
import 'package:reminder_second_project/model/reminder_model.dart';
import 'package:sqflite/sqflite.dart';

class ReminderDbController{
  Database database = DbProvider().database;

  Future<int> create(ReminderModel object) async {
    int newRowId = await database.insert('reminder', object.toMap());
    return newRowId;
  }

  Future<bool> delete(int id) async {
    int countsOfDeletedRows= await database.delete('reminder',where: 'id= ?',whereArgs: [id]);
    print(countsOfDeletedRows>0);
    return countsOfDeletedRows > 0;
  }


  Future<List<ReminderModel>> read() async {
    List<Map<String, dynamic>> data = await database.query('reminder');
    return data.map((rowMap) => ReminderModel.fromMap(rowMap)).toList();
  }

  Future<ReminderModel?> show(int id) async {
    List<Map<String, Object?>> data = await database.query('reminder',where: 'id=?',whereArgs: [id]);
    if(data.isNotEmpty){
      return ReminderModel.fromMap(data.first);
    }
    return null;
  }


  Future<bool> update(ReminderModel object) async {
    int countsOfUpdatedRows = await database.update('reminder',  object.toMap(),where: 'id = ?',whereArgs: [object.id]);
    return countsOfUpdatedRows > 0;
  }
}