// Flutter
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// RCPCH Imports
import './imdresponse.dart';
import './postcodesResponse.dart';


// API Constants
String rcpchCensusEngineApiKey = dotenv.env['RCPCH_CENSUS_ENGINE_API_KEY']!;
String rcpchCensusEngineBaseUrl = dotenv.env['RCPCH_CENSUS_ENGINE_BASE_URL']!;
String rcpchPostcodesApiKey = dotenv.env['RCPCH_POSTCODES_API_KEY']!;
String rcpchPostcodesBaseUrl = dotenv.env['RCPCH_POSTCODES_BASE_URL']!;


class ApiService {
  Future<PostcodeData?> getPostcodeResponse(String postcode) async {
    try {
      var url = Uri.parse("$rcpchPostcodesBaseUrl/postcodes/$postcode");
      var response = await http.get(
        url,
        headers: {
          'Ocp-Apim-Subscription-Key': rcpchPostcodesApiKey,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        PostcodeData apiPostcodeData = PostcodeData.fromJson(data['result']);
        return apiPostcodeData;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<ImdResponse?> getIMDResponse(String postcode) async {
    try {
      var url = Uri.parse("$rcpchCensusEngineBaseUrl?postcode=$postcode");
      var response = await http.get(
        url,
        headers: {
          'Subscription-Key': rcpchCensusEngineApiKey,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        ImdResponse apiIMDData = ImdResponse.fromJson(data);
        return apiIMDData;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
