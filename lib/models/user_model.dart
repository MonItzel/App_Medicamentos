class User{
  final int? id;
  final String name;
  final String middlename;
  final String? surname;

  User({
    this.id,
    required this.name,
    required this.middlename,
    this.surname
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'middlename': middlename,
      'surname': surname
    };
  }
}