// To parse this JSON data, do
//
//     final imdResponse = imdResponseFromJson(jsonString);

import 'dart:convert';

ImdResponse imdResponseFromJson(String str) =>
    ImdResponse.fromJson(json.decode(str));

String imdResponseToJson(ImdResponse data) => json.encode(data.toJson());

class ImdResponse {
  ImdResponse({
    required this.ukCompositeImd2020MysocIncomeScore,
    required this.ukCompositeImd2020MysocEExpandedDecile,
    required this.ukCompositeImd2020MysocNation,
    required this.ukCompositeImd2020MysocUkImdEScore,
    required this.ukCompositeImd2020MysocOverallLocalScore,
    required this.ukCompositeImd2020MysocOriginalDecile,
    required this.ukCompositeImd2020MysocUkImdERank,
    required this.ukCompositeImd2020MysocUkImdEPopQuintile,
    required this.ukCompositeImd2020MysocEmploymentScore,
    required this.ukCompositeImd2020MysocUkImdEPopDecile,
    required this.ukGovOnsLsoa,
  });

  double ukCompositeImd2020MysocIncomeScore;
  int ukCompositeImd2020MysocEExpandedDecile;
  String ukCompositeImd2020MysocNation;
  double ukCompositeImd2020MysocUkImdEScore;
  double ukCompositeImd2020MysocOverallLocalScore;
  int ukCompositeImd2020MysocOriginalDecile;
  int ukCompositeImd2020MysocUkImdERank;
  int ukCompositeImd2020MysocUkImdEPopQuintile;
  double ukCompositeImd2020MysocEmploymentScore;
  int ukCompositeImd2020MysocUkImdEPopDecile;
  String ukGovOnsLsoa;

  factory ImdResponse.fromJson(Map<String, dynamic> json) => ImdResponse(
        ukCompositeImd2020MysocIncomeScore:
            json["uk-composite-imd-2020-mysoc/income_score"].toDouble(),
        ukCompositeImd2020MysocEExpandedDecile:
            json["uk-composite-imd-2020-mysoc/E_expanded_decile"],
        ukCompositeImd2020MysocNation:
            json["uk-composite-imd-2020-mysoc/nation"],
        ukCompositeImd2020MysocUkImdEScore:
            json["uk-composite-imd-2020-mysoc/UK_IMD_E_score"].toDouble(),
        ukCompositeImd2020MysocOverallLocalScore:
            json["uk-composite-imd-2020-mysoc/overall_local_score"].toDouble(),
        ukCompositeImd2020MysocOriginalDecile:
            json["uk-composite-imd-2020-mysoc/original_decile"],
        ukCompositeImd2020MysocUkImdERank:
            json["uk-composite-imd-2020-mysoc/UK_IMD_E_rank"],
        ukCompositeImd2020MysocUkImdEPopQuintile:
            json["uk-composite-imd-2020-mysoc/UK_IMD_E_pop_quintile"],
        ukCompositeImd2020MysocEmploymentScore:
            json["uk-composite-imd-2020-mysoc/employment_score"].toDouble(),
        ukCompositeImd2020MysocUkImdEPopDecile:
            json["uk-composite-imd-2020-mysoc/UK_IMD_E_pop_decile"],
        ukGovOnsLsoa: json["uk.gov.ons/lsoa"],
      );

  Map<String, dynamic> toJson() => {
        "uk-composite-imd-2020-mysoc/income_score":
            ukCompositeImd2020MysocIncomeScore,
        "uk-composite-imd-2020-mysoc/E_expanded_decile":
            ukCompositeImd2020MysocEExpandedDecile,
        "uk-composite-imd-2020-mysoc/nation": ukCompositeImd2020MysocNation,
        "uk-composite-imd-2020-mysoc/UK_IMD_E_score":
            ukCompositeImd2020MysocUkImdEScore,
        "uk-composite-imd-2020-mysoc/overall_local_score":
            ukCompositeImd2020MysocOverallLocalScore,
        "uk-composite-imd-2020-mysoc/original_decile":
            ukCompositeImd2020MysocOriginalDecile,
        "uk-composite-imd-2020-mysoc/UK_IMD_E_rank":
            ukCompositeImd2020MysocUkImdERank,
        "uk-composite-imd-2020-mysoc/UK_IMD_E_pop_quintile":
            ukCompositeImd2020MysocUkImdEPopQuintile,
        "uk-composite-imd-2020-mysoc/employment_score":
            ukCompositeImd2020MysocEmploymentScore,
        "uk-composite-imd-2020-mysoc/UK_IMD_E_pop_decile":
            ukCompositeImd2020MysocUkImdEPopDecile,
        "uk.gov.ons/lsoa": ukGovOnsLsoa,
      };
}
