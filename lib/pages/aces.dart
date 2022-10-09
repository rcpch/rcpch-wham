import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themes/colours.dart';
import '../constants/acesmodel.dart';

class ACESRoute extends StatefulWidget {
  const ACESRoute({super.key, required this.title});

  final String title;

  @override
  State<ACESRoute> createState() => _ACESRouteState();
}

class _ACESRouteState extends State<ACESRoute> {
  List<ACESModel> aces = [
    ACESModel('Domestic Violence',
        'Child has witnessed or been subject of domestic violence.', false),
    ACESModel('Parental Separation', 'Parents are separated.', false),
    ACESModel('Mental Ill Health',
        'Child has one or more parents with mental illness.', false),
    ACESModel(
        'Child Protection',
        'Child has been a victim of physical, sexual or emotional child abuse.',
        false),
    ACESModel('Neglect',
        'Child has been a victim of physical or emotional neglect.', false),
    ACESModel(
        'Forensic',
        'Child has been one or more parents who are or have been in prison.',
        false),
    ACESModel(
        'Drugs and Alcohol',
        'Child lives in a household where one or more members have drug or alcohol addiction.',
        false)
  ];

  List<ACESModel> selectedACES = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: PrimaryColourDark,
        ),
        body: SafeArea(
            child: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: aces.length,
                  itemBuilder: ((context, index) {
                    return acesItem(aces[index].title, aces[index].subtitle,
                        aces[index].isSelected, index);
                  }))),
          Card(
            child: ListTile(
              title: Text('Total ACES: ${selectedACES.length}'),
            ),
          ),
        ])));
  }

  Widget acesItem(String title, String subtitle, bool isSelected, int index) {
    return Card(
      child: ListTile(
        tileColor: isSelected ? PrimaryColourDark : PrimaryColour,
        leading: const CircleAvatar(
          backgroundColor: Colors.pink,
          child: Icon(
            CupertinoIcons.alarm,
            color: Colors.white,
          ),
        ),
        textColor: PrimaryColour,
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Montserrat', color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontFamily: 'Montserrat', color: Colors.white),
        ),
        onTap: () {
          setState(() {
            aces[index].isSelected = !aces[index].isSelected;
            if (aces[index].isSelected) {
              selectedACES.add(ACESModel(title, subtitle, true));
            } else {
              selectedACES
                  .removeWhere((element) => element.title == aces[index].title);
            }
          });
        },
      ),
    );
  }
}
