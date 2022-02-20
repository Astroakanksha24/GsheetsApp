import 'dart:convert';

class Userfield {
  static final String ID = 'Student ID';
  static final String Name = 'Student Name';
  static final String Marks = 'Marks';
  static final String Status = 'Status';

  static List<String> getField() => [ID, Name, Marks, Status];
}

class User {
  final String? ID;
  final String? Name;
  final int? Marks;
  // final String? Status;

  const User({
    this.ID,
    required this.Name,
    required this.Marks,
    // required this.Status,
  });

  User copy({
    String? ID,
    String? Name,
    int? Marks,
    // String? Status,
  }) =>
      User(
        ID: ID ?? this.ID,
        Name: Name ?? this.Name,
        Marks: Marks ?? this.Marks,
        // Status: Status ?? this.Status,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        ID: jsonDecode(json[Userfield.ID]),
        Name: json[Userfield.Name],
        Marks: jsonDecode(json[Userfield.Marks]),
        // Status: json[Userfield.Status],
      );
  Map<String, dynamic> toJson() => {
        Userfield.ID: ID,
        Userfield.Name: Name,
        Userfield.Marks: Marks,
        // Userfield.Status: Status,
      };
}
