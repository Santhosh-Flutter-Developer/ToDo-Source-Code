import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/models/todo_model.dart';

class TodoService{
  final todoCollection =FirebaseFirestore.instance.collection('todoApp');


//CREATE
void addNewTask (TodoModel model){
  todoCollection.add(model.toMap());
}


//ARCHIVE
void archiveTask(String? docID, bool? valueUpdate){
  todoCollection.doc(docID).update({
    'isDone':valueUpdate
  });
}
//UPDATE
void updateTask(String? docID, TodoModel model){
  todoCollection.doc(docID).update(model.toMap());
}

//DELETE
void deleteTask(String? docID){
  todoCollection.doc(docID).delete();
}


}