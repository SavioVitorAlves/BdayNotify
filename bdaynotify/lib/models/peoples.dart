class People {
  final String id;
  final String name;
  final DateTime date;
  final bool isVerify;
  People({
    required this.id,
    required this.name,
    required this.date,
    this.isVerify = false
  });

  // Método para converter People para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),  // Converte DateTime para String
      'isVerify': isVerify,
    };
  }
}
