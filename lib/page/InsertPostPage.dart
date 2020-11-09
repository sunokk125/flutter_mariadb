import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_graphql/service/GraphqlService.dart';

class InsertPostPage extends StatefulWidget {
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<InsertPostPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(39, 50, 56, 1.0),
          title: Text("Flutter"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Title',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contents',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: TextField(
                  maxLines: 10,
                  controller: contentsController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Color.fromRGBO(39, 50, 56, 1.0),
                      child: Text('Post'),
                      onPressed: () async {
                        await GraphqlService.createPostService(
                            titleController.text,
                            contentsController.text,
                            GraphqlService.getUserNo());
                        titleController.clear();
                        contentsController.clear();
                        Navigator.pop(context);
                      })),
            ],
          ),
        ));
  }
}
