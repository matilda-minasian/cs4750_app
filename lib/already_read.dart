import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AlreadyRead extends StatefulWidget {
  const AlreadyRead({Key? key}) : super(key: key);

  @override
  _AlreadyReadState createState() => _AlreadyReadState();
}

class _AlreadyReadState extends State<AlreadyRead> {
  String title = "";
  String description = "";
  var user = FirebaseAuth.instance.currentUser;
  createToDo() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('Already Read').doc(user?.uid).collection('Read').doc(title);
    Map<String, String> readList = {
      "readTitle": title,
      "readDescription": description
    };
    documentReference.set(readList);
  }
  deleteTodo(item) {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Already Read").doc(user?.uid).collection('Read').doc(item);

    documentReference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Already Read'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Already Read').doc(user?.uid).collection('Read').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                  snapshot.data?.docs[index];
                  return Dismissible(
                      key: Key(index.toString()),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          tileColor: Colors.orangeAccent,
                          title: Text((documentSnapshot != null) ? (documentSnapshot["readTitle"]) : ""),
                          subtitle: Text((documentSnapshot != null)
                              ? ((documentSnapshot["readDescription"] != null)
                              ? documentSnapshot["readDescription"]
                              : "")
                              : ""),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                //todos.removeAt(index);
                                deleteTodo((documentSnapshot != null) ? (documentSnapshot["readTitle"]) : "");
                              });
                            },
                          ),
                        ),
                      ));
                });
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.red,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text("Add Book"),
                  content: Container(
                    width: 400,
                    height: 150,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child:
                          TextField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                labelText: 'Title',
                                labelStyle: TextStyle(color: Colors.black)
                            ),
                            onChanged: (String value) {
                              title = value;
                            },
                          ),
                        ),
                        Container(
                          child:
                          TextField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                labelText: 'Author',
                                labelStyle: TextStyle(color: Colors.black)
                            ),
                            onChanged: (String value) {
                              description = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          setState(() {
                            //todos.add(title);
                            createToDo();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text("Add"))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
