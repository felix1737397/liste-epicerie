import 'dart:convert';

class Us {
  double? amount;
  String? unitLong;
  String? unitShort;

  Us({
    this.amount,
    this.unitLong,
    this.unitShort,
  });

  Us copyWith({
    double? amount,
    String? unitLong,
    String? unitShort,
  }) {
    return Us(
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

  factory Us.fromMap(Map<String, dynamic> map) {
    return Us(
      amount: map['amount'],
      unitLong: map['unitLong'],
      unitShort: map['unitShort'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Us.fromJson(String source) => Us.fromMap(json.decode(source));

  @override
  String toString() =>
      'Us(amount: $amount, unitLong: $unitLong, unitShort: $unitShort)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Us &&
        other.amount == amount &&
        other.unitLong == unitLong &&
        other.unitShort == unitShort;
  }

  @override
  int get hashCode => amount.hashCode ^ unitLong.hashCode ^ unitShort.hashCode;
}
