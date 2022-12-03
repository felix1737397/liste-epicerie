import 'dart:convert';

class Metric {
  double? amount;
  String? unitLong;
  String? unitShort;

  Metric({
    this.amount,
    this.unitLong,
    this.unitShort,
  });

  Metric copyWith({
    double? amount,
    String? unitLong,
    String? unitShort,
  }) {
    return Metric(
      amount: amount ?? this.amount,
      unitLong: unitLong ?? this.unitLong,
      unitShort: unitShort ?? this.unitShort,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'unitLong': unitLong,
      'unitShort': unitShort,
    };
  }

  factory Metric.fromMap(Map<String, dynamic> map) {
    return Metric(
      amount: map['amount'],
      unitLong: map['unitLong'],
      unitShort: map['unitShort'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Metric.fromJson(String source) => Metric.fromMap(json.decode(source));

  @override
  String toString() =>
      'Metric(amount: $amount, unitLong: $unitLong, unitShort: $unitShort)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Metric &&
        other.amount == amount &&
        other.unitLong == unitLong &&
        other.unitShort == unitShort;
  }

  @override
  int get hashCode => amount.hashCode ^ unitLong.hashCode ^ unitShort.hashCode;
}
