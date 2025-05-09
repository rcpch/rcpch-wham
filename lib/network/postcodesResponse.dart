// To parse this JSON data, do
//
//     final postcodesResponse = postcodesResponseFromJson(jsonString);

import 'dart:convert';

PostcodesResponse postcodesResponseFromJson(String str) =>
    PostcodesResponse.fromJson(json.decode(str));

String postcodesResponseToJson(PostcodesResponse data) =>
    json.encode(data.toJson());

class PostcodesResponse {
  PostcodesResponse({
    required this.status,
    required this.postcodeData,
  });

  int status;
  PostcodeData postcodeData;

  factory PostcodesResponse.fromJson(Map<String, dynamic> json) =>
      PostcodesResponse(
        status: json["status"],
        postcodeData: PostcodeData.fromJson(json["postcodeData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": postcodeData.toJson(),
      };
}

class PostcodeData {
  PostcodeData({
    required this.postcode,
    required this.quality,
    required this.eastings,
    required this.northings,
    required this.country,
    required this.nhsHa,
    required this.longitude,
    required this.latitude,
    required this.europeanElectoralRegion,
    required this.primaryCareTrust,
    required this.region,
    required this.lsoa,
    required this.msoa,
    required this.incode,
    required this.outcode,
    required this.parliamentaryConstituency,
    required this.adminDistrict,
    required this.parish,
    required this.adminCounty,
    required this.adminWard,
    required this.ced,
    required this.ccg,
    required this.nuts,
    required this.codes,
  });

  String? postcode;
  int quality;
  int eastings;
  int northings;
  String country;
  String nhsHa;
  double longitude;
  double latitude;
  String europeanElectoralRegion;
  String primaryCareTrust;
  String? region;
  String lsoa;
  String msoa;
  String incode;
  String outcode;
  String parliamentaryConstituency;
  String? adminDistrict;
  String parish;
  dynamic adminCounty;
  String adminWard;
  dynamic ced;
  String ccg;
  String nuts;
  Codes codes;

  factory PostcodeData.fromJson(Map<String, dynamic> json) => PostcodeData(
        postcode: json["postcode"],
        quality: json["quality"],
        eastings: json["eastings"],
        northings: json["northings"],
        country: json["country"],
        nhsHa: json["nhs_ha"],
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        europeanElectoralRegion: json["european_electoral_region"],
        primaryCareTrust: json["primary_care_trust"],
        region: json["region"],
        lsoa: json["lsoa"],
        msoa: json["msoa"],
        incode: json["incode"],
        outcode: json["outcode"],
        parliamentaryConstituency: json["parliamentary_constituency"],
        adminDistrict: json["admin_district"],
        parish: json["parish"],
        adminCounty: json["admin_county"],
        adminWard: json["admin_ward"],
        ced: json["ced"],
        ccg: json["ccg"],
        nuts: json["nuts"],
        codes: Codes.fromJson(json["codes"]),
      );

  Map<String, dynamic> toJson() => {
        "postcode": postcode,
        "quality": quality,
        "eastings": eastings,
        "northings": northings,
        "country": country,
        "nhs_ha": nhsHa,
        "longitude": longitude,
        "latitude": latitude,
        "european_electoral_region": europeanElectoralRegion,
        "primary_care_trust": primaryCareTrust,
        "region": region,
        "lsoa": lsoa,
        "msoa": msoa,
        "incode": incode,
        "outcode": outcode,
        "parliamentary_constituency": parliamentaryConstituency,
        "admin_district": adminDistrict,
        "parish": parish,
        "admin_county": adminCounty,
        "admin_ward": adminWard,
        "ced": ced,
        "ccg": ccg,
        "nuts": nuts,
        "codes": codes.toJson(),
      };
}

class Codes {
  Codes({
    required this.adminDistrict,
    required this.adminCounty,
    required this.adminWard,
    required this.parish,
    required this.parliamentaryConstituency,
    required this.ccg,
    required this.ccgId,
    required this.ced,
    required this.nuts,
    required this.lsoa,
    required this.msoa,
    required this.lau2,
  });

  String adminDistrict;
  String adminCounty;
  String adminWard;
  String parish;
  String parliamentaryConstituency;
  String ccg;
  String ccgId;
  String ced;
  String nuts;
  String lsoa;
  String msoa;
  String lau2;

  factory Codes.fromJson(Map<String, dynamic> json) => Codes(
        adminDistrict: json["admin_district"],
        adminCounty: json["admin_county"],
        adminWard: json["admin_ward"],
        parish: json["parish"],
        parliamentaryConstituency: json["parliamentary_constituency"],
        ccg: json["ccg"],
        ccgId: json["ccg_id"],
        ced: json["ced"],
        nuts: json["nuts"],
        lsoa: json["lsoa"],
        msoa: json["msoa"],
        lau2: json["lau2"],
      );

  Map<String, dynamic> toJson() => {
        "admin_district": adminDistrict,
        "admin_county": adminCounty,
        "admin_ward": adminWard,
        "parish": parish,
        "parliamentary_constituency": parliamentaryConstituency,
        "ccg": ccg,
        "ccg_id": ccgId,
        "ced": ced,
        "nuts": nuts,
        "lsoa": lsoa,
        "msoa": msoa,
        "lau2": lau2,
      };
}
