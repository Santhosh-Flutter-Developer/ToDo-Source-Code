

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleController= StateProvider<TextEditingController>((ref){
  return TextEditingController();
});

final descriptionController= StateProvider<TextEditingController>((ref){
  return TextEditingController();
});