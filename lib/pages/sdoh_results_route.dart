import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Services
import '../network/imdresponse.dart';
import '../network/postcodesResponse.dart';

// Theming
import '../themes/colours.dart';

class SDOHResultsRoute extends StatelessWidget {
  const SDOHResultsRoute({
    Key? key,
    required this.postcodeData,
    required this.imdData,
  }) : super(key: key);

  final PostcodeData postcodeData;
  final ImdResponse imdData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Postcode Data'),
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView to prevent overflow
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              shape: const ContinuousRectangleBorder(
                  borderRadius:
                  BorderRadiusDirectional.vertical()),
              color: secondaryColour,
              child: Column(children: [
                ListTile(
                  leading:
                  const Icon(Icons.location_city_outlined),
                  textColor: primaryColourLight,
                  title: Text(
                    postcodeData.postcode ?? "N/A",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: primaryColourLight,
                        fontFamily: 'Montserrat'),
                  ),
                  subtitle: Text(
                    postcodeData.region ?? "N/A",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: primaryColourLight,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'CCG: ${postcodeData.adminDistrict ?? "N/A"}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: primaryColourLight,
                          fontFamily: 'Montserrat'),
                    )),
                Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'IMD Decile: ${imdData.imdDecile ?? "N/A"}',
                      textAlign: TextAlign.left,
                      textScaler: const TextScaler.linear(1.5),
                      style: const TextStyle(
                          color: primaryColourLight,
                          fontFamily: 'Montserrat'),
                    )),
                Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '[Lower numbers are more deprived]',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: primaryColourLight,
                          fontFamily: 'Montserrat'),
                    )
                ),
              ]),
            ),
            Card(
                clipBehavior: Clip.antiAlias,
                shape: const ContinuousRectangleBorder(
                    borderRadius:
                    BorderRadiusDirectional.vertical()
                ),
                color: primaryColourDark,
                child: Column(children: [
                  const ListTile(
                    leading:
                    Icon(Icons.money_outlined),
                    textColor: primaryColourLight,
                    title: Text(
                      'Subscores',
                      textAlign: TextAlign.left,
                      textScaler: const TextScaler.linear(1.5),
                      style: TextStyle(
                          color: primaryColourLight,
                          fontFamily: 'Montserrat'),
                    ),
                    subtitle: Text(
                      'Index of multiple deprivation deciles',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: primaryColourLight,
                          fontFamily: 'Montserrat'),
                    ),

                  ),
                  ListTile(
                    leading: const Icon(Icons.money_outlined),
                    textColor: primaryColourDark,
                    tileColor: primaryColourLight,
                    title: Text(
                      'Income Decile:  ${imdData.incomeDecile ?? "N/A"}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.work_outline),
                    textColor: primaryColourDark,
                    tileColor: primaryColourLight,
                    title: Text(
                      'Employment Decile:  ${imdData.employmentDecile ?? "N/A"}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.bookmark),
                    textColor: primaryColourDark,
                    tileColor: secondaryColourLight,
                    title: Text(
                      'Parsons, Alex (2021), UK 2020 Composite Index of Multiple Deprivation, https://github.com/mysociety/composite_uk_imd',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ])
            )
          ],
        ),
      ),
    );
  }
}