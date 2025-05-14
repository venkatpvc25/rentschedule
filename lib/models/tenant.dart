import 'package:rentschedule/models/profiles.dart';

class Tenant {
  final int? tenantId;
  final int? profileId;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? modifiedAt;
  final List<PendingSubscription>? pendingSubscriptions;
  final Profiles? profile;

  Tenant({
    this.tenantId,
    this.profileId,
    this.phoneNumber,
    this.createdAt,
    this.modifiedAt,
    this.pendingSubscriptions,
    this.profile,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      tenantId: json['tenant_id'] as int?,
      profileId: json['profile_id'] as int?,
      phoneNumber: json['phone_number'] as String?,
      profile:
          json['profiles'] != null ? Profiles.fromJson(json['profiles']) : null,
      // createdAt:
      //     json['created_at'] != null
      //         ? DateTime.parse(json['created_at'])
      //         : null,
      // modifiedAt:
      //     json['modified_at'] != null
      //         ? DateTime.parse(json['modified_at'])
      //         : null,
      pendingSubscriptions:
          json['pending_subscriptions'] != null
              ? (json['pending_subscriptions'] as List)
                  .map((e) => PendingSubscription.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenant_id': tenantId,
      'profile_id': profileId,
      'phone_number': phoneNumber,
      'created_at': createdAt?.toIso8601String(),
      'modified_at': modifiedAt?.toIso8601String(),
      'pending_subscriptions':
          pendingSubscriptions?.map((e) => e.toJson()).toList(),
    };
  }
}

class PendingSubscription {
  final String? subscriptionId;
  final int? tenantId;
  final String? shortUrl;
  final DateTime? createdAt;
  final DateTime? modifiedAt;

  PendingSubscription({
    this.subscriptionId,
    this.tenantId,
    this.shortUrl,
    this.createdAt,
    this.modifiedAt,
  });

  factory PendingSubscription.fromJson(Map<String, dynamic> json) {
    return PendingSubscription(
      subscriptionId: json['subscription_id'] as String?,
      tenantId: json['tenant_id'] as int?,
      shortUrl: json['short_url'] as String?,
      // createdAt:
      //     json['created_at'] != null
      //         ? DateTime.parse(json['created_at'])
      //         : null,
      // modifiedAt:
      //     json['modified_at'] != null
      //         ? DateTime.parse(json['modified_at'])
      //         : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subscription_id': subscriptionId,
      'tenant_id': tenantId,
      'short_url': shortUrl,
      'created_at': createdAt?.toIso8601String(),
      'modified_at': modifiedAt?.toIso8601String(),
    };
  }
}
