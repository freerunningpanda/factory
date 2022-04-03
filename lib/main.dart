import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _containerList = [];

  void _addRedContainer() {
    setState(() {
      _containerList.add(ContainersFactory.factory(context, Containers.red));
    });
  }

  void _addGreenContainer() {
    setState(() {
      _containerList.add(ContainersFactory.factory(context, Containers.green));
    });
  }

  void _addBlueContainer() {
    setState(() {
      _containerList.add(ContainersFactory.factory(context, Containers.blue));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Factory method'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: ListView.builder(
            itemCount: _containerList.length,
            itemBuilder: (context, index) {
              return _containerList[index];
            }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _addRedContainer();
            },
            backgroundColor: Colors.redAccent,
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              _addGreenContainer();
            },
            backgroundColor: Colors.greenAccent,
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              _addBlueContainer();
            },
            backgroundColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}

enum Containers { red, green, blue }

abstract class ContainersFactory {
  static Widget factory(BuildContext context, Containers containers) {
    switch (containers) {
      case Containers.red:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        );
      case Containers.green:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        );
      case Containers.blue:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        );
      default:
        throw ArgumentError();
    }
  }
}
