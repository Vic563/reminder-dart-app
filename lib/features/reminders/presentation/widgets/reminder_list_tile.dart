import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/reminder_entity.dart';

class ReminderListTile extends StatelessWidget {
  final ReminderEntity reminder;
  final VoidCallback onTap;
  final VoidCallback onToggleComplete;
  final VoidCallback onDelete;

  const ReminderListTile({
    super.key,
    required this.reminder,
    required this.onTap,
    required this.onToggleComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOverdue = reminder.isOverdue;

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checkbox
                Checkbox(
                  value: reminder.isCompleted,
                  onChanged: (_) => onToggleComplete(),
                  shape: const CircleBorder(),
                ),
                const SizedBox(width: 8),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        reminder.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          decoration: reminder.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: reminder.isCompleted
                              ? theme.colorScheme.outline
                              : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Due date and time
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: isOverdue
                                ? Colors.red
                                : theme.colorScheme.outline,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDueDate(reminder.dueDate),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isOverdue
                                  ? Colors.red
                                  : theme.colorScheme.outline,
                            ),
                          ),
                          if (reminder.isRecurring) ...[
                            const SizedBox(width: 8),
                            Icon(
                              Icons.repeat,
                              size: 14,
                              color: theme.colorScheme.outline,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              reminder.recurrenceRule?.description ?? 'Recurring',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ],
                        ],
                      ),
                      // Categories
                      if (reminder.categories.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: reminder.categories.map((c) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: c.color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                c.name,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: c.color,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                // Priority indicator
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: reminder.priority.color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDueDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(date.year, date.month, date.day);
    final tomorrow = today.add(const Duration(days: 1));

    final timeStr = DateFormat.jm().format(date);

    if (dueDay.isAtSameMomentAs(today)) {
      return 'Today at $timeStr';
    } else if (dueDay.isAtSameMomentAs(tomorrow)) {
      return 'Tomorrow at $timeStr';
    } else if (dueDay.isBefore(today)) {
      final diff = today.difference(dueDay).inDays;
      if (diff == 1) {
        return 'Yesterday at $timeStr';
      }
      return '${DateFormat.MMMd().format(date)} at $timeStr';
    } else {
      return '${DateFormat.MMMd().format(date)} at $timeStr';
    }
  }
}
