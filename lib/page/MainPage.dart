import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_graphql/service/AuthService.dart';
import 'package:flutter_graphql/service/GraphqlService.dart';
import 'package:flutter_graphql/graphql/QueryMutation.dart';

class MainPage extends StatefulWidget {
  MainPage();
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<MainPage> {
  VoidCallback refetchQuery;
  static List<LazyCacheMap> posts;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _corpIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _userId, _no;
  int _corpId;

  @override
  void initState() {
    getUser();
    getCorp();
    getNo();
    super.initState();
  }

  @override
  void dispose() {
    print("dispose() of MainPage");
    super.dispose();
  }

  void getNo() {
    setState(() {
      _no = GraphqlService.getUserNo();
      print(_no);
    });
  }

  void getUser() {
    setState(() {
      _userId = GraphqlService.getUserId();
      print(_userId);
    });
  }

  void getCorp() {
    setState(() {
      _corpId = GraphqlService.getCorpId();
      print(_corpId);
    });
  }

  /*final CupertinoTabController _controller =
      CupertinoTabController(initialIndex: 1);

  int _selectedIndex = 1;*/

  @override
  Widget build(BuildContext context) {
    /*return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account), title: Text('내정보')),
          BottomNavigationBarItem(icon: Icon(Icons.work), title: Text('작업')),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), title: Text('배차')),
        ],
      ),
      controller: _controller,
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return SignUpPage();
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return SignUpPage();
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return SignUpPage();
              },
            );
        }
      },
    );*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(39, 50, 56, 1.0),
        title: Text("Flutter"),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              AuthService.logout();
              Navigator.pop(context);
            },
            child: Text("Logout"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(child: Text('Drawer Header')),
            ListTile(
              title: Text('정보 수정'),
              onTap: () {
                print(_no);
                Navigator.pushNamed(context, '/updateUser',
                    arguments: <String, String>{'no': _no});
              },
            ),
            ListTile(
              title: Text('닫기'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/insertPost').then((value) {
            Navigator.pushReplacementNamed(context, '/main');
          });
        },
      ),
      resizeToAvoidBottomInset: false,
      body: Query(
        options: QueryOptions(
          documentNode: gql(QueryMutation.fetchPost(_corpId)),
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
          posts = (result.data['getPostsList'] as List<dynamic>)
              .cast<LazyCacheMap>();

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              dynamic responseData = posts[index];
              var no = responseData["No"];
              var title = responseData["Title"];
              var userName = responseData.data['Writer'];
              var count = responseData.data['Counter'];
              var date = new DateTime.fromMicrosecondsSinceEpoch(
                1000 * int.parse(responseData['CreatedDate']),
              );
              //var corpData = {
              //  "corpId": responseData['corpId']['corpId'],
              //  "corpName": responseData['corpId']['corpName'],
              //  "corpContactNumber": responseData['corpId']
              //      ['corpContactNumber'],
              //};
              return ListTile(
                title: Text("$title"),
                subtitle: Text("$userName   |   $date"),
                trailing: Text("조회수 $count"),
                onTap: () {
                  Navigator.pushNamed(context, '/detailPost',
                      arguments: <String, String>{'postNo': no});
                },
              );
            },
          );
        },
      ),
    );
  }
}
