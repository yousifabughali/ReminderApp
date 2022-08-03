import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/db/list_db_crud.dart';
import 'package:reminder_second_project/model/list_model.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';

class ListProvider extends ChangeNotifier{
  List<ListModel> list= <ListModel>[];
  final ListDbController _listsDbController = ListDbController();

  Future <bool> create({required ListModel list}) async {
    int newRowId= await _listsDbController.create(list);
    if(newRowId!=0){
      list.id=newRowId;
      this.list.add(list);
      notifyListeners();
    }
    return newRowId !=0;
  }


  Future <void> read() async {
    this.list= await _listsDbController.read();
    notifyListeners();
  }

  Future<bool> update({required ListModel list}) async {
    bool updated = await _listsDbController.update(list);
    if(updated){
      int index= this.list.indexWhere((element) => element.id == list.id);
      if(index != -1){
        this.list[index]=list;
      }
      notifyListeners();
    }
    return updated;
  }
  Future<bool> delete({required int id}) async{
    bool deleted = await _listsDbController.delete(id);
    if(deleted){
      this.list.removeWhere((element) => element.id==id);

      notifyListeners();
    }
    return deleted;
  }

}