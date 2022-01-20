import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Want extends StatefulWidget {
  const Want({Key? key}) : super(key: key);

  @override
  _WantState createState() => _WantState();
}

class _WantState extends State<Want> {
  String title = "";
  String description = "";
  var user = FirebaseAuth.instance.currentUser;
  createToDo() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('Want to Read').doc(user?.uid).collection('Future').doc(title);
    Map<String, String> readList = {
      "futureTitle": title,
      "futureDescription": description
    };
    documentReference.set(readList).whenComplete(() => print("Data Stored"));
  }
  deleteTodo(item) {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Want to Read").doc(user?.uid).collection('Future').doc(item);

    documentReference.delete().whenComplete(() => print("deleted successfully"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Want to Read'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Want to Read').doc(user?.uid).collection('Future').snapshots(),
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
                          title: Text((documentSnapshot != null) ? (documentSnapshot["futureTitle"]) : ""),
                          subtitle: Text((documentSnapshot != null)
                              ? ((documentSnapshot["futureDescription"] != null)
                              ? documentSnapshot["futureDescription"]
                              : "")
                              : ""),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                //todos.removeAt(index);
                                deleteTodo((documentSnapshot != null) ? (documentSnapshot["futureTitle"]) : "");
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
                    margin: EdgeInsets.only(bottom: 10),
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
