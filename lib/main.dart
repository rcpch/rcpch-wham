import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './themes/colours.dart';
import './pages/social_determinants.dart';
import './pages/aces.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const RCPCHWHAMApp());
}

class RCPCHWHAMApp extends StatelessWidget {
  const RCPCHWHAMApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WHAM-RCPCH',
      theme: WhamTheme.defaultTheme,
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
                decoration: BoxDecoration(color: primaryColour),
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
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Center(
              child: Text(
                'Health Inequalities',
                style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 40,
                    color: textColor),
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
        floatingActionButton: Builder( // Use Builder to get a context within the widget tree
          builder: (context) {
            final colorScheme = Theme.of(context).colorScheme;  // Get the color scheme
            return CircularMenu(
            alignment: Alignment.bottomCenter,
            toggleButtonColor: colorScheme.primary,  // Use primary color for the toggle button
            items: [
              CircularMenuItem(
                  onTap: () => Get.to(() => const SDOHRoute(title: 'Social Determinants of Health')),
                  icon: CupertinoIcons.gauge_badge_minus,
                  color: colorScheme.secondaryContainer,  // Use secondary container for item background
                  iconColor: colorScheme.onSecondaryContainer, // Use onSecondaryContainer for icon
              ),
              CircularMenuItem(
                onTap: () => Get.to(() => const ACESRoute(title: 'Adverse Childhood Experiences')),
                icon: CupertinoIcons.exclamationmark_shield,
                color: colorScheme.secondaryContainer,  // Use secondary container for item background
                iconColor: colorScheme.onSecondaryContainer, // Use onSecondaryContainer for icon
              ),
              CircularMenuItem(
                onTap: () => Get.to(() => const HistoryGuideRoute(title: 'Identifying Social Determinants of Health')),
                icon: CupertinoIcons.bubble_left_bubble_right,
                color: colorScheme.secondaryContainer,  // Use secondary container for item background
                iconColor: colorScheme.onSecondaryContainer, // Use onSecondaryContainer for icon
              )
            ]);
                  },
                  ),
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
          style: TextStyle(fontSize: 14, color: textColor),
        )));
  }
}
