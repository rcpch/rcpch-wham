import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String rcpchCensusEngineBaseUrl = dotenv.env['RCPCH_CENSUS_ENGINE_BASE_URL'] ?? '';
  static String rcpchCensusEngineApiKey = dotenv.env['RCPCH_CENSUS_ENGINE_API_KEY'] ?? '';
  static String rcpchPostcodesBaseUrl = dotenv.env['RCPCH_POSTCODES_BASE_URL'] ?? '';
  static String rcpchPostcodesApiKey = dotenv.env['RCPCH_POSTCODES_API_KEY'] ?? '';

}
