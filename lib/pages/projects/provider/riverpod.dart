import 'package:hooks_riverpod/hooks_riverpod.dart';


final taskTitle = StateProvider<String>((ref) => "");
final taskDescription = StateProvider<String>((ref) => "");
final taskDate = StateProvider<String>((ref) => "");