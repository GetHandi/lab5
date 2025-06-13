class Calculation {
  final int? id;
  final double mass;
  final double radius;
  final double result;
  final DateTime date;

  Calculation({
    this.id,
    required this.mass,
    required this.radius,
    required this.result,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mass': mass,
      'radius': radius,
      'result': result,
      'date': date.toIso8601String(),
    };
  }

 factory Calculation.fromMap(Map<String, dynamic> map) {
  return Calculation(
    id: map['id'],
    mass: map['mass'],
    radius: map['radius'],
    result: map['result'],
    date: DateTime.tryParse(map['date']) ?? DateTime.now(),
  );
}
}