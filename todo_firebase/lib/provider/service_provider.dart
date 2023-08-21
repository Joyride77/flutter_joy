import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/model/todo_model.dart';
import 'package:todo_firebase/services/todo_service.dart';

final serviceProvider = StateProvider<TodoService>((ref) {
  return TodoService();
});

final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('todoApp')
      .snapshots()
      .map((event) => event.docs.map((snapshot) => TodoModel.fromSnapshot(snapshot)).toList());
  yield* getData;
  return;
});
