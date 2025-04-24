import 'package:supabase_flutter/supabase_flutter.dart';

class Profiles {
  final String? email;
  final String? passwordHash;
  final Role? role;
  final String? firstName;
  final String? lastName;

  Profiles({
    this.email,
    this.passwordHash,
    this.role,
    this.firstName,
    this.lastName,
  });

  factory Profiles.fromJson(Map<String, dynamic> json) {
    return Profiles(
      email: json['email'],
      passwordHash: json['password_hash'],
      role: RoleExtension.fromString(json['role']),
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password_hash': passwordHash,
      'role': role?.name,
      'first_name': firstName,
      'last_name': lastName,
    };
  }

  static Profiles fromSupabaseUser(User user) {
    if (user.userMetadata == null) {
      throw Exception('User metadata is null');
    }
    return Profiles(
      email: user.email,
      role: Role.LANDLORD,
      firstName: user.userMetadata!['first_name'],
      lastName: user.userMetadata!['last_name'],
    );
  }
}

enum Role { TENANT, LANDLORD }

extension RoleExtension on Role {
  static Role fromString(String value) =>
      Role.values.firstWhere((e) => e.name == value);
}
