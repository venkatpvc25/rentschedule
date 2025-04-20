class RazorpayPlanRequest {
  final String period; // "weekly", "monthly", etc.
  final int interval; // >= 1
  final RazorpayPlanItem item;
  final Map<String, String>? notes;

  RazorpayPlanRequest({
    required this.period,
    required this.interval,
    required this.item,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      "period": period,
      "interval": interval,
      "item": item.toJson(),
      if (notes != null) "notes": notes,
    };
  }
}

class RazorpayPlanItem {
  final String name;
  final int amount; // in paise (INR 699.00 => 69900)
  final String currency; // e.g., "INR"
  final String description;

  RazorpayPlanItem({
    required this.name,
    required this.amount,
    required this.currency,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "amount": amount,
      "currency": currency,
      "description": description,
    };
  }
}
