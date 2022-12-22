import 'dart:convert';

import 'package:liste_epicerie/Entities/measures.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Item {
  String? id;
  String? name;
  String? unit;
  double? amount;
  bool? isBought;
  Measure? measures;

  Item({
    this.id,
    this.name,
    this.unit,
    this.amount,
    this.isBought,
    this.measures,
  });

  Item copyWith({
    String? id,
    String? name,
    String? unit,
    double? amount,
    bool? isBought,
    Measure? measures,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      amount: amount ?? this.amount,
      isBought: isBought ?? this.isBought,
      measures: measures ?? this.measures,
    );
  }

  Map<String, dynamic> toMap({withId = true}) {
    return {
      if (withId) '_id': id,
      'name': name,
      'unit': unit,
      'amount': amount,
      'isBought': isBought,
      'measures': measures?.toMap(),
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['_id'] is ObjectId
          ? map['_id'].toHexString()
          : map['_id'].toString(),
      name: map['name'] != null ? map['name'].toString() : null,
      unit: map['unit'] != null ? map['unit'].toString() : null,
      amount: map['amount'] != null ? map['amount'].toDouble() : null,
      isBought: map['isBought'] != null ? map['isBought'] : false,
      measures:
          map['measures'] != null ? Measure.fromMap(map['measures']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() =>
      'Item(id: $id, name: $name, unit: $unit, amount: $amount, isBought: $isBought, measures: $measures)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.id == id &&
        other.name == name &&
        other.unit == unit &&
        other.amount == amount &&
        other.isBought == isBought &&
        other.measures == measures;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      unit.hashCode ^
      amount.hashCode ^
      isBought.hashCode ^
      measures.hashCode;
}
