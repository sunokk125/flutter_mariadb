import 'package:flutter/material.dart';
import 'package:flutter_graphql/service/GraphqlService.dart';

class SignUpPage extends StatefulWidget {
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwChkController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController corpIdController = TextEditingController();

  void dispose() {
    print("dispose() of LoginPage");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),
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
                child: Text('Sign Up'),
                onPressed: () {
                  GraphqlService.createUserService(
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
