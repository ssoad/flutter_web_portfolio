import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Soad's Portfolio",
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "Soad's Portfolio"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  child: Text("<Soad's Portfolio/>",
                      style: TextStyle(fontSize: 30.0)),
                ),
              ),
              Expanded(flex: 3, child: NavigationBar()),
            ],
          ),
        ],
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        NavigationItem(name: "Skills"),
        NavigationItem(name: "Work Experiences"),
        NavigationItem(name: "Education"),
        NavigationItem(name: "Projects"),
        NavigationItem(name: "Open Source"),
        NavigationItem(name: "Achievements"),
        NavigationItem(name: "Contact"),
      ],
    );
  }
}

class NavigationItem extends StatelessWidget {
  final String name;
  const NavigationItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: MaterialButton(
          onPressed: () {},
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
