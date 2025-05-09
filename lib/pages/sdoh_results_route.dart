import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Services
import '../network/imdresponse.dart';
import '../network/postcodesResponse.dart';

// widgets
import '../classes/imd_info_class.dart';

// Theming
import '../themes/colours.dart';

class SDOHResultsRoute extends StatelessWidget {
  SDOHResultsRoute({
    Key? key,
    required this.postcodeData,
    required this.imdData,
  }) : super(key: key);

  final PostcodeData postcodeData;
  final ImdResponse imdData;

  final List<ImdSubscoreInfo> imdSubscores = [
    ImdSubscoreInfo(
      icon: Icons.money_outlined,
      title: 'Income Deprivation',
      dataKey: 'income_decile', // <-- Changed to snake_case
      detailTitle: 'Income Deprivation Explained',
      detailText: 'Income Deprivation measures the proportion of people experiencing deprivation relating to low income...',
    ),
    ImdSubscoreInfo(
      icon: Icons.work_outline,
      title: 'Employment Deprivation',
      dataKey: 'employment_decile', // <-- Changed to snake_case
      detailTitle: 'Employment Deprivation Explained',
      detailText: 'Employment Deprivation measures the proportion of working-age people who are unemployed or not in education, employment, or training...',
    ),
    ImdSubscoreInfo(
      icon: Icons.school_outlined,
      title: 'Education, Skills and Training Deprivation',
      dataKey: 'education_skills_training_decile', // <-- Changed to snake_case
      detailTitle: 'Education, Skills and Training Deprivation Explained',
      detailText: 'Education, Skills and Training Deprivation measures the lack of attainment and skills in the local population...',
    ),
    ImdSubscoreInfo(
      icon: Icons.child_friendly_outlined,
      title: 'Children and Young People Sub-domain',
      dataKey: 'children_young_people_sub_domain_decile', // <-- Changed to snake_case
      detailTitle: 'Children and Young People Sub-domain Explained',
      detailText: 'This sub-domain measures deprivation affecting children and young people, including aspects like educational access and early years development...',
    ),
    ImdSubscoreInfo(
      icon: Icons.wheelchair_pickup_outlined,
      title: 'Health Deprivation and Disability',
      dataKey: 'health_deprivation_disability_decile', // <-- Changed to snake_case
      detailTitle: 'Health Deprivation and Disability Explained',
      detailText: 'Health Deprivation and Disability measures premature death and the impairment of quality of life through poor health...',
    ),
    ImdSubscoreInfo(
      icon: Icons.local_police_outlined,
      title: 'Crime Deprivation',
      dataKey: 'crime_decile', // <-- Changed to snake_case
      detailTitle: 'Crime Deprivation Explained',
      detailText: 'Crime Deprivation measures the risk of personal and material victimisation...',
    ),
    ImdSubscoreInfo(
      icon: Icons.house_outlined,
      title: 'Barriers to Housing and Services',
      dataKey: 'barriers_to_housing_services_decile', // <-- Changed to snake_case
      detailTitle: 'Barriers to Housing and Services Explained',
      detailText: 'Barriers to Housing and Services measures the physical and affordability barriers to housing, and access to services such as post offices and supermarkets...',
    ),
    ImdSubscoreInfo(
      icon: Icons.streetview,
      title: 'Living Environment Deprivation',
      dataKey: 'living_environment_decile', // <-- Changed to snake_case
      detailTitle: 'Living Environment Deprivation Explained',
      detailText: 'Living Environment Deprivation measures the quality of the local environment, including aspects like housing in poor condition and air pollution...',
    ),
    ImdSubscoreInfo(
      icon: Icons.baby_changing_station,
      title: 'Income Deprivation Affecting Children Index (IDACI)',
      dataKey: 'idaci_decile', // <-- Changed to snake_case
      detailTitle: 'Income Deprivation Affecting Children Index (IDACI) Explained',
      detailText: 'IDACI is a sub-domain of the Income Deprivation Domain, measuring the proportion of children aged 0-15 living in income-deprived households...',
    ),
  ];

  dynamic _getImdDataValue(ImdResponse imdData, String key) {
    try {
      // This assumes your ImdResponse has a toJson method that returns a Map
      final mapData = imdData.toJson();
      return mapData[key];
    } catch (e) {
      // Handle cases where the key doesn't exist or toJson is not available
      print('Error accessing IMD data for key $key: $e');
      return null; // Return null if the key is not found or an error occurs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Summary'),
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
                  const Icon(Icons.location_city_outlined, color: primaryColourLight),
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
            Card( // This Card will contain the list of subscores
                clipBehavior: Clip.antiAlias,
                shape: const ContinuousRectangleBorder(
                    borderRadius:
                    BorderRadiusDirectional.vertical()
                ),
                color: primaryColourDark,
                child: Column(children: [
                  const ListTile(
                    leading: Icon(Icons.numbers, color: primaryColourLight),
                    textColor: primaryColourLight,
                    title: Text(
                      'Subscores',
                      textAlign: TextAlign.left,
                      textScaler: TextScaler.linear(1.5),
                      style: TextStyle(
                          color: primaryColourLight, fontFamily: 'Montserrat'),
                    ),
                    subtitle: Text(
                      'Index of multiple deprivation deciles',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: primaryColourLight, fontFamily: 'Montserrat'),
                    ),

                  ),
                  // Loop through the imdSubscores list to create ListTiles
                  ...imdSubscores.map((subscoreInfo) {
                    final dynamic dataValue = _getImdDataValue(imdData, subscoreInfo.dataKey);

                    return ListTile(
                      leading: Icon(subscoreInfo.icon, color: primaryColourDark),
                      textColor: primaryColourDark,
                      tileColor: primaryColourLight,
                      title: Text(
                        '${subscoreInfo.title}:  ${dataValue ?? "N/A"}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      onTap: () {
                        // Show the modal bottom sheet when the ListTile is tapped
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: primaryColourLight,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          // isScrollControlled: true, // Optional: makes the bottom sheet fill more of the screen
                          builder: (BuildContext context) {
                            return ImdSubscoreDetail(
                              title: subscoreInfo.detailTitle,
                              detailText: subscoreInfo.detailText,
                            );
                          },
                        );
                      },
                    );
                  }).toList(), // Convert the map result back to a List of Widgets
                  const ListTile(
                    leading: Icon(Icons.bookmark, color: secondaryColour),
                    textColor: secondaryColour,
                    tileColor: secondaryColourLight,
                    title: Text(
                      "Source: English indices of deprivation 2019, Ministry of Housing, Communities & Local Government",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ])
            ),
          ],
        ),
      ),
    );
  }
}