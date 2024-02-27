import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:to_do/utils/widgets/card_todo_widget.dart';
import 'package:to_do/viewmodels/add_task_provider.dart';
import 'package:to_do/viewmodels/date_time_provider.dart';
import 'package:to_do/viewmodels/field_provider.dart';
import 'package:to_do/viewmodels/radio_provider.dart';
import 'package:to_do/viewmodels/service_provider.dart';
import 'package:to_do/views/home/home_view_mobile.dart';

import '../../utils/widgets/responsive_grid.dart';


class HomeViewTablet extends ConsumerWidget {
  const HomeViewTablet({super.key});

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
         ResponsiveGridRow(
                      children: List.generate(todoData.value?.length??0, (index) => ResponsiveGridCol(
                        xl:6,
                        lg:6,
                        md:6,
                        xs: 12,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CardTodoListWidget(getIndex: index),
                        ))),
                    )
        
        ],
      ),),
    ),
    );
  }
}