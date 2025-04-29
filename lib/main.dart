// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

// Pages
import './pages/aces.dart';

// Services
import './network/api_service.dart';
import './network/imdresponse.dart';
import './network/postcodesResponse.dart';

// Theming
import './themes/colours.dart';


void main() async {
  await dotenv.load();
  runApp(const RCPCHLivingLensApp());
}

class RCPCHLivingLensApp extends StatelessWidget {
  const RCPCHLivingLensApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LivingLens',
      theme: LivingLensTheme.defaultTheme,
      home: const SDOHRoute(title: 'Describing the environments in which children grow'),
    );
  }
}

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

  void getIMDData(String postcode) async {
    imdData = (await ApiService().getIMDResponse(postcode));
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
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: primaryColour),
                child: Text('Menu'),
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
                            color: primaryColourDark,
                            child: Column(children: [
                              ListTile(
                                leading:
                                    const Icon(Icons.location_city_outlined),
                                textColor: primaryColourLight,
                                title: Text(
                                  postcodeData!.postcode,
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.5,
                                  style: const TextStyle(
                                      color: primaryColourLight,
                                      fontFamily: 'Montserrat'),
                                ),
                                subtitle: Text(
                                  postcodeData!.region,
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.0,
                                  style: const TextStyle(
                                      color: primaryColourLight,
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
                                        color: primaryColourLight,
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
                                        color: primaryColourLight,
                                        fontFamily: 'Montserrat'),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Ranking : ${imdData!.imdRank}',
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: primaryColourLight,
                                        fontFamily: 'Montserrat'),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Score : ${imdData!.imdScore} [higher numbers are more deprived]',
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: primaryColourLight,
                                        fontFamily: 'Montserrat'),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'IMD Decile: ${imdData!.imdDecile} [lower numbers are more deprived]',
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: primaryColourLight,
                                        fontFamily: 'Montserrat'),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Income Score: ${imdData!.incomeScore}',
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: primaryColourLight,
                                        fontFamily: 'Montserrat'),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Employment Score: ${imdData!.employmentScore}',
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: primaryColourLight,
                                        fontFamily: 'Montserrat'),
                                  )),
                              const ListTile(
                                leading: Icon(Icons.bookmark),
                                textColor: primaryColourLight,
                                tileColor: primaryColourLight,
                                title: Text(
                                  'Parsons, Alex (2021), UK 2020 Composite Index of Multiple Deprivation, https://github.com/mysociety/composite_uk_imd',
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
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
                          const Center(
                            child: Text(
                              'LivingLens',
                              style: TextStyle(
                                  fontFamily: 'Montserrat-Regular',
                                  fontSize: 40,
                                  color: textColor),
                            ),
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.all(30),
                          //   child: Image(
                          //     image: AssetImage('assets/incubator-white.png'),
                          //     fit: BoxFit.fitWidth,
                          //     width: 300,
                          //   ),
                          // ),
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
                                          color: textColor,
                                          fontSize: 30,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                        hintText: "e.g. W1A 1AA",
                                        hintStyle: TextStyle(
                                            color: textColor,
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
                                          color: textColor,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  primaryColour),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  side: BorderSide(
                                                      color: primaryColour)))),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Processing Data')),
                                          );
                                          _formKey.currentState!.save();
                                          getPostcodeData(
                                                  postcodeController.text)
                                              .then((value) {
                                            if (value != null &&
                                                value.codes != null) {
                                              getIMDData(
                                                  postcodeController.text);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Invalid postcode or no data found')),
                                              );
                                            }
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
