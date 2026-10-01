import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/reminder_item.dart';

const _kRemindersKey = 'gliko_user_reminders_v1';

class ReminderNotifier extends Notifier<List<ReminderItem>> {
  @override
  List<ReminderItem> build() {
    _loadFromStorage();
    return _defaultReminders();
  }

  static List<ReminderItem> _defaultReminders() {
    return [
      const ReminderItem(
        id: 'rem-fasting',
        title: 'Sabah Açlık Şekeri Ölçümü',
        hour: 8,
        minute: 0,
        type: ReminderType.fasting,
        note: 'Kahvaltıdan hemen önce ölçünüz.',
      ),
      const ReminderItem(
        id: 'rem-basal',
        title: 'Gece Bazal İnsülin Hatırlatması',
        hour: 22,
        minute: 30,
        type: ReminderType.basal,
        note: 'Hekiminizin belirlediği uzun etkili dozu uygulayınız.',
      ),
      const ReminderItem(
        id: 'rem-postprandial',
        title: 'Öğle Tokluk Şekeri Kontrolü',
        hour: 14,
        minute: 30,
        type: ReminderType.postPrandial,
        note: 'Yemeğin ilk lokmasından tam 2 saat sonra ölçünüz.',
      ),
    ];
  }

  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_kRemindersKey);
      if (raw != null) {
        final list = (jsonDecode(raw) as List)
            .map((item) => ReminderItem.fromJson(item as Map<String, dynamic>))
            .toList();
        state = list;
      }
    } catch (_) {
      // Fallback to default
    }
  }

  Future<void> _saveToStorage(List<ReminderItem> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = jsonEncode(items.map((e) => e.toJson()).toList());
      await prefs.setString(_kRemindersKey, raw);
    } catch (_) {}
  }

  Future<void> toggleReminder(String id) async {
    state = state.map((item) {
      if (item.id == id) {
        return item.copyWith(isEnabled: !item.isEnabled);
      }
      return item;
    }).toList();
    await _saveToStorage(state);
  }

  Future<void> addReminder({
    required String title,
    required int hour,
    required int minute,
    required ReminderType type,
    String? note,
  }) async {
    final newItem = ReminderItem(
      id: 'rem_${DateTime.now().microsecondsSinceEpoch}',
      title: title,
      hour: hour,
      minute: minute,
      isEnabled: true,
      type: type,
      note: note,
    );
    state = [...state, newItem];
    await _saveToStorage(state);
  }

  Future<void> deleteReminder(String id) async {
    state = state.where((item) => item.id != id).toList();
    await _saveToStorage(state);
  }

  Future<void> schedulePostMealReminder(DateTime mealTime) async {
    final postTime = mealTime.add(const Duration(hours: 2));
    final newItem = ReminderItem(
      id: 'rem_post_${DateTime.now().microsecondsSinceEpoch}',
      title: 'Öğün Sonrası 2. Saat Tokluk Ölçümü',
      hour: postTime.hour,
      minute: postTime.minute,
      isEnabled: true,
      type: ReminderType.postPrandial,
      note: 'Yemekten 2 saat sonra kan şekerinizi ölçün.',
    );
    state = [...state, newItem];
    await _saveToStorage(state);
  }
}

final reminderProvider =
    NotifierProvider<ReminderNotifier, List<ReminderItem>>(ReminderNotifier.new);
