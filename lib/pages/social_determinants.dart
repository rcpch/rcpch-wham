import 'package:flutter/material.dart';
import 'package:rcpch_wham/network/api_service.dart';
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
  late bool postcodeValid = false;
  final _formKey = GlobalKey<FormState>();

  final postcodeController = TextEditingController();
  // bool _formattedPostcode(String postcode) {
  //   RegExp regExp =
  //       RegExp(r'^([A-Z][A-HJ-Y]?\d[A-Z\d]? ?\d[A-Z]{2}|GIR ?0A{2})$');
  //   var pureString = postcode.replaceAll(' ', '');
  //   var format = regExp.hasMatch(pureString);

  //   if (format) {
  //     final match = regExp.firstMatch(pureString.toUpperCase());
  //     // return "${match?.group(1)?.padLeft(2, '0')} ${match?.group(2)?.padLeft(2, '0')}";
  //     return true;
  //   } else {
  //     // return postcode;
  //     return false;
  //   }
  // }

  void getPostcodeData(String postcode) async {
    postcodeData = (await ApiService().getPostcodeResponse(postcode));
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
      body: FutureBuilder(
          future: ApiService().getPostcodeResponse(postcodeController.text),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadiusDirectional.vertical()),
                color: PrimaryColour,
                child: Column(children: [
                  ListTile(
                    leading: const Icon(Icons.location_city_outlined),
                    textColor: PrimaryColourLight,
                    title: Text(
                      postcodeData!.postcode,
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.5,
                      style: const TextStyle(color: PrimaryColourLight),
                    ),
                    subtitle: Text(
                      postcodeData!.region,
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.0,
                      style: const TextStyle(color: PrimaryColourLight),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'CCG: ${postcodeData!.ccg}',
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.0,
                        style: const TextStyle(color: PrimaryColourLight),
                      )),
                  Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Primary care trust: ${postcodeData!.primaryCareTrust}',
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.0,
                        style: const TextStyle(color: PrimaryColourLight),
                      )),
                ]),
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
                              style: TextStyle(color: TextColor),
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                hintText: "Postcode",
                              ),
                              controller: postcodeController,
                              onSaved: (newValue) {
                                if (newValue == null) {
                                  print('No dice ');
                                } else {
                                  print('saved!');
                                  getPostcodeData(newValue);
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              style: const TextStyle(color: TextColor),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                  _formKey.currentState!.save();
                                  getPostcodeData(postcodeController.text);
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ))
                ]);
          })),
    );
  }
}