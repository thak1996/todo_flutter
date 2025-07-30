import 'package:flutter/material.dart';
import 'package:todo_flutter/app/core/models/group.model.dart';
import 'package:todo_flutter/app/core/models/todo.model.dart';
import 'package:todo_flutter/app/l10n/app_localizations.dart';
import 'package:todo_flutter/app/shared/widgets/add_todo_dialog.widget.dart';

Future<bool?> showConfirmDeleteDialog(
  BuildContext context,
  AppLocalizations l10n,
) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.deleteTask),
      content: Text(l10n.confirmDeleteTask),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.delete),
        ),
      ],
    ),
  );
}

// COMPONENTE: Tile de tarefa com Dismissible
class TodoListTile extends StatelessWidget {
  final TodoModel todo;
  final List<GroupModel> grupos;
  final void Function()? onDelete;
  final void Function(TodoModel updated)? onEdit;
  final void Function(bool?)? onToggleComplete;
  const TodoListTile({
    super.key,
    required this.todo,
    required this.grupos,
    this.onDelete,
    this.onEdit,
    this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    return ListTile(
      trailing: Checkbox(
        value: todo.completedAt != null,
        onChanged: onToggleComplete,
      ),
      title: Text(
        todo.title,
        style: theme.titleMedium?.copyWith(
          decoration: todo.completedAt != null
              ? TextDecoration.lineThrough
              : null,
        ),
      ),
      subtitle: todo.description != null && todo.description!.isNotEmpty
          ? Text(todo.description!)
          : null,
      onTap: null,
      onLongPress: () async {
        final result = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.todoOptions),
            content: Text(l10n.chooseAction),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop('edit'),
                child: Text(l10n.edit),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop('delete'),
                child: Text(l10n.delete),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.cancel),
              ),
            ],
          ),
        );
        if (!context.mounted) return;
        if (result == 'edit') {
          await showDialog(
            context: context,
            builder: (context) => AddTodoDialog(
              grupos: grupos.map((g) => {'id': g.id, 'name': g.name}).toList(),
              initialTitle: todo.title,
              initialDescription: todo.description,
              initialPriority: todo.priority.index,
              initialGroupId: todo.groupId,
              initialCompletedAt: todo.completedAt,
              initialCreateAt: todo.createAt,
              initialDeletedAt: todo.deletedAt,
              onAdd:
                  ({
                    required String title,
                    String? description,
                    required int priority,
                    DateTime? completedAt,
                    DateTime? createAt,
                    DateTime? deletedAt,
                    String? groupId,
                  }) {
                    onEdit?.call(
                      todo.copyWith(
                        title: title,
                        description: description,
                        priority: TodoPriority.values[priority],
                        completedAt: completedAt,
                        createAt: createAt,
                        deletedAt: deletedAt,
                        groupId: groupId,
                      ),
                    );
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(l10n.taskEdited)));
                  },
            ),
          );
        } else if (result == 'delete') {
          final confirm = await showConfirmDeleteDialog(context, l10n);
          if (context.mounted && confirm != null && confirm) {
            onDelete?.call();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.taskDeleted)));
          }
        }
      },
    );
  }
}
