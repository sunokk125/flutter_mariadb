import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_graphql/graphql/QueryMutation.dart';

class GraphqlService {
  static var _token;
  static var _userId, _no;
  static int _corpId;

  static final HttpLink httpLink =
      HttpLink(uri: "http://10.1.57.187:3000/graphql");

  static setToken(String token, String userId, int corpId, String no) {
    _token = token;
    _userId = userId;
    _corpId = corpId;
    _no = no;
  }

  static deleteToken() {
    _token = null;
    _userId = null;
    _corpId = null;
    _no = null;
  }

  static bool checkToken() {
    if (_token != null)
      return true;
    else
      return false;
  }

  static String getUserNo() {
    print(_no);
    return _no;
  }

  static String getUserId() {
    print(_userId);
    return _userId;
  }

  static int getCorpId() {
    print(_corpId);
    return _corpId;
  }

  static createUserService(String userId, String userPW, String userName,
      String userEmail, String userMobile, String corpId) {
    client()
        .value
        .mutate(MutationOptions(
            // ignore: deprecated_member_use
            document: QueryMutation.createUser(
                userId, userPW, userName, userEmail, userMobile, corpId)))
        .then((value) {
      return Fluttertoast.showToast(
          msg: "user created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  static updateUserService(String no, String userId, String userPW,
      String userName, String userEmail, String userMobile, String corpId) {
    client()
        .value
        .mutate(MutationOptions(
            // ignore: deprecated_member_use
            document: QueryMutation.updateUser(
                no, userId, userPW, userName, userEmail, userMobile, corpId)))
        .then((value) {
      return Fluttertoast.showToast(
          msg: "user updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  static deleteUserService(String userId) {
    client()
        .value
        .mutate(MutationOptions(
            // ignore: deprecated_member_use
            document: QueryMutation.deleteUser(userId)))
        .then((value) {
      return Fluttertoast.showToast(
          msg: "user deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  static createPostService(String title, String contents, String writer) {
    client()
        .value
        .mutate(MutationOptions(
            // ignore: deprecated_member_use
            document: QueryMutation.createPost(title, contents, writer)))
        .then((value) {
      return Fluttertoast.showToast(
          msg: "post created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  static updatePostService(String postId, String title, String contents) {
    client()
        .value
        .mutate(MutationOptions(
            // ignore: deprecated_member_use
            document: QueryMutation.updatePost(postId, title, contents)))
        .then((value) {
      return Fluttertoast.showToast(
          msg: "post updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  static deletePostService(String postId) {
    client()
        .value
        .mutate(MutationOptions(
            // ignore: deprecated_member_use
            document: QueryMutation.deletePost(postId)))
        .then((value) {
      return Fluttertoast.showToast(
          msg: "post deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  static createComentService(String postId, String contents, String writer) {
    print(postId);
    print(contents);
    print(writer);
    client()
        .value
        .mutate(MutationOptions(
            // ignore: deprecated_member_use
            document: QueryMutation.createComent(postId, contents, writer)))
        .then((value) {
      return Fluttertoast.showToast(
          msg: "user created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  static final AuthLink authLink = AuthLink(getToken: () => _token);
  static final WebSocketLink websocketLink = WebSocketLink(
    url: 'http://10.1.52.217:3000/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
      //initPayload: {
      //'headers': {'Authorization': _token},
      //},
    ),
  );
  static final Link link = authLink.concat(httpLink).concat(websocketLink);

  static ValueNotifier<GraphQLClient> client() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
        link: link,
      ),
    );
    return client;
  }
}
