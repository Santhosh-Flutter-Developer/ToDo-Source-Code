import 'package:flutter_riverpod/flutter_riverpod.dart';

final addTaskProvider= StateProvider<bool>((ref) {
  return false;
});


final editID=StateProvider((ref){
  return "";
});

final isDone= StateProvider<bool>((ref) {
  return false;
});