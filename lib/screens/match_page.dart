import 'package:circl_up_app/screens/camera_page.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.orange,
            child: Text(
              'C',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'You have been\nCIRCL’d UP',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Take a picture with the following people to receive your points!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/samantha_picture.png'),
            ),
            title: Text("Samantha Phil"),
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/john_picture.png'),
            ),
            title: Text("John Doe"),
          ),
          const SizedBox(height: 40),
          if (!isPhotoCapturedGlobal)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CameraPage(
                      onPhotoCaptured: () {
                        setState(() {
                          isPhotoCapturedGlobal = true;
                        });
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text("Take Photo"),
            )
          else
            const Text(
              '1/3 successfully uploaded',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          const SizedBox(height: 30),
          const Text(
            '100 CIRCLES',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed('/group-chat');
            },
            icon: const Icon(Icons.chat),
            label: const Text("Group Chat"),
          ),
        ],
      ),
    );
  }
}