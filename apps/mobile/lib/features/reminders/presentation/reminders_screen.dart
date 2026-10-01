import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../data/reminder_notifier.dart';
import '../domain/reminder_item.dart';

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders = ref.watch(reminderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ölçüm ve Tedavi Hatırlatıcıları'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Clinical Recommendation Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                border: Border.all(color: AppTheme.primaryTeal.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.alarm, color: AppTheme.primaryTeal, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Düzenli ölçüm ve zamanında bazal enjeksiyonu, kan şekeri dalgalanmalarını (glisemik değişkenlik) önlemenin en etkili yoludur.',
                      style: TextStyle(fontSize: 13, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quick add post-meal check
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryTeal,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.add_alarm, color: Colors.white),
              label: const Text(
                'Şu Andan 2 Saat Sonraya Tokluk Ölçümü Ekle',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                ref.read(reminderProvider.notifier).schedulePostMealReminder(DateTime.now());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Yemekten 2 saat sonrasına tokluk şekeri hatırlatıcısı eklendi.'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            const Text(
              'Aktif Hatırlatıcılar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            if (reminders.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Center(child: Text('Henüz eklenmiş bir hatırlatıcı yok.')),
              )
            else
              ...reminders.map((item) => _buildReminderCard(context, ref, item)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primaryTeal,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Yeni Hatırlatıcı', style: TextStyle(color: Colors.white)),
        onPressed: () => _showAddReminderDialog(context, ref),
      ),
    );
  }

  Widget _buildReminderCard(BuildContext context, WidgetRef ref, ReminderItem item) {
    IconData icon;
    Color iconColor;
    switch (item.type) {
      case ReminderType.fasting:
        icon = Icons.wb_sunny_outlined;
        iconColor = Colors.orange;
        break;
      case ReminderType.basal:
        icon = Icons.nightlight_round;
        iconColor = Colors.indigo;
        break;
      case ReminderType.postPrandial:
        icon = Icons.restaurant;
        iconColor = AppTheme.primaryTeal;
        break;
      case ReminderType.custom:
        icon = Icons.notifications_none;
        iconColor = Colors.grey.shade700;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.15),
          child: Icon(icon, color: iconColor),
        ),
        title: Row(
          children: [
            Text(
              item.formattedTime,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: item.note != null
            ? Text(item.note!, style: TextStyle(fontSize: 12, color: Colors.grey.shade600))
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: item.isEnabled,
              activeThumbColor: AppTheme.primaryTeal,
              onChanged: (_) {
                ref.read(reminderProvider.notifier).toggleReminder(item.id);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20, color: Colors.grey),
              onPressed: () {
                ref.read(reminderProvider.notifier).deleteReminder(item.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddReminderDialog(BuildContext context, WidgetRef ref) {
    TimeOfDay selectedTime = TimeOfDay.now();
    final titleCtrl = TextEditingController();
    final noteCtrl = TextEditingController();
    ReminderType selectedType = ReminderType.custom;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Yeni Hatırlatıcı Ekle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Saat Seçin:'),
                  trailing: Text(
                    '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryTeal),
                  ),
                  onTap: () async {
                    final picked = await showTimePicker(context: ctx, initialTime: selectedTime);
                    if (picked != null) {
                      setDialogState(() => selectedTime = picked);
                    }
                  },
                ),
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Başlık (Örn: Akşam İnsülini)',
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<ReminderType>(
                  initialValue: selectedType,
                  decoration: const InputDecoration(labelText: 'Hatırlatıcı Türü'),
                  items: const [
                    DropdownMenuItem(value: ReminderType.fasting, child: Text('Açlık Ölçümü')),
                    DropdownMenuItem(value: ReminderType.postPrandial, child: Text('Tokluk Ölçümü')),
                    DropdownMenuItem(value: ReminderType.basal, child: Text('Bazal İnsülin')),
                    DropdownMenuItem(value: ReminderType.custom, child: Text('Diğer / Özel')),
                  ],
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedType = val);
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: noteCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Not (İsteğe bağlı)',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleCtrl.text.trim().isEmpty ? 'Hatırlatıcı' : titleCtrl.text.trim();
                ref.read(reminderProvider.notifier).addReminder(
                      title: title,
                      hour: selectedTime.hour,
                      minute: selectedTime.minute,
                      type: selectedType,
                      note: noteCtrl.text.trim().isEmpty ? null : noteCtrl.text.trim(),
                    );
                Navigator.of(ctx).pop();
              },
              child: const Text('Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
