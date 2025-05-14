import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentschedule/models/api_response.dart';
import 'package:rentschedule/models/rent_payment.dart';
import 'package:rentschedule/models/tenancy.dart';
import 'package:rentschedule/services/dio_service.dart';
import 'package:rentschedule/utils/global_error_handler.dart';

class TenancyService {
  final dio = DioService().dio;

  Future<ApiResponse<Tenancy>> performAction(
    TenancyAction action,
    int? tenancyId,
  ) async {
    try {
      final response = await dio.post(
        '/tenancy',
        data: {'action': action.name, 'tenancy_id': tenancyId},
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(
          response.data,
          (data) => Tenancy.fromJson(data),
        );
      } else {
        return ApiResponse.error("Unable to perform action");
      }
    } on Exception catch (e) {
      return ApiResponse.error("Unable to perform action");
    }
  }
}

enum TenancyAction {
  VIEW("VIEW", "View"),
  ADD_PAYMENT("ADD_PAYMENT", "Add Payment"),
  EDIT("EDIT", "Edit"),
  CANCEL("CANCEL", "Cancel"),
  ENDED("ENDED", "Ended"),
  RENEW("RENEW", "Renew"),
  PAUSE("PAUSE", "Pause"),
  RESUME("RESUME", "Resume"),
  SEND_REMINDER("SEND_REMINDER", "Send Reminder");

  final String name;
  final String value;

  const TenancyAction(this.name, this.value);
  static TenancyAction fromString(String action) {
    return TenancyAction.values.firstWhere(
      (e) => e.name.toUpperCase() == action.toUpperCase(),
      orElse: () => TenancyAction.VIEW,
    );
  }
}

extension TenancyActionExecutor on TenancyAction {
  Future<void> perform({
    required BuildContext context,
    required void Function() updateTenancies,
  }) async {
    switch (this) {
      case TenancyAction.CANCEL:
        final confirm = await context.showConfirmationDialog(
          title: "Cancel Tenancy?",
          message: "Are you sure you want to cancel this tenancy?",
        );
        if (confirm == true) {
          updateTenancies();
        }
        break;

      case TenancyAction.EDIT:
        //Navigator.pushNamed(context, '/edit-tenancy', arguments: tenancy);
        break;

      case TenancyAction.ADD_PAYMENT:
        //Navigator.pushNamed(context, '/add-payment', arguments: tenancy);
        break;
      case TenancyAction.VIEW:
        context.pushNamed('rent-schedule');
        break;

      default:
        //updateTenancies(context, tenancy.tenancyId!, this);
        break;
    }
  }
}
