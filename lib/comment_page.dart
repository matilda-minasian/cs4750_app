import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Comments extends StatelessWidget {
  final String title;
  final String comment;
  String title2 = "";
  String description = "";
  createToDo() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('Comments').doc(title).collection('Comment').doc(title2);
    Map<String, String> readList = {
      "Title": title2,
      "Comment": description
    };
    documentReference.set(readList);
  }
  deleteTodo(item) {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Comments").doc(title).collection('Comment').doc(item);

    documentReference.delete();
  }
  Comments(this.title, this.comment);


  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;
    final uemail = user.email.toString();
    title2 = uemail;
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body:
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blueAccent,
                    Colors.orangeAccent,
                  ]
              )
          ),
        child:
        Column(
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    title:
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle:
                    Text(
                      comment,
                    ),
                    tileColor: Colors.orangeAccent,
                  ),
                  Container(
                    color: Colors.orangeAccent,
                    alignment: Alignment.bottomRight,
                    child:
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: const Text("Add Comment"),
                                content: Container(
                                  width: 400,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Text(uemail),
                                      // TextField(
                                      //   onChanged: (String value) {
                                      //     title2 = value;
                                      //   },
                                      // ),
                                      TextField(
                                        onChanged: (String value) {
                                          description = value;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        createToDo();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Add"))
                                ],
                              );
                            });

                      },
                      child: Text('Comment'),
                    ),
                  ),
                  Container(
                    child:
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('Comments').doc(title).collection('Comment').snapshots(),
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
                                        tileColor: Colors.lightBlueAccent,
                                        onTap: () {
                                        },
                                        title: Text((documentSnapshot != null) ? (documentSnapshot["Title"]) : "",style: TextStyle(fontWeight: FontWeight.bold),),
                                        subtitle: Text((documentSnapshot != null)
                                            ? ((documentSnapshot["Comment"] != null)
                                            ? documentSnapshot["Comment"]
                                            : "")
                                            : ""),

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
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
