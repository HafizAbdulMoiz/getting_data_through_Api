import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pracfourthapi/user_model.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  getuser()async{
    var users = [];
    var response =await http.get(Uri.https("jsonplaceholder.typicode.com", "users"));
    var jsonData = jsonDecode(response.body);
    for (var i in jsonData) {
      UserModel user = UserModel(i["name"], i["username"],i["email"]);
      users.add(user);
    }
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getuser(),
        builder: (context ,AsyncSnapshot snapshot){
          if (snapshot.hasData == null) {
            return Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,i){
                return Container(
                  margin: EdgeInsets.only(top: 6.0),
                  child: ListTile(
                    tileColor: Color.fromARGB(255, 82, 6, 6),
                    textColor: Colors.yellow,
                    title: Text(snapshot.data[i].name),
                    subtitle: Text(snapshot.data[i].username),
                    trailing: Text(snapshot.data[i].email),
                  ),
                );
              });
          }
        })
    );
  }
}