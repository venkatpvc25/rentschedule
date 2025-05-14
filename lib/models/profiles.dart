import 'package:rentschedule/models/pending_subscriptions.dart';
import 'package:rentschedule/models/tenancy.dart';
import 'package:rentschedule/services/tenancy_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profiles {
  final String? email;
  final String? passwordHash;
  final Role? role;
  final String? firstName;
  final String? lastName;
  final List<PendingSubscription> pendingSubscription;
  final List<Tenancy> tenancies;
  final String? fcmToken;

  Profiles({
    this.email,
    this.passwordHash,
    this.role,
    this.firstName,
    this.lastName,
    this.pendingSubscription = const [],
    this.tenancies = const [],
    this.fcmToken,
  });

  factory Profiles.fromJson(Map<String, dynamic> json) {
    return Profiles(
      email: json['email'],
      passwordHash: json['password_hash'],
      role: RoleExtension.fromString(json['role']),
      firstName: json['first_name'],
      lastName: json['last_name'],
      pendingSubscription:
          (json['pending_subscriptions'] as List<dynamic>?)
              ?.map((e) => PendingSubscription.fromJson(e))
              .toList() ??
          [],
      tenancies:
          (json['tenancies'] as List<dynamic>?)
              ?.map((e) => Tenancy.fromJson(e))
              .toList() ??
          [],
      fcmToken: json['fcm_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password_hash': passwordHash,
      'role': role?.name,
      'first_name': firstName,
      'last_name': lastName,
      'fcm_token': fcmToken,
    };
  }

  static Profiles fromSupabaseUser(User user) {
    if (user.userMetadata == null) {
      throw Exception('User metadata is null');
    }
    return Profiles(
      email: user.email,
      role:
          user.userMetadata?['role'] != null
              ? RoleExtension.fromString(user.userMetadata!['role'])
              : Role.LANDLORD,
      firstName: user.userMetadata!['first_name'],
      lastName: user.userMetadata!['last_name'],
    );
  }

  Profiles copyWith({
    String? email,
    String? passwordHash,
    Role? role,
    String? firstName,
    String? lastName,
    List<PendingSubscription>? pendingSubscription,
    List<Tenancy>? tenancies,
    String? fcmToken,
  }) {
    return Profiles(
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      role: role ?? this.role,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      pendingSubscription: pendingSubscription ?? this.pendingSubscription,
      tenancies: tenancies ?? this.tenancies,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  updateTenancies(int tenancyId, TenancyAction action) {
    List<Tenancy> updatedTenancies =
        tenancies.map((tenancy) {
          if (tenancy.tenancyId == tenancyId) {
            return tenancy.copyWith(status: action);
          }
          return tenancy;
        }).toList();
    return copyWith(tenancies: updatedTenancies);
  }

  // fullName need to handle incase firstName or lastName is null

  String get fullName {
    final hasFirst = (firstName?.trim().isNotEmpty ?? false);
    final hasLast = (lastName?.trim().isNotEmpty ?? false);

    if (hasFirst && hasLast) {
      return '${firstName!.trim()} ${lastName!.trim()}';
    } else if (hasFirst) {
      return firstName!.trim();
    } else if (hasLast) {
      return lastName!.trim();
    } else {
      return 'Name Not Provided';
    }
  }
}

enum Role { TENANT, LANDLORD }

extension RoleExtension on Role {
  static Role fromString(String value) {
    return Role.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Role.TENANT, // fallback if string mismatch
    );
  }
}
