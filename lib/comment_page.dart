import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Comments extends StatelessWidget {
  final String title;
  final String comment;
  Comments(this.title, this.comment);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body:
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
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child:
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Comment'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
