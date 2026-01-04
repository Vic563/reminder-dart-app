import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/priority.dart';
import '../../domain/entities/reminder_entity.dart';
import '../providers/reminders_provider.dart';
import '../../../categories/presentation/providers/categories_provider.dart';
import '../widgets/reminder_list_tile.dart';

class RemindersListScreen extends ConsumerWidget {
  const RemindersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(filteredRemindersProvider);
    final filter = ref.watch(reminderFilterProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        actions: [
          // Filter by category
          categoriesAsync.when(
            data: (categories) => PopupMenuButton<int?>(
              icon: Badge(
                isLabelVisible: filter.categoryId != null,
                child: const Icon(Icons.filter_list),
              ),
              tooltip: 'Filter by category',
              onSelected: (categoryId) {
                ref.read(reminderFilterProvider.notifier).setCategory(categoryId);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: null,
                  child: Text('All categories'),
                ),
                const PopupMenuDivider(),
                ...categories.map(
                  (c) => PopupMenuItem(
                    value: c.id,
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: c.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(c.name),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          // Filter by priority
          PopupMenuButton<Priority?>(
            icon: Badge(
              isLabelVisible: filter.priority != null,
              child: const Icon(Icons.flag),
            ),
            tooltip: 'Filter by priority',
            onSelected: (priority) {
              ref.read(reminderFilterProvider.notifier).setPriority(priority);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('All priorities'),
              ),
              const PopupMenuDivider(),
              ...Priority.values.map(
                (p) => PopupMenuItem(
                  value: p,
                  child: Row(
                    children: [
                      Icon(Icons.flag, color: p.color, size: 16),
                      const SizedBox(width: 8),
                      Text(p.label),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Show completed toggle
          IconButton(
            icon: Icon(
              filter.showCompleted
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
            ),
            tooltip: filter.showCompleted
                ? 'Hide completed'
                : 'Show completed',
            onPressed: () {
              ref
                  .read(reminderFilterProvider.notifier)
                  .setShowCompleted(!filter.showCompleted);
            },
          ),
          // Sort order
          PopupMenuButton<ReminderSortOrder>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort by',
            onSelected: (order) {
              ref.read(reminderFilterProvider.notifier).setSortOrder(order);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ReminderSortOrder.dueDate,
                child: Row(
                  children: [
                    if (filter.sortOrder == ReminderSortOrder.dueDate)
                      const Icon(Icons.check, size: 16)
                    else
                      const SizedBox(width: 16),
                    const SizedBox(width: 8),
                    const Text('Due date'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ReminderSortOrder.priority,
                child: Row(
                  children: [
                    if (filter.sortOrder == ReminderSortOrder.priority)
                      const Icon(Icons.check, size: 16)
                    else
                      const SizedBox(width: 16),
                    const SizedBox(width: 8),
                    const Text('Priority'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ReminderSortOrder.createdAt,
                child: Row(
                  children: [
                    if (filter.sortOrder == ReminderSortOrder.createdAt)
                      const Icon(Icons.check, size: 16)
                    else
                      const SizedBox(width: 16),
                    const SizedBox(width: 8),
                    const Text('Created date'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: remindersAsync.when(
        data: (reminders) {
          if (reminders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No reminders yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create your first reminder',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            );
          }

          // Group reminders by date
          final grouped = _groupRemindersByDate(reminders);

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: grouped.length,
            itemBuilder: (context, index) {
              final group = grouped[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      group.label,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: group.isOverdue
                                ? Colors.red
                                : Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  ...group.reminders.map(
                    (reminder) => ReminderListTile(
                      reminder: reminder,
                      onTap: () =>
                          context.push('/reminder/${reminder.id}/edit'),
                      onToggleComplete: () {
                        ref
                            .read(remindersNotifierProvider.notifier)
                            .toggleComplete(reminder.id!);
                      },
                      onDelete: () {
                        ref
                            .read(remindersNotifierProvider.notifier)
                            .deleteReminder(reminder.id!);
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.invalidate(filteredRemindersProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/reminder/new'),
        icon: const Icon(Icons.add),
        label: const Text('New Reminder'),
      ),
    );
  }

  List<_ReminderGroup> _groupRemindersByDate(List<ReminderEntity> reminders) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final nextWeek = today.add(const Duration(days: 7));

    final overdue = <ReminderEntity>[];
    final todayList = <ReminderEntity>[];
    final tomorrowList = <ReminderEntity>[];
    final thisWeek = <ReminderEntity>[];
    final later = <ReminderEntity>[];
    final completed = <ReminderEntity>[];

    for (final r in reminders) {
      if (r.isCompleted) {
        completed.add(r);
      } else {
        final dueDay = DateTime(r.dueDate.year, r.dueDate.month, r.dueDate.day);
        if (dueDay.isBefore(today)) {
          overdue.add(r);
        } else if (dueDay.isAtSameMomentAs(today)) {
          todayList.add(r);
        } else if (dueDay.isAtSameMomentAs(tomorrow)) {
          tomorrowList.add(r);
        } else if (dueDay.isBefore(nextWeek)) {
          thisWeek.add(r);
        } else {
          later.add(r);
        }
      }
    }

    final groups = <_ReminderGroup>[];
    if (overdue.isNotEmpty) {
      groups.add(_ReminderGroup('Overdue', overdue, isOverdue: true));
    }
    if (todayList.isNotEmpty) {
      groups.add(_ReminderGroup('Today', todayList));
    }
    if (tomorrowList.isNotEmpty) {
      groups.add(_ReminderGroup('Tomorrow', tomorrowList));
    }
    if (thisWeek.isNotEmpty) {
      groups.add(_ReminderGroup('This Week', thisWeek));
    }
    if (later.isNotEmpty) {
      groups.add(_ReminderGroup('Later', later));
    }
    if (completed.isNotEmpty) {
      groups.add(_ReminderGroup('Completed', completed));
    }

    return groups;
  }
}

class _ReminderGroup {
  final String label;
  final List<ReminderEntity> reminders;
  final bool isOverdue;

  _ReminderGroup(this.label, this.reminders, {this.isOverdue = false});
}
