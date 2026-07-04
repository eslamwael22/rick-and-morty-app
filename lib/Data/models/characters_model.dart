class CharactersModel {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  String image;
  final Origin origin;

  CharactersModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.origin,
  });
  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    return CharactersModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      origin: Origin.fromJson(json['origin']),
    );
  }
}

class Origin {
  String name;
  String url;

  Origin({required this.name, required this.url});
  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(name: json['name'], url: json['url']);
  }
}
