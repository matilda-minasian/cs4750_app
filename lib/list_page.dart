import 'package:cs4750app/already_read.dart';
import 'package:cs4750app/currently_reading.dart';
import 'package:cs4750app/want_read.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Lists'),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child:
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlreadyRead()),
                );
              },
              child: Text('Already Read'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child:
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Current()),
                );
              },
              child: Text('Currently Reading'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child:
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Want()),
                );
              },
              child: Text('Want to Read'),
            ),
          ),
        ],
      )
    );
  }
}
