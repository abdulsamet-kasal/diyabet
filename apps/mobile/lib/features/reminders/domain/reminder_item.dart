enum ReminderType {
  fasting,
  postPrandial,
  basal,
  custom,
}

class ReminderItem {
  final String id;
  final String title;
  final int hour;
  final int minute;
  final bool isEnabled;
  final ReminderType type;
  final String? note;

  const ReminderItem({
    required this.id,
    required this.title,
    required this.hour,
    required this.minute,
    this.isEnabled = true,
    required this.type,
    this.note,
  });

  String get formattedTime =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  ReminderItem copyWith({
    String? id,
    String? title,
    int? hour,
    int? minute,
    bool? isEnabled,
    ReminderType? type,
    String? note,
  }) {
    return ReminderItem(
      id: id ?? this.id,
      title: title ?? this.title,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      isEnabled: isEnabled ?? this.isEnabled,
      type: type ?? this.type,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'hour': hour,
        'minute': minute,
        'isEnabled': isEnabled,
        'type': type.name,
        'note': note,
      };

  factory ReminderItem.fromJson(Map<String, dynamic> json) {
    return ReminderItem(
      id: json['id'] as String,
      title: json['title'] as String,
      hour: json['hour'] as int,
      minute: json['minute'] as int,
      isEnabled: json['isEnabled'] as bool? ?? true,
      type: ReminderType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ReminderType.custom,
      ),
      note: json['note'] as String?,
    );
  }
}
