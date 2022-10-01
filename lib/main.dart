import 'package:flutter/material.dart';
import './themes/colours.dart';
import './pages/social_determinants.dart';

void main() {
  runApp(const RCPCHWHAMApp());
}

class RCPCHWHAMApp extends StatelessWidget {
  const RCPCHWHAMApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WHAM-RCPCH',
      theme: whamTheme.defaultTheme,
      home: const WHAMHomePage(title: 'Wellbeing and Health Action Movement'),
    );
  }
}

class WHAMHomePage extends StatefulWidget {
  const WHAMHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<WHAMHomePage> createState() => _WHAMHomePageState();
}

class _WHAMHomePageState extends State<WHAMHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: PrimaryColour),
                child: Text('WHAM Menu'),
              ),
              ListTile(
                title: const Text('Social Determinants'),
                onTap: () {
                  // close the drawer
                  Navigator.pop(context);
                  // push to Social Determinants
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SDOHRoute(
                                title: 'Social Determinants of Health',
                              )));
                },
              ),
              ListTile(
                title: const Text('History Guide'),
                onTap: () {
                  // close the drawer
                  Navigator.pop(context);
                  // push to History page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryGuideRoute()));
                },
              ),
              ListTile(
                title: const Text('ACES'),
                onTap: () {
                  // close the drawer
                  Navigator.pop(context);
                  // push to ACES page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ACESRoute()));
                },
              ),
            ],
          ),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(30),
                child: Image(
                  image: AssetImage('assets/whamlogo.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Image(
                image: AssetImage('assets/incubator-white.png'),
                fit: BoxFit.fitWidth,
                width: 200,
              ),
            ],
          ),
        ));
  }
}

class HistoryGuideRoute extends StatelessWidget {
  const HistoryGuideRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History Guide'),
        ),
        body: const Center(
            child: Text(
          'How to approach the social history',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: TextColor),
        )));
  }
}

class ACESRoute extends StatelessWidget {
  const ACESRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Adverse Childhood Experiences'),
        ),
        body: const Center(
            child: Text(
          'Adverse Childhood Experiences',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: TextColor),
        )));
  }
}
