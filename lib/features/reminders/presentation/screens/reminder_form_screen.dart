import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/priority.dart';
import '../../domain/entities/recurrence_rule.dart';
import '../../domain/entities/reminder_entity.dart';
import '../providers/reminders_provider.dart';
import '../../../categories/presentation/providers/categories_provider.dart';

class ReminderFormScreen extends ConsumerStatefulWidget {
  final int? reminderId;

  const ReminderFormScreen({super.key, this.reminderId});

  @override
  ConsumerState<ReminderFormScreen> createState() => _ReminderFormScreenState();
}

class _ReminderFormScreenState extends ConsumerState<ReminderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime _dueDate = DateTime.now().add(const Duration(hours: 1));
  Priority _priority = Priority.medium;
  bool _isRecurring = false;
  RecurrenceFrequency _frequency = RecurrenceFrequency.daily;
  int _interval = 1;
  List<int> _selectedCategoryIds = [];

  bool _isLoading = false;
  bool _isInitialized = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _initializeForEdit(ReminderEntity reminder) {
    if (_isInitialized) return;
    _isInitialized = true;

    _titleController.text = reminder.title;
    _descriptionController.text = reminder.description ?? '';
    _dueDate = reminder.dueDate;
    _priority = reminder.priority;
    _isRecurring = reminder.isRecurring;
    if (reminder.recurrenceRule != null) {
      _frequency = reminder.recurrenceRule!.frequency;
      _interval = reminder.recurrenceRule!.interval;
    }
    _selectedCategoryIds = reminder.categories.map((c) => c.id!).toList();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (date != null) {
      setState(() {
        _dueDate = DateTime(
          date.year,
          date.month,
          date.day,
          _dueDate.hour,
          _dueDate.minute,
        );
      });
    }
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dueDate),
    );
    if (time != null) {
      setState(() {
        _dueDate = DateTime(
          _dueDate.year,
          _dueDate.month,
          _dueDate.day,
          time.hour,
          time.minute,
        );
      });
    }
  }

  Future<void> _saveReminder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final notifier = ref.read(remindersNotifierProvider.notifier);
      final recurrenceRule = _isRecurring
          ? RecurrenceRule(frequency: _frequency, interval: _interval)
          : null;

      if (widget.reminderId != null) {
        await notifier.updateReminder(
          id: widget.reminderId!,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          dueDate: _dueDate,
          priority: _priority,
          isRecurring: _isRecurring,
          recurrenceRule: recurrenceRule,
          categoryIds: _selectedCategoryIds,
        );
      } else {
        await notifier.addReminder(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          dueDate: _dueDate,
          priority: _priority,
          isRecurring: _isRecurring,
          recurrenceRule: recurrenceRule,
          categoryIds: _selectedCategoryIds,
        );
      }

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.reminderId != null;
    final categoriesAsync = ref.watch(categoriesProvider);

    // Load existing reminder for editing
    if (isEditing) {
      final remindersAsync = ref.watch(remindersStreamProvider);
      remindersAsync.whenData((reminders) {
        final reminder = reminders.firstWhere(
          (r) => r.id == widget.reminderId,
          orElse: () => throw Exception('Reminder not found'),
        );
        _initializeForEdit(reminder);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Reminder' : 'New Reminder'),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Reminder'),
                    content: const Text(
                        'Are you sure you want to delete this reminder?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await ref
                      .read(remindersNotifierProvider.notifier)
                      .deleteReminder(widget.reminderId!);
                  if (mounted) context.pop();
                }
              },
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter reminder title',
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Enter description',
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // Date and Time
            Text(
              'Due Date & Time',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _selectDate,
                    icon: const Icon(Icons.calendar_today),
                    label: Text(DateFormat.yMMMd().format(_dueDate)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _selectTime,
                    icon: const Icon(Icons.access_time),
                    label: Text(DateFormat.jm().format(_dueDate)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Priority
            Text(
              'Priority',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<Priority>(
              segments: Priority.values.map((p) {
                return ButtonSegment(
                  value: p,
                  label: Text(p.label),
                  icon: Icon(Icons.flag, color: p.color),
                );
              }).toList(),
              selected: {_priority},
              onSelectionChanged: (selected) {
                setState(() => _priority = selected.first);
              },
            ),
            const SizedBox(height: 24),

            // Recurring
            SwitchListTile(
              title: const Text('Recurring'),
              subtitle: const Text('Repeat this reminder'),
              value: _isRecurring,
              onChanged: (value) => setState(() => _isRecurring = value),
            ),
            if (_isRecurring) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Every'),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      initialValue: _interval.toString(),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        final n = int.tryParse(value);
                        if (n != null && n > 0) {
                          setState(() => _interval = n);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<RecurrenceFrequency>(
                      value: _frequency,
                      items: RecurrenceFrequency.values.map((f) {
                        return DropdownMenuItem(
                          value: f,
                          child: Text(_interval == 1
                              ? f.label.toLowerCase().replaceFirst('ly', '')
                              : f.label.toLowerCase().replaceFirst('ly', 's')),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _frequency = value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),

            // Categories
            Text(
              'Categories',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            categoriesAsync.when(
              data: (categories) => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((c) {
                  final isSelected = _selectedCategoryIds.contains(c.id);
                  return FilterChip(
                    label: Text(c.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedCategoryIds.add(c.id!);
                        } else {
                          _selectedCategoryIds.remove(c.id);
                        }
                      });
                    },
                    avatar: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: c.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error loading categories'),
            ),
            const SizedBox(height: 32),

            // Save button
            FilledButton.icon(
              onPressed: _isLoading ? null : _saveReminder,
              icon: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
              label: Text(isEditing ? 'Update Reminder' : 'Create Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
