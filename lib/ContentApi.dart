class ContentApi {
  String position;
  String? tags;
  String location;
  String? logo;
  String? description;
  String date;

  ContentApi({
    required this.position,
    required this.tags,
    required this.logo,
    required this.description,
    required this.date,
    required this.location,
  });

  factory ContentApi.fromJson(Map<String, dynamic> json) => ContentApi(
        position: json["position"],
        tags: json["tags"].join(", "),
        logo: json["logo"],
        description: json["description"],
        date: json["date"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "tags": tags,
        "logo": logo,
        "description": description,
        "date": date,
        "location": location,
      };
}
