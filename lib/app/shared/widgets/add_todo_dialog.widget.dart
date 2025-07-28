import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/app/l10n/app_localizations.dart';

class AddTodoDialog extends StatefulWidget {
  final void Function({
    required String title,
    String? description,
    required int priority,
    DateTime? completedAt,
    DateTime? createAt,
    DateTime? deletedAt,
    String? groupId,
  })
  onAdd;
  final List<Map<String, String>> grupos;
  final String? initialTitle;
  final String? initialDescription;
  final int? initialPriority;
  final String? initialGroupId;
  final DateTime? initialCompletedAt;
  final DateTime? initialCreateAt;
  final DateTime? initialDeletedAt;

  const AddTodoDialog({
    required this.onAdd,
    required this.grupos,
    this.initialTitle,
    this.initialDescription,
    this.initialPriority,
    this.initialGroupId,
    this.initialCompletedAt,
    this.initialCreateAt,
    this.initialDeletedAt,
    super.key,
  });

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late int priority;
  String? selectedGroupId;
  DateTime? completedAt;
  DateTime? createAt;
  DateTime? deletedAt;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initialTitle ?? '');
    descriptionController = TextEditingController(
      text: widget.initialDescription ?? '',
    );
    priority = widget.initialPriority ?? 0;
    selectedGroupId = widget.initialGroupId;
    completedAt = widget.initialCompletedAt;
    createAt = widget.initialCreateAt ?? DateTime.now();
    deletedAt = widget.initialDeletedAt;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.addTask, textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: l10n.title,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.titleRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: l10n.description,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedGroupId,
                onChanged: (value) {
                  setState(() => selectedGroupId = value);
                },
                items: widget.grupos
                    .map(
                      (g) => DropdownMenuItem(
                        value: g['id'],
                        child: Text(g['name'] ?? ''),
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(
                  labelText: l10n.group,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                value: priority,
                onChanged: (value) {
                  if (value != null) setState(() => priority = value);
                },
                items: [
                  DropdownMenuItem(value: 0, child: Text(l10n.priorityLow)),
                  DropdownMenuItem(value: 1, child: Text(l10n.priorityMedium)),
                  DropdownMenuItem(value: 2, child: Text(l10n.priorityHigh)),
                ],
                decoration: InputDecoration(
                  labelText: l10n.priority,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text(l10n.cancel)),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onAdd(
                title: titleController.text.trim(),
                description: descriptionController.text.isEmpty
                    ? null
                    : descriptionController.text,
                priority: priority,
                completedAt: completedAt,
                createAt: createAt,
                deletedAt: deletedAt,
                groupId: selectedGroupId,
              );
              context.pop();
            }
          },
          child: Text(l10n.add),
        ),
      ],
    );
  }
}
