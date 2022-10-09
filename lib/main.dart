import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './themes/colours.dart';
import './pages/social_determinants.dart';
import './pages/aces.dart';

void main() {
  runApp(const RCPCHWHAMApp());
}

class RCPCHWHAMApp extends StatelessWidget {
  const RCPCHWHAMApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
    return SafeArea(
      child: Scaffold(
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
                          builder: (context) => const HistoryGuideRoute(
                              title:
                                  'Identifying Social Determinants of Health')));
                },
              ),
              ListTile(
                title: const Text('ACES'),
                onTap: () => {
                  // close the drawer
                  Navigator.pop(context),
                  // push to ACES page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ACESRoute(
                                title: 'ACES',
                              )))
                },
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Center(
              child: Text(
                'Health Inequalities',
                style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 40,
                    color: TextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Image(
                image: AssetImage('assets/incubator-white.png'),
                fit: BoxFit.fitWidth,
                width: 300,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Image(
                image: AssetImage('assets/whamlogo.png'),
                fit: BoxFit.fitWidth,
                width: 150,
              ),
            ),
          ],
        ),
        floatingActionButton: FabCircularMenu(
            fabOpenColor: PrimaryColour,
            fabCloseColor: PrimaryColour,
            ringColor: PrimaryColour,
            alignment: Alignment.bottomCenter,
            children: [
              InkWell(
                  onTap: () => Get.to(() =>
                      const SDOHRoute(title: 'Social Determinants of Health')),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: const [
                    Icon(CupertinoIcons.gauge_badge_minus),
                    Text(
                      'Deprivation Score',
                      style: TextStyle(
                          fontFamily: 'Montserrat', color: Colors.white),
                    )
                  ])),
              InkWell(
                  onTap: () => Get.to(() =>
                      const ACESRoute(title: 'Adverse Childhood Experiences')),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: const [
                    Icon(CupertinoIcons.exclamationmark_shield),
                    Text(
                      'ACES',
                      style: TextStyle(
                          fontFamily: 'Montserrat', color: Colors.white),
                    )
                  ])),
              InkWell(
                  onTap: () => Get.to(() => const HistoryGuideRoute(
                      title: 'Identifying Social Determinants of Health')),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: const [
                    Icon(CupertinoIcons.bubble_left_bubble_right),
                    Text(
                      'Social Determinants',
                      style: TextStyle(
                          fontFamily: 'Montserrat', color: Colors.white),
                    )
                  ])),
            ]),
      ),
    );
  }
}

class HistoryGuideRoute extends StatelessWidget {
  const HistoryGuideRoute({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: const Center(
            child: Text(
          'How to take a history of social determinants of health.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: TextColor),
        )));
  }
}
