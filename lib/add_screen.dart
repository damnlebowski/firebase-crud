import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection('test');
    final nameCtr = TextEditingController();
    final ageCtr = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: nameCtr,
            ),
            TextField(
              maxLength: 2,
              controller: ageCtr,
            ),
            ElevatedButton(
                onPressed: () async {
                  await ref.add(
                      {"name": nameCtr.text.trim(), "age": ageCtr.text.trim()});
                  Navigator.of(context).pop();
                },
                child: const Text('Add'))
          ],
        ),
      ),
    );
  }
}
