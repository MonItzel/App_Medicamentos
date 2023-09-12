class User{
  final int? id;
  final String name;
  final String middlename;
  final String? surname;
  final DateTime? birthdate;
  final String phone;
  final String club;
  final bool? activeCaregiver;
  final String? nameCaregiver;
  final String? phoneCaregiver;

  User({
    this.id,
    required this.name,
    required this.middlename,
    this.surname,
    this.birthdate,
    required this.phone,
    required this.club,
    this.activeCaregiver,
    this.nameCaregiver,
    this.phoneCaregiver
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'middlename': middlename,
      'surname': surname,
      'phone': phone,
      'birthdate': birthdate,
      'club': club,
      'active_caregiver': activeCaregiver,
      'name_caregiver': nameCaregiver,
      'caregiver_phone': phoneCaregiver
    };
  }
}