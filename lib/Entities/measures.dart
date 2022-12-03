import 'dart:convert';

import 'package:liste_epicerie/Entities/metric.dart';
import 'package:liste_epicerie/Entities/us_measure.dart';

class Measure {
  Metric? metric;
  Us? us;

  Measure({
    this.metric,
    this.us,
  });

  Measure copyWith({
    Metric? metric,
    Us? us,
  }) {
    return Measure(
      metric: metric ?? this.metric,
      us: us ?? this.us,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metric': metric?.toMap(),
      'us': us?.toMap(),
    };
  }

  factory Measure.fromMap(Map<String, dynamic> map) {
    return Measure(
      metric: Metric.fromMap(map['metric']),
      us: Us.fromMap(map['us']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Measure.fromJson(String source) =>
      Measure.fromMap(json.decode(source));

  @override
  String toString() => 'Measure(metric: $metric, us: $us)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Measure && other.metric == metric && other.us == us;
  }

  @override
  int get hashCode => metric.hashCode ^ us.hashCode;
}
