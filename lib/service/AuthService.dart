import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_graphql/graphql/QueryMutation.dart';
import 'package:flutter_graphql/service/GraphqlService.dart';

class AuthService {
  static var client = GraphqlService.client();

  static bool login() {
    print("login test");
    bool result = GraphqlService.checkToken();
    return result;
  }

  static setTokenByLogin(String userId, String password) async {
    await client.value
        .query(QueryOptions(
            // ignore: deprecated_member_use
            document: QueryMutation.loginUser(userId, password),
            variables: {'userId': userId, 'password': password}))
        .catchError((onError) {
      print("client recieved null data : ${client.value}");
    }).then((value) async {
      //value null check
      if (value.data['login'] == null) {
        print("login error occured");
        return Fluttertoast.showToast(
            msg: "login error occured",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        var token = value.data['login']['token'];
        var userId = value.data['login']['user']['UserId'];
        int corpId = value.data['login']['user']['Company'];
        String no = value.data['login']['user']['No'];

        var returnResult = {
          "token": token,
          "userId": userId,
          "corpId": corpId,
          "no": no,
        };
        print("token : $token  , returnResult: $returnResult");
        GraphqlService.setToken(token, userId, corpId, no);
        return returnResult;
      }
    }).catchError((error) {
      return throw error;
    });
  }

  static logout() async {
    await GraphqlService.deleteToken();
    bool result = GraphqlService.checkToken();
    print(result);
  }
}
