import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:to_do/models/todo_model.dart';
import 'package:to_do/utils/app_style.dart';
import 'package:to_do/utils/widgets/card_todo_widget.dart';
import 'package:to_do/utils/widgets/date_time_widget.dart';
import 'package:to_do/utils/widgets/radio_widget.dart';
import 'package:to_do/utils/widgets/textfield_widget.dart';
import 'package:to_do/viewmodels/add_task_provider.dart';
import 'package:to_do/viewmodels/date_time_provider.dart';
import 'package:to_do/viewmodels/field_provider.dart';
import 'package:to_do/viewmodels/radio_provider.dart';
import 'package:to_do/viewmodels/service_provider.dart';


class HomeViewMobile extends ConsumerWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final todoData= ref.watch(fetchStreamProvider);
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title:ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade200,
            radius: 25,
            child: Image.asset("assets/avator.jpg"),
          ),
          title: Text('Hello I\'m',style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade400
          ),),
          subtitle:const Text("Santhosh",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        ),
        actions: [
          Padding(padding:const EdgeInsets.symmetric(horizontal: 20),child: Row(
            children: [
              IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.calendar)),
              IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.bell))
            ],
          ),)
        ],
      ),
    body: SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30),child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical:20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const Text("Todo Plan's",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),),
                    Text("${DateFormat('EEEE').format(DateTime.now())}, ${DateTime.now().day} ${DateFormat('MMMM').format(DateTime.now())}",style:const TextStyle(
                      color: Colors.grey
                    ),),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color(0xFFD5E8FA),
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    )
                  ),
                 
                  onPressed: (){
                      ref.watch(titleController).clear();
                     ref.watch(descriptionController).clear();
                     ref.read(radioProvider.notifier).update((state) => 0);
                     ref.read(dateProvider.notifier).update((state) => "dd/mm/yy");
                     ref.read(timeProvider.notifier).update((state) => "hh : mm");
                    ref.read(addTaskProvider.notifier).update((state) => true);
                    ref.read(editID.notifier).update((state) =>"");
                    showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context, builder: (context)=> AddNewTaskModel());}, child:const Text("+ New Task"))
              ],
            ),
          ),
          ListView.builder(
            itemCount: todoData.value?.length??0,
            shrinkWrap: true,
            itemBuilder: (context,index)=> CardTodoListWidget(getIndex: index,)),
        
        ],
      ),),
    ),
    );
  }
}



class AddNewTaskModel extends ConsumerWidget {
   AddNewTaskModel({
    super.key,
  });
// final titleController= TextEditingController();
// final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final dateProv =ref.watch(dateProvider);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding:const EdgeInsets.all(30),
      
      decoration:const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(ref.watch(editID)!=""?"Edit Task Todo": "New Task Todo",textAlign: TextAlign.center,style:const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),)),
            Divider(
              thickness: 1.2,
              color: Colors.grey.shade200,
            ),
          const Padding(
             padding:  EdgeInsets.only(top:12.0),
             child:  Text("Title Task",style: AppStyle.headingOne,),
           ),
             Padding(
              padding:const EdgeInsets.only(top:6.0),
              child: TextFieldWidget(
                txtController: ref.watch(titleController),
                hintText: "Add Task Name",maxLine: 1,),
            ),
            const Padding(
             padding:  EdgeInsets.only(top:12.0),
             child:  Text("Description",style: AppStyle.headingOne,),
           ),
             Padding(
              padding:const EdgeInsets.only(top:6.0),
              child: TextFieldWidget(
                txtController: ref.watch(descriptionController),
                hintText: "Add Descriptions",maxLine: 5,),
            ),
            const Padding(
             padding:  EdgeInsets.only(top:12.0),
             child:  Text("Description",style: AppStyle.headingOne,),
           ),
            Padding(
              padding:const EdgeInsets.only(top:6.0),
              child: Row(
                children: [
                   Expanded(child: RadioWidget(
                    categColor: Colors.green,
                    titleRadio: "LRN",
                    valueInput: 1,
                   onChangeValue: () => ref.read(radioProvider.notifier).update((state) => 1),
                  )),
                  Expanded(child: RadioWidget(
                    categColor: Colors.blue.shade700,
                    titleRadio: "WRK",
                    valueInput: 2,
                    onChangeValue: () => ref.read(radioProvider.notifier).update((state) => 2),
                  )),
                  Expanded(child: RadioWidget(
                    categColor: Colors.amberAccent.shade700,
                    titleRadio: "GEN",
                    valueInput: 3,
                    onChangeValue: () => ref.read(radioProvider.notifier).update((state) => 3),
                  )),
                ],
              )
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimeWidget(
                  titleText: "Date",valueText: dateProv,iconSection: CupertinoIcons.calendar,
                  onTap: () async{
                   final getValue= await showDatePicker(context: context,initialDate: DateTime.now(),firstDate: DateTime(1990),lastDate: DateTime(2100));
                   if(getValue!=null){
                    final format = DateFormat.yMd();
                    ref.read(dateProvider.notifier).update((state) => format.format(getValue));
                   }
                  },
                ),
              const SizedBox(
                  width: 22,
                ),
                 DateTimeWidget(
                  titleText: "Time",valueText: ref.watch(timeProvider),iconSection: CupertinoIcons.clock,
                  onTap: () async{
                   final getTime=await showTimePicker(context: context,initialTime: TimeOfDay.now());
                   if(getTime!=null){
                    ref.read(timeProvider.notifier).update((state) => getTime.format(context));
                   }
                  },
                 )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top:12.0),
              child: Row(
                children: [
                  Expanded(child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      side: BorderSide(
                        color: Colors.blue.shade800
                      ),
                      padding:const EdgeInsets.symmetric(vertical: 14)
                    ),
                    onPressed: (){
                     if(width>1000){
ref.read(addTaskProvider.notifier).update((state) => false);
                     }else{
Navigator.pop(context);
                     }
                    }, child:const Text("Cancel"))),
                 const SizedBox(
                      width: 20,
                    ),
                  Expanded(child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      
                      padding:const EdgeInsets.symmetric(vertical: 14)
                    ),
                    onPressed: (){
      final getRadioValue= ref.read(radioProvider);
      String category="";
      switch(getRadioValue){
        case 1:
        category="Learning";
        break;
        case 2:
        category="Working";
        break;
        case 3:
        category="General";
        break;
      }
      if(ref.watch(editID)==""){
                      ref.read(serviceProvider).addNewTask(
                        TodoModel(titleTask: ref.watch(titleController).text, description: ref.watch(descriptionController).text, category: category, dateTask: ref.read(dateProvider), timeTask: ref.read(timeProvider),isDone: false)
                      );}else{
                        ref.read(serviceProvider).updateTask(ref.watch(editID),TodoModel(titleTask: ref.watch(titleController).text, description: ref.watch(descriptionController).text, category: category, dateTask: ref.read(dateProvider), timeTask: ref.read(timeProvider),isDone: ref.read(isDone)) );
                      }
                     ref.watch(titleController).clear();
                     ref.watch(descriptionController).clear();
                     ref.read(radioProvider.notifier).update((state) => 0);
                     ref.read(dateProvider.notifier).update((state) => "dd/mm/yy");
                     ref.read(timeProvider.notifier).update((state) => "hh : mm");
                     if(width>1000){
ref.read(addTaskProvider.notifier).update((state) => false);
                     }else{
Navigator.pop(context);
                     }
                     
                    }, child: Text(ref.watch(editID)!=""?"Update": "Create")))
                ],
              ),
            )
          ],
        ),
      ),
                    ),
    );
  }
}



