import 'package:flutter/material.dart';
import 'package:flutter_graphql/page/LoginPage.dart';
import 'package:flutter_graphql/page/SignUpPage.dart';
import 'package:flutter_graphql/page/MainPage.dart';
import 'package:flutter_graphql/page/InsertPostPage.dart';
import 'package:flutter_graphql/page/DetailPostPage.dart';
import 'package:flutter_graphql/page/UpdateUserPage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_graphql/service/GraphqlService.dart';

GraphqlService graphqlService = GraphqlService();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GraphQLProvider(
      client: GraphqlService.client(),
      child: CacheProvider(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/signUp': (context) => SignUpPage(),
          '/main': (context) => MainPage(),
          '/insertPost': (context) => InsertPostPage(),
          '/detailPost': (context) => DetailPostPage(),
          '/updateUser': (context) => UpdateUserPage(),
        });
  }
}
