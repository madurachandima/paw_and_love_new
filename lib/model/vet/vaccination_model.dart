import 'dart:convert';

VaccinationModel vaccinationModelFromJson(String str) =>
    VaccinationModel.fromJson(json.decode(str));

String welcomeToJson(VaccinationModel data) => json.encode(data.toJson());

class VaccinationModel {
  VaccinationModel({
    this.ageGroup,
  });

  List<Map<String, List<AgeGroup>>>? ageGroup;

  factory VaccinationModel.fromJson(Map<String, dynamic> json) =>
      VaccinationModel(
        ageGroup: List<Map<String, List<AgeGroup>>>.from(json["AgeGroup"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, List<AgeGroup>>(
                k, List<AgeGroup>.from(v.map((x) => AgeGroup.fromJson(x))))))),
      );

  Map<String, dynamic> toJson() => {
        "AgeGroup": List<dynamic>.from(ageGroup!.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))))),
      };
}

class AgeGroup {
  AgeGroup({
    this.recommended,
    this.optional,
  });

  List<String>? recommended;
  List<String>? optional;

  factory AgeGroup.fromJson(Map<String, dynamic> json) => AgeGroup(
        recommended: json["recommended"] == null
            ? null
            : List<String>.from(json["recommended"].map((x) => x)),
        optional: json["optional"] == null
            ? null
            : List<String>.from(json["optional"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "recommended": recommended == null
            ? null
            : List<dynamic>.from(recommended!.map((x) => x)),
        "optional": optional == null
            ? null
            : List<dynamic>.from(optional!.map((x) => x)),
      };
}
