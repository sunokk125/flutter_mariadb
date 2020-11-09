import 'package:flutter/material.dart';
import 'package:flutter_graphql/service/GraphqlService.dart';

class UpdateUserPage extends StatefulWidget {
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<UpdateUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwChkController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController corpIdController = TextEditingController();

  String _no;

  void dispose() {
    print("dispose() of LoginPage");
    super.dispose();
  }

  @override
  void initState() {
    nameController.text = "3213123";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context).settings.arguments;

    _no = args['no'];
    print(_no);

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
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "이름"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: idController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "아이디"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: pwController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "비밀번호"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: pwChkController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "비밀번호 확인"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "ex) 010-0000-0000"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "ex) example@gmail.com"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: corpIdController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "회사 아이디"),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Color.fromRGBO(39, 50, 56, 1.0),
                child: Text('Update'),
                onPressed: () {
                  GraphqlService.updateUserService(
                      _no,
                      idController.text,
                      pwController.text,
                      nameController.text,
                      emailController.text,
                      phoneController.text,
                      corpIdController.text);

                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.grey,
                  child: Text('Back'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
