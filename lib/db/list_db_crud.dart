

import 'package:reminder_second_project/db/create_db.dart';
import 'package:reminder_second_project/model/list_model.dart';
import 'package:sqflite/sqflite.dart';

class ListDbController{
  Database database = DbProvider().database;

  Future<int> create(ListModel object) async {
    int newRowId = await database.insert('list', object.toMap());
    return newRowId;
  }


  Future<bool> delete(int id) async {
    int countsOfDeletedRows= await database.delete('list',where: 'id= ?',whereArgs: [id]);
    await database.delete('reminder',where: 'listId= ?',whereArgs: [id]);
    return countsOfDeletedRows > 0;
  }


  Future<List<ListModel>> read() async {
    List<Map<String, dynamic>> data = await database.query('list');
    return data.map((rowMap) => ListModel.fromMap(rowMap)).toList();
  }


  Future<ListModel?> show(int id) async {
    List<Map<String, Object?>> data = await database.query('list',where: 'id=?',whereArgs: [id]);
    if(data.isNotEmpty){
      return ListModel.fromMap(data.first);
    }
    return null;
  }


  Future<bool> update(ListModel object) async {
    int countsOfUpdatedRows = await database.update('list',  object.toMap(),where: 'id = ?',whereArgs: [object.id]);
    return countsOfUpdatedRows > 0;
  }
}