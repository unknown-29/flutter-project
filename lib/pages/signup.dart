import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled3/pages/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool passwordVisiblity = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  onSubmit() async {
    if (_formKey.currentState?.validate() == true) {

      // can also check if user already exists or not
      final querySnapshot = await FirebaseFirestore.instance
          .collection('mycollection')
          .where('username', isEqualTo: usernameController.text)
          .get();
      if(querySnapshot.docs.isEmpty){
        await FirebaseFirestore.instance.collection('mycollection').add({
          'username': usernameController.text,
          'password': passwordController.text,
        });
        usernameController.text = '';
        passwordController.text = '';
        FocusScope.of(context).unfocus();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login(),settings: RouteSettings(
          arguments: {'msg': 'yay you can now login with provided credentials'}
        )));
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login(),settings: RouteSettings(
          arguments: {'msg': 'seems like username already exists! so you may login now!'}
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('signup'),
        ),
        body: Center(
          child: (loading
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
                          // initialValue: '',
                          decoration: const InputDecoration(
                            labelText: 'username',
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                          ),
                          controller: usernameController,
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? "Enter username"
                                : null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // initialValue: ,
                          obscureText: !passwordVisiblity,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisiblity
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded),
                              onPressed: () {
                                setState(() {
                                  passwordVisiblity = !passwordVisiblity;
                                });
                              },
                            ),
                            labelText: 'password',
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                          ),
                          controller: passwordController,
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? "Enter password"
                                : null;
                          },
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: 'signup',
                        onPressed: () async {
                          setState(() {
                            loading = !loading;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Row(
                                  children: [
                                    SpinKitWaveSpinner(color: Colors.indigo),
                                    Text('Processing Data'),
                                  ],
                                ),
                              ),
                            );
                          });
                          await onSubmit();
                          setState(() {
                            loading = !loading;
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            Navigator.of(context).pushNamed('/home');
                          });
                        },
                        child: const Text('signup'),
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      FloatingActionButton(
                        heroTag: 'login',
                          onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));},
                        child: Text('already have an account! login now!'),
                      )
                    ],
                  ),
                )),
        ),
      ),
    );
  }
}
