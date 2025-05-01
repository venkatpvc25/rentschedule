class PendingSubscription {
  final String? subscriptionId;
  final int? tenantId;
  final DateTime? createdAt;
  final String? shortUrl;
  //final Tenant? tenant;

  PendingSubscription({
    this.subscriptionId,
    this.tenantId,
    this.createdAt,
    this.shortUrl,
    //this.tenant,
  });

  factory PendingSubscription.fromJson(Map<String, dynamic> json) {
    return PendingSubscription(
      subscriptionId: json['subscription_id'] as String?,
      tenantId: json['tenant_id'] as int?,
      // createdAt:
      //     json['created_at'] != null
      //         ? DateTime.parse(json['created_at'])
      //         : null,
      shortUrl: json['short_url'] as String?,
      //tenant: json['tenant'] != null ? Tenant.fromJson(json['tenant']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subscription_id': subscriptionId,
      'tenant_id': tenantId,
      'created_at': createdAt?.toIso8601String(),
      //'tenant': tenant?.toJson(),
    };
  }
}
