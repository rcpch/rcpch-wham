// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

// Pages
import './pages/aces.dart';
import './pages/sdoh_results_route.dart';

// Services
import './network/api_service.dart';
import './network/imdresponse.dart';
import './network/postcodesResponse.dart';

// Theming
import './themes/colours.dart';

class CombinedData {
  final PostcodeData postcodeData;
  final ImdResponse imdData;

  CombinedData({
    required this.postcodeData,
    required this.imdData,
  });
}

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

  final String title;

  @override
  State<SDOHRoute> createState() => _SDOHRouteState();
}

class _SDOHRouteState extends State<SDOHRoute> {
  final _formKey = GlobalKey<FormState>();
  final postcodeController = TextEditingController();
  bool _isLoading = false; // Add a loading state variable

  // No need for _combinedDataFuture here anymore

  // fetchData function remains the same as the version that returns Future<CombinedData>
  Future<CombinedData> fetchData(String postcode) async {
    // Perform both API calls concurrently
    final postcodeFuture = ApiService().getPostcodeResponse(postcode);
    final imdFuture = ApiService().getIMDResponse(postcode);

    // Wait for both futures to complete
    final responses = await Future.wait([postcodeFuture, imdFuture]);

    // Assuming getPostcodeResponse and getIMDResponse return non-nullable types
    // If they can return null, you need to handle that here.
    // For example:
    final postcodeData = responses[0];
    final imdData = responses[1];

    if (postcodeData == null || imdData == null) {
      // Handle the case where data is missing from either call
      // Throw an exception or return a special error object
      throw Exception('Could not load data for this postcode.');
    }

    return CombinedData(
      postcodeData: postcodeData as PostcodeData,
      imdData: imdData as ImdResponse,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    postcodeController.dispose();
    super.dispose();
  }

  void _submitPostcode() async { // Make the function async
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Set loading to true
      });

      try {
        final combinedData = await fetchData(postcodeController.text);

        // If data is fetched successfully, navigate to the results screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SDOHResultsRoute(
              postcodeData: combinedData.postcodeData,
              imdData: combinedData.imdData,
            ),
          ),
        );
      } catch (e) {
        // Handle errors (e.g., show a SnackBar or AlertDialog)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load data: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false; // Set loading back to false
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) { // The missing build method
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
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Please enter a postcode',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 30,
                        fontFamily: 'Montserrat'),
                  ),
                  TextFormField(
                    controller: postcodeController,
                    decoration: const InputDecoration(labelText: 'Postcode'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a postcode';
                      }
                      // Add more specific postcode validation if needed
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitPostcode, // Disable button when loading
                      child: _isLoading
                          ? const CircularProgressIndicator( // Show loading indicator in button
                        color: Colors.white, // Adjust color as needed
                      )
                          : const Text('Get Data'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // The space where the FutureBuilder used to be is now empty or can
          // contain other widgets that are not dependent on the fetched data.

          const Spacer(), // This will push the logo to the bottom

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
