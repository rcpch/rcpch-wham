import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rcpch_wham/network/api_service.dart';
import 'package:rcpch_wham/network/imdresponse.dart';
import 'package:rcpch_wham/network/postcodesResponse.dart';
import '../themes/colours.dart';

class SDOHRoute extends StatefulWidget {
  const SDOHRoute({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SDOHRoute> createState() => _SDOHRouteState();
}

class _SDOHRouteState extends State<SDOHRoute> {
  late PostcodeData? postcodeData;
  late ImdResponse? imdData;
  late bool postcodeValid = false;
  final _formKey = GlobalKey<FormState>();

  final postcodeController = TextEditingController();

  Future getPostcodeData(String postcode) async {
    postcodeData = (await ApiService().getPostcodeResponse(postcode));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    return postcodeData;
  }

  void getIMDData(String lsoa) async {
    imdData = (await ApiService().getIMDResponse(lsoa));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  isPostcodeValid() async {
    postcodeValid = (await ApiService().isValidPostcode('SE231DU'));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Determinants of Health'),
      ),
      body: Column(
        children: [
          Center(
              child: FutureBuilder(
                  future:
                      ApiService().getPostcodeResponse(postcodeController.text),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: const ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.vertical()),
                            color: PrimaryColourDark,
                            child: Column(children: [
                              ListTile(
                                leading:
                                    const Icon(Icons.location_city_outlined),
                                textColor: PrimaryColourLight,
                                title: Text(
                                  postcodeData!.postcode,
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.5,
                                  style: const TextStyle(
                                      color: PrimaryColourLight,
                                      fontFamily: 'Montserrat'),
                                ),
                                subtitle: Text(
                                  postcodeData!.region,
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.0,
                                  style: const TextStyle(
                                      color: PrimaryColourLight,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'CCG: ${postcodeData!.ccg}',
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: PrimaryColourLight,
                                        fontFamily: 'Montserrat'),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Primary care trust: ${postcodeData!.primaryCareTrust}',
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: PrimaryColourLight,
                                        fontFamily: 'Montserrat'),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Ranking : ${imdData!.ukCompositeImd2020MysocUkImdERank} [lower numbers are more deprived]',
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: PrimaryColourLight,
                                        fontFamily: 'Montserrat'),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Score : ${imdData!.ukCompositeImd2020MysocUkImdEScore} [higher numbers are more deprived]',
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: PrimaryColourLight,
                                        fontFamily: 'Montserrat'),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Expanded Decile: ${imdData!.ukCompositeImd2020MysocEExpandedDecile} [lower numbers are more deprived]',
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: PrimaryColourLight,
                                        fontFamily: 'Montserrat'),
                                  )),
                            ]),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Please enter a postcode',
                                      style: TextStyle(
                                          color: TextColor,
                                          fontSize: 30,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                        hintText: "e.g. W1A 1AA",
                                        hintStyle: TextStyle(
                                            color: TextColor,
                                            fontFamily: 'Montserrat'),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.zero),
                                      ),
                                      controller: postcodeController,
                                      onSaved: (newValue) {
                                        if (newValue == null) {
                                          print('No dice ');
                                        } else {
                                          print('saved!');
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(
                                          color: TextColor,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  PrimaryColourDark),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  side: BorderSide(
                                                      color:
                                                          PrimaryColourDark)))),
                                      onPressed: () {
                                        // Validate returns true if the form is valid, or false otherwise.
                                        if (_formKey.currentState!.validate()) {
                                          // If the form is valid, display a snackbar. In the real world,
                                          // you'd often call a server or save the information in a database.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Processing Data')),
                                          );
                                          _formKey.currentState!.save();
                                          getPostcodeData(
                                                  postcodeController.text)
                                              .then((value) => {
                                                    getIMDData(
                                                        value.codes.lsoa),
                                                  });
                                        }
                                      },
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                ),
                              ))
                        ]);
                  }))),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(30),
            child: Image(
              image: AssetImage('assets/whamlogo.png'),
              fit: BoxFit.fitWidth,
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}
