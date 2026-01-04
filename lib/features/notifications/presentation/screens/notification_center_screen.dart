import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../reminders/presentation/providers/reminders_provider.dart';

class NotificationCenterScreen extends ConsumerWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification History'),
      ),
      body: remindersAsync.when(
        data: (reminders) {
          // Show completed reminders as notification history
          final completedReminders = reminders
              .where((r) => r.isCompleted)
              .toList()
            ..sort((a, b) => (b.completedAt ?? b.updatedAt)
                .compareTo(a.completedAt ?? a.updatedAt));

          if (completedReminders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No completed reminders yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Completed reminders will appear here',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: completedReminders.length,
            itemBuilder: (context, index) {
              final reminder = completedReminders[index];
              final completedDate =
                  reminder.completedAt ?? reminder.updatedAt;

              return Card(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ),
                  title: Text(
                    reminder.title,
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  subtitle: Text(
                    'Completed ${_formatDate(completedDate)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.restore),
                    tooltip: 'Mark as incomplete',
                    onPressed: () {
                      ref
                          .read(remindersNotifierProvider.notifier)
                          .toggleComplete(reminder.id!);
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateDay = DateTime(date.year, date.month, date.day);

    if (dateDay.isAtSameMomentAs(today)) {
      return 'today at ${DateFormat.jm().format(date)}';
    } else if (dateDay.isAtSameMomentAs(today.subtract(const Duration(days: 1)))) {
      return 'yesterday at ${DateFormat.jm().format(date)}';
    } else {
      return 'on ${DateFormat.MMMd().format(date)}';
    }
  }
}
