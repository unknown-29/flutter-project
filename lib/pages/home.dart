import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled3/pages/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  XFile? cameraFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void accessCamera() async {
    cameraFile = await ImagePicker().pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade200,
        actions: [
          GestureDetector(
            child: Icon(
              Icons.logout_rounded,
              size: 35,
              // onPressed: (){},
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login(),
                      settings: RouteSettings(
                          arguments: {'msg': 'logged out successfully'})));
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('hey ${data?['username']} ')),
          FloatingActionButton(
            child: Icon(size: 35, Icons.camera),
            onPressed: accessCamera,
          ),
        ],
      ),
    );
  }
}
