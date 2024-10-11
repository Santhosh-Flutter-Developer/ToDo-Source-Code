import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:to_do/viewmodels/add_task_provider.dart';
import 'package:to_do/viewmodels/date_time_provider.dart';
import 'package:to_do/viewmodels/field_provider.dart';
import 'package:to_do/viewmodels/service_provider.dart';
import 'package:to_do/views/home/home_view_mobile.dart';

import '../../viewmodels/radio_provider.dart';


class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    super.key,
    required this.getIndex,
  });

final int getIndex;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final todoData= ref.watch(fetchStreamProvider);
    return todoData.when(data: (todoData) {
      Color categoryColor= Colors.white;
      final getCategory = todoData[getIndex].category;
      switch(getCategory){
        case "Learning":
        categoryColor = Colors.green;
        break;
        case "Working":
        categoryColor = Colors.blue.shade700;
        break;
        case "General":
        categoryColor = Colors.amber.shade700;
        break;
      }
      DateTime givenDate = DateFormat('M/d/yyyy').parse(todoData[getIndex].dateTask.toString());
     
    
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Check if the given date is today
    bool isToday = givenDate.year == currentDate.year &&
        givenDate.month == currentDate.month &&
        givenDate.day == currentDate.day;

      return Container(
      margin:const EdgeInsets.symmetric(vertical: 6),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: categoryColor,
                borderRadius:const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)
                )
                
              ),
              width: 20,
            ),
           Expanded(child: Padding(padding:const EdgeInsets.symmetric(horizontal: 10),child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading:InkWell(
                    onTap: (){
                       ref.read(serviceProvider).deleteTask(todoData[getIndex].docID);
                    },
                    child: Icon(CupertinoIcons.delete)),
                  
                  title: Text(todoData[getIndex].titleTask,maxLines: 2,style: TextStyle(
                    decoration: todoData[getIndex].isDone?TextDecoration.lineThrough:TextDecoration.none,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.w800
                  ),),
                  subtitle: Text(todoData[getIndex].description,maxLines: 2,style: TextStyle(
                    decoration: todoData[getIndex].isDone?TextDecoration.lineThrough:TextDecoration.none,overflow: TextOverflow.ellipsis,fontSize: 12,
                  ),),
                  trailing: Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      activeColor: Colors.blue.shade800,
                      shape: const CircleBorder(),
                      value: todoData[getIndex].isDone, onChanged: (value)=>ref.read(serviceProvider).archiveTask(todoData[getIndex].docID, value)),
                  ),
                ),
               Transform.translate(
                offset:const Offset(0, -12)
            ,                     child: Column(
                  children: [ 
                    Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade200,
                 ),
                 Row(
                  children: [
                   Expanded(
                     child: Text("${isToday?"Today":todoData[getIndex].dateTask.toString()} ${todoData[getIndex].timeTask}",style: TextStyle(fontStyle: FontStyle.italic),),
                   ),
                   IconButton(onPressed: (){
                   ref.watch(titleController).text=todoData[getIndex].titleTask;
                   ref.watch(descriptionController).text=todoData[getIndex].description;
        
                   ref.read(dateProvider.notifier).update((state) => todoData[getIndex].dateTask);
                   ref.read(timeProvider.notifier).update((state) => todoData[getIndex].timeTask);
                   int category=0;
                   switch (todoData[getIndex].category){
                     case "Learning":
          category=1;
          break;
          case "Working":
          category=2;
          break;
          case "General":
          category=3;
          break;
                   }
        
                   ref.read(radioProvider.notifier).update((state) => category);
                   ref.read(editID.notifier).update((state) =>todoData[getIndex].docID! );
                   ref.read(isDone.notifier).update((state) =>todoData[getIndex].isDone );
                   if(MediaQuery.of(context).size.width>1000){
        ref.read(addTaskProvider.notifier).update((state) => true);}else{
            showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context, builder: (context)=> AddNewTaskModel());
        }
                   }, icon:const Icon(
                    Icons.edit
                   ))
                  ],
                 )],
                 ),
               )
            
              ],
            ),))
          ],
        ),
      ),
    );
    }, error: (error, stackTrace) =>const Center(
      child: Text("error"),
    ), loading: ()=>const Center(
      child: CircularProgressIndicator(),
    ));
    
  }
}