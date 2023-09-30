import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled3/pages/home.dart';
import 'package:untitled3/pages/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool flag = true;
  bool passwordVisiblity = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  onSubmit() async {
    if (_formKey.currentState?.validate() == true) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('mycollection')
          .where('username', isEqualTo: usernameController.text)
          .get();
      print(querySnapshot.docs.first['password']);
      if (querySnapshot.docs.isNotEmpty) {
        if (querySnapshot.docs.first['password'] == passwordController.text) {
          // print("success ------------------------");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
                settings: RouteSettings(arguments: {
                  'username': usernameController.text,
                  'password': passwordController.text,
                }),
              ));
        }
      }
      usernameController.text = '';
      passwordController.text = '';
      // _formKey.currentState?.reset();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('---------------------------------+++++++++++++++++++++++++++++++++++');
    if (ModalRoute.of(context)!.settings.arguments != null && flag) {
      //flag -> solution to problem that login to home also displays logout snackbar
      flag = false;
      final data = ModalRoute.of(context)!.settings.arguments as Map;
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${data?['msg']}"))));
      // ModalRoute.of(context)!.settings.arguments=null;
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.green.shade200,
          title: Text('login'),
          centerTitle: true,
        ),
        body: (loading == true
            ? SpinKitFadingCircle(
                color: Colors.black,
              )
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'username',
                          alignLabelWithHint: true,
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'enter username'
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: !passwordVisiblity,
                        controller: passwordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon((passwordVisiblity == true)
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded),
                            onPressed: () {
                              setState(() {
                                passwordVisiblity = !passwordVisiblity;
                              });
                            },
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'password',
                          alignLabelWithHint: true,
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'enter password'
                            : null,
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: 'login',
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        await onSubmit();
                        setState(() {
                          loading = false;
                        });
                      },
                      child: Text('login'),
                      // disabledElevation: 10,
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    FloatingActionButton(
                        heroTag: 'signup',
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                        child: Text('dont have account! signup now!'))
                  ],
                ),
              )),
      ),
    ); //floatingActionButton: FloatingActionButton(   onPressed: null,
  }
}
