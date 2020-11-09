import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_graphql/service/GraphqlService.dart';
import 'package:flutter_graphql/graphql/QueryMutation.dart';

class DetailPostPage extends StatefulWidget {
  DetailPostPage();
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<DetailPostPage> {
  TextEditingController comentController = TextEditingController();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();

  String _postId;
  String _userNo;

  VoidCallback refetchQuery;
  static List<LazyCacheMap> post;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context).settings.arguments;

    _postId = args['postNo'];
    _userNo = GraphqlService.getUserNo();

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
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Query(
                    options: QueryOptions(
                      documentNode: gql(QueryMutation.readPost(_postId)),
                    ),
                    builder: (QueryResult result,
                        {FetchMore fetchMore, VoidCallback refetch}) {
                      refetchQuery = refetch;
                      if (result.hasException) {
                        return Text(result.exception.toString());
                      }
                      if (result.loading) {
                        return Text('Loading');
                      }
                      post = (result.data['readPost'] as List<dynamic>)
                          .cast<LazyCacheMap>();

                      return Column(children: <Widget>[
                        Row(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 40),
                            child: Text(
                              "Title : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 26),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 40),
                            child: Text(
                              post[0]["Title"],
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                        ]),
                        Row(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 40),
                            child: Text(
                              "Writer : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 26),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 40),
                            child: Text(
                              post[0]["Writer"],
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                        ]),
                        Row(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 40),
                            child: Text(
                              "Contents",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 26),
                            ),
                          ),
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  post[0]["Contents"],
                                  style: TextStyle(fontSize: 26),
                                ),
                              ),
                            ]),
                        Container(
                          child: button(),
                        ),
                        Row(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 40),
                            child: Text(
                              "Coments ",
                              maxLines: 20,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 26),
                            ),
                          ),
                        ]),
                      ]);
                    }),
                inputComent(),
                coment(),
              ],
            )));
  }

  Widget inputComent() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: comentController,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  await GraphqlService.createComentService(
                      _postId, comentController.text, _userNo);
                  comentController.clear();
                  Navigator.pushReplacementNamed(context, '/detailPost',
                      arguments: <String, String>{'postNo': _postId});
                },
              ),
            )
          ],
        ));
  }

  Widget button() {
    if (post[0]["No"] == _userNo) {
      return ButtonBar(mainAxisSize: MainAxisSize.min, children: <Widget>[
        RaisedButton(
            color: Color.fromRGBO(39, 50, 56, 1.0),
            child: Text(
              "수정",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              _updatePostDialog(post[0]);
            }),
        RaisedButton(
            color: Colors.grey,
            child: Text("삭제"),
            onPressed: () {
              _deletePostDialog(post[0]);
            }),
      ]);
    } else {
      return null;
    }
  }

  Widget coment() {
    return Expanded(
        child: Query(
            options: QueryOptions(
              documentNode: gql(QueryMutation.getComents(_postId)),
            ),
            builder: (QueryResult result,
                {FetchMore fetchMore, VoidCallback refetch}) {
              refetchQuery = refetch;
              if (result.hasException) {
                return Text(result.exception.toString());
              }
              if (result.loading) {
                return Text('Loading');
              }
              post = (result.data['getComents'] as List<dynamic>)
                  .cast<LazyCacheMap>();

              return ListView.builder(
                  itemCount: post.length,
                  itemBuilder: (context, index) {
                    dynamic responseData = post[index];
                    var writer1 = responseData.data['Writer'];
                    var contents1 = responseData.data['Contents'];
                    //var date = new DateTime.fromMicrosecondsSinceEpoch(
                    //1000 * int.parse(responseData['CreatedDate']),
                    return ListTile(
                      title: Text("$contents1"),
                      subtitle: Text("$writer1"),
                    );
                  });
            }));
  }

  void _updatePostDialog(LazyCacheMap post) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Update Post"),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "Title"),
                    controller: titleController,
                  ),
                  TextField(
                    maxLines: 10,
                    decoration: InputDecoration(labelText: "Contents"),
                    controller: contentsController,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    print(post[0]);
                    if (titleController.text.isNotEmpty &&
                        contentsController.text.isNotEmpty) {
                      GraphqlService.updatePostService(_postId,
                          titleController.text, contentsController.text);
                    }
                    Navigator.pop(context);
                  },
                  child: Text("Update")),
              FlatButton(
                  onPressed: () {
                    titleController.clear();
                    contentsController.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ]);
      },
    );
  }

  void _deletePostDialog(LazyCacheMap post) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("delete Post"),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[Text("삭제하시겠습니까?")],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    GraphqlService.deletePostService(_postId);

                    Navigator.pop(context);
                  },
                  child: Text("Delete")),
              FlatButton(
                  onPressed: () {
                    titleController.clear();
                    contentsController.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ]);
      },
    );
  }
}
