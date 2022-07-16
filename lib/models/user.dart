class User{
  String id;
  final String name;
  final int age;
  final String description;

    User({
      this.id = "",
      required this.name,
      required this.age,
      required this.description,
    });

    Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "age": age,
      "description": description,
    };

    static User fromJson(Map<String, dynamic>json) => User (
      id: json ['id'],
      name: json['name'],
      age: json['age'],
      description: json['description'],
    );
}

