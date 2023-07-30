import 'package:flutter/material.dart';
import './Repository/User.dart';
import 'auth.dart';
import 'homePage.dart';
import 'login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Termins',
      routes: {
        '/homePage': (_) => MyHomePage(title: "Termins"),
        '/loginPage': (_) => Login(),
        '/LoginAuth': (_) => LoginAuth()
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const LoginAuth(),
    );
  }
}



//TODO w 
class testdb extends StatefulWidget {
  const testdb({super.key});

  @override
  State<testdb> createState() => _testdbState();
}

class _testdbState extends State<testdb> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<User>>(
          future: DatabaseHelper.instance.getUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Loading...'));
            }
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text('No Users in List.'),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: snapshot.data!.map((user) {
                            return Center(
                              child: Text(user.user_name),
                            );
                          }).toList(),
                        ),
                      ),
                      TextField(
                        controller: textController,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await DatabaseHelper.instance.add(User(
                              user_name: "muawdawwrataaawdaa",
                              user_email: "murat@gmail.com",
                              user_pass: "murat12345",
                              id: 4));
                          setState(() {
                            textController.clear();
                          });
                        },
                        child: const Text("ADD"),
                      ),
                    ],
                  );
          }),
    );
  }
}

