import 'package:rentschedule/models/tenant.dart';
import 'package:rentschedule/services/tenancy_service.dart';

class Tenancy {
  final int? tenancyId;
  final int? landlordId;
  final int? tenantId;
  final String? propertyAddress;
  final double? rentAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final TenancyAction? status;
  final DateTime? createdAt;
  final DateTime? modifiedAt;
  final Tenant? tenant;

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
    this.tenant,
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
      status:
          json['status'] != null
              ? TenancyAction.fromString(json['status'])
              : null,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      modifiedAt:
          json['modified_at'] != null
              ? DateTime.parse(json['modified_at'])
              : null,
      tenant: json['tenants'] != null ? Tenant.fromJson(json['tenants']) : null,
    );
  }

  bool get isExpired {
    if (status == null) return false;
    return status == TenancyAction.CANCEL;
  }

  bool get isPaused {
    if (status == null) return false;
    return status == TenancyAction.PAUSE;
  }

  bool get isEnded {
    if (status == null) return false;
    return status == TenancyAction.ENDED;
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

  Tenancy copyWith({
    int? tenancyId,
    int? landlordId,
    int? tenantId,
    String? propertyAddress,
    double? rentAmount,
    DateTime? startDate,
    DateTime? endDate,
    TenancyAction? status,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return Tenancy(
      tenancyId: tenancyId ?? this.tenancyId,
      landlordId: landlordId ?? this.landlordId,
      tenantId: tenantId ?? this.tenantId,
      propertyAddress: propertyAddress ?? this.propertyAddress,
      rentAmount: rentAmount ?? this.rentAmount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  List<TenancyAction> availableActions() {
    final List<TenancyAction> actions = [];

    actions.addAll([
      TenancyAction.VIEW,
      TenancyAction.EDIT,
      TenancyAction.SEND_REMINDER,
    ]);

    if (isPaused) {
      actions.add(TenancyAction.RESUME);
    } else {
      actions.add(TenancyAction.PAUSE);
    }
    if (isExpired) {
      actions.add(TenancyAction.ENDED);
    }
    if (!isEnded) {
      actions.add(TenancyAction.CANCEL);
    }

    return actions;
  }
}
