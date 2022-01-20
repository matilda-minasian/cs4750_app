import 'package:cs4750app/comment_page.dart';
import 'package:cs4750app/list_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Elite Book Club');
  String title = "";
  String description = "";
  createToDo() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('Books').doc(title);
    Map<String, String> readList = {
      "Title": title,
      "Comment": description
    };
    documentReference.set(readList).whenComplete(() => print("Data Stored"));
  }
  deleteTodo(item) {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Books").doc(item);

    documentReference.delete().whenComplete(() => print("deleted successfully"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = const ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'type in book name...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );                }
                else {
                  customSearchBar = const Text('Elite Book Club');
                  customIcon = const Icon(Icons.search);
                }
              });
            },
            icon: customIcon,
          ),
        ],
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('Books').snapshots(),
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Comments(documentSnapshot!["Title"], documentSnapshot["Comment"])),
        );
      },
    title: Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text((documentSnapshot != null) ? (documentSnapshot["Title"]) : ""),
    ),
    subtitle: Text((documentSnapshot != null)
    ? ((documentSnapshot["Comment"] != null)
    ? documentSnapshot["Comment"]
        : "")
        : ""),
    trailing: IconButton(
    icon: const Icon(Icons.delete),
    color: Colors.red,
    onPressed: () {
    setState(() {
    //todos.removeAt(index);
    deleteTodo((documentSnapshot != null) ? (documentSnapshot["Title"]) : "");
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
      margin: EdgeInsets.only(bottom: 10),
      child:
      TextField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
            ),
            labelText: 'Book Title and Author',
            labelStyle: TextStyle(color: Colors.black)
        ),
        onChanged: (String value) {
          title = value;
        },
      ),
    ),
    TextField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
          ),
          labelText: 'Summary',
          labelStyle: TextStyle(color: Colors.black)
      ),
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
