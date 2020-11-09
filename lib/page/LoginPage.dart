import 'package:flutter/material.dart';
import 'package:flutter_graphql/service/AuthService.dart';

class LoginPage extends StatefulWidget {
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void dispose() {
    print("dispose() of LoginPage");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 100),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'LOGIN',
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
                    border: OutlineInputBorder(), labelText: "아이디"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "비밀번호"),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Color.fromRGBO(39, 50, 56, 1.0),
                child: Text('Sign In'),
                onPressed: () async {
                  await AuthService.setTokenByLogin(
                          nameController.text, passwordController.text)
                      .then((value) {
                    bool result = AuthService.login();
                    if (result) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => UserListPage()),
                      // );
                      print(value);
                      print(result);
                      nameController.clear();
                      passwordController.clear();
                      Navigator.pushNamed(context, '/main');
                    }
                  });
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
                child: Text('Sign Up'),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => UserListPage()),
                  // );
                  nameController.clear();
                  passwordController.clear();
                  Navigator.pushNamed(context, '/signUp');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
