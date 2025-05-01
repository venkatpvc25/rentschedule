class Tenancy {
  final int? tenancyId;
  final int? landlordId;
  final int? tenantId;
  final String? propertyAddress;
  final double? rentAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final DateTime? createdAt;
  final DateTime? modifiedAt;

  Tenancy({
    this.tenancyId,
    this.landlordId,
    this.tenantId,
    this.propertyAddress,
    this.rentAmount,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
    this.modifiedAt,
  });

  factory Tenancy.fromJson(Map<String, dynamic> json) {
    return Tenancy(
      tenancyId: json['tenancy_id'] as int?,
      landlordId: json['landlord_id'] as int?,
      tenantId: json['tenant_id'] as int?,
      propertyAddress: json['property_address'] as String?,
      rentAmount: (json['rent_amount'] as num?)?.toDouble(),
      startDate:
          json['start_date'] != null
              ? DateTime.parse(json['start_date'])
              : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      status: json['status'] as String?,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      modifiedAt:
          json['modified_at'] != null
              ? DateTime.parse(json['modified_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenancy_id': tenancyId,
      'landlord_id': landlordId,
      'tenant_id': tenantId,
      'property_address': propertyAddress,
      'rent_amount': rentAmount,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'modified_at': modifiedAt?.toIso8601String(),
    };
  }
}
