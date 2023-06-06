import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Edit extends StatelessWidget {
  Edit({super.key, required this.name, required this.age, required this.id});
  String name;
  String age;
  String id;
  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection('test');
    final nameCtr = TextEditingController(text: name);
    final ageCtr = TextEditingController(text: age);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: nameCtr,
            ),
            TextField(
              maxLength: 2,
              controller: ageCtr,
            ),
            ElevatedButton(
                onPressed: () async {
                  await ref.doc(id).update(
                      {"name": nameCtr.text.trim(), "age": ageCtr.text.trim()});
                  Navigator.of(context).pop();
                },
                child: const Text('Update'))
          ],
        ),
      ),
    );
  }
}
