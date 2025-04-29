import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../constants/apiconstants.dart';
import './imdresponse.dart';
import './postcodesResponse.dart';

class ApiService {
  Future<PostcodeData?> getPostcodeResponse(String postcode) async {
    try {
      var url = Uri.parse("${ApiConstants.rcpchPostcodesBaseUrl}/postcodes/$postcode");
      var response = await http.get(
        url,
        headers: {
          'Ocp-Apim-Subscription-Key': '${ApiConstants.rcpchPostcodesApiKey}',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        PostcodeData apiPostcodeData = PostcodeData.fromJson(data['result']);
        log(apiPostcodeData.toString());
        return apiPostcodeData;
      }
    } catch (e) {
      log(e.toString());
      // var codes = Codes(adminDistrict: 'adminDistrict', adminCounty: 'adminCounty', adminWard: 'adminWard', parish: 'parish', parliamentaryConstituency: 'parliamentaryConstituency', ccg: 'ccg', ccgId: 'ccgId', ced: 'ced', nuts: 'nuts', lsoa: 'lsoa', msoa: 'msoa', lau2: 'lau2')
      // var errorPostcode = PostcodeData(postcode: 'error', quality: 0, eastings: 0, northings: 0, country: 'country', nhsHa: 'nhsHa', longitude: 0, latitude: 0, europeanElectoralRegion: 'europeanElectoralRegion', primaryCareTrust: 'primaryCareTrust', region: 'region', lsoa: 'lsoa', msoa: 'msoa', incode: 'incode', outcode: 'outcode', parliamentaryConstituency: 'parliamentaryConstituency', adminDistrict: 'adminDistrict', parish: 'parish', adminCounty: 'adminCounty', adminWard: 'adminWard', ced: 'ced', ccg: 'ccg', nuts: 'nuts', codes: codes);
      // return PostcodesResponse(status: 404, postcodeData: errorPostcode)
    }
  }

  Future<ImdResponse?> getIMDResponse(String postcode) async {
    try {
      var url = Uri.parse("${ApiConstants.rcpchCensusEngineBaseUrl}?postcode=${postcode}");
      var response = await http.get(
        url,
        headers: {
          'Subscription-Key': '${ApiConstants.rcpchCensusEngineApiKey}',
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        ImdResponse apiIMDData = ImdResponse.fromJson(data);
        return apiIMDData;
      }
    } catch (e) {
      log(e.toString());
      // var codes = Codes(adminDistrict: 'adminDistrict', adminCounty: 'adminCounty', adminWard: 'adminWard', parish: 'parish', parliamentaryConstituency: 'parliamentaryConstituency', ccg: 'ccg', ccgId: 'ccgId', ced: 'ced', nuts: 'nuts', lsoa: 'lsoa', msoa: 'msoa', lau2: 'lau2')
      // var errorPostcode = PostcodeData(postcode: 'error', quality: 0, eastings: 0, northings: 0, country: 'country', nhsHa: 'nhsHa', longitude: 0, latitude: 0, europeanElectoralRegion: 'europeanElectoralRegion', primaryCareTrust: 'primaryCareTrust', region: 'region', lsoa: 'lsoa', msoa: 'msoa', incode: 'incode', outcode: 'outcode', parliamentaryConstituency: 'parliamentaryConstituency', adminDistrict: 'adminDistrict', parish: 'parish', adminCounty: 'adminCounty', adminWard: 'adminWard', ced: 'ced', ccg: 'ccg', nuts: 'nuts', codes: codes);
      // return PostcodesResponse(status: 404, postcodeData: errorPostcode)
    }
  }
}
