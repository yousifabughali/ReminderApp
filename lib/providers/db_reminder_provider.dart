

import 'package:flutter/material.dart';
import 'package:reminder_second_project/db/reminder_db_crud.dart';
import 'package:reminder_second_project/model/reminder_model.dart';

class ReminderProvider extends ChangeNotifier{
  List<ReminderModel> reminders= <ReminderModel>[];
  ReminderDbController _remindersDbController = ReminderDbController();

  Future <bool> create({required ReminderModel reminder}) async {
    int newRowId= await _remindersDbController.create(reminder);
    if(newRowId!=0){
      reminder.id=newRowId;
      reminders.add(reminder);
      notifyListeners();

    }
    return newRowId !=0;
  }

  Future <void> read() async {
    reminders= await _remindersDbController.read();
    notifyListeners();
  }

  Future<bool> update({required ReminderModel reminder}) async {
    bool updated = await _remindersDbController.update(reminder);
    if(updated){
      int index= reminders.indexWhere((element) => element.id == reminder.id);
      if(index != -1){
        reminders[index]=reminder;
      }
      notifyListeners();
    }
    return updated;
  }
  Future<bool> delete({required int id}) async{
    bool deleted = await _remindersDbController.delete(id);
    if(deleted){
      reminders.removeWhere((element) => element.id==id);
      notifyListeners();
    }
    return deleted;
  }
  Future<bool> deletedByList({required int id}) async{
    bool deleted = await _remindersDbController.delete(id);
    if(deleted){
      reminders.removeWhere((element) => element.listId==id);
      notifyListeners();
    }
    return deleted;
  }

}