class DogIllnessModel {
  String name = "";
  String description = "";
  List symptoms = [];
  List treatment = [];
  List action = [];
  String source = "";
  List causes = [];
  List prevent = [];

  DogIllnessModel(
      {required this.name,
      required this.description,
      required this.symptoms,
      required this.treatment,
      required this.action,
      required this.source,
      required this.causes,
      required this.prevent});

  // Map<String, dynamic> toJson() => {
  //       'dog_name': dogName,
  //       'owner_name': dogOwnerName,
  //       'dog_breed': dogBreed,
  //       'dog_profile_url': dogProfileUrl,
  //       'dog_birthdate': birthDate,
  //       'dog_gender': source,
  //       'recomonded_vaccine': returnJsonArray(causes),
  //       'optional_vaccine': returnJsonArray(prevent)
  //     };

  static DogIllnessModel fromSnap(var snap) {
    return DogIllnessModel(
        name: snap['name'],
        description: snap['description'],
        treatment: snap['treatment'],
        symptoms: snap['symptoms'],
        action: snap['action'],
        source: snap['source'],
        causes: snap['causes'],
        prevent: snap['prevent']);
  }
}
