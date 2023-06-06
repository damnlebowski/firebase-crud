import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/add_screen.dart';
import 'package:firebase_crud/edit_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection('test');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const CircularProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: Text('${snapshot.data!.docs[index]['name']}'),
                      subtitle: Text('${snapshot.data!.docs[index]['age']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Edit(
                                        name: snapshot.data!.docs[index]
                                            ['name'],
                                        age: snapshot.data!.docs[index]['age'],
                                        id: snapshot.data!.docs[index].id),
                                  )),
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () => ref
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete(),
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: snapshot.data!.docs.length),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Add(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
