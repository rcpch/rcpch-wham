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

class WHAMHomePage extends StatelessWidget {
  const WHAMHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
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
          child: Column(
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
