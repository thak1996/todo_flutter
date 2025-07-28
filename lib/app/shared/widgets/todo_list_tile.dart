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
    return Dismissible(
      key: Key(todo.id.toString()),
      background: Container(
        color: Colors.blue,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(Icons.edit, color: Colors.white),
            SizedBox(width: 8),
            Text(l10n.editTask, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 8),
            Text(l10n.deleteTask, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final confirm = await showConfirmDeleteDialog(context, l10n);
          if (context.mounted && confirm != null && confirm) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.taskDeleted)));
            onDelete?.call();
          }
          return confirm ?? false;
        }
        // Swipe para direita: editar
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
        return false;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete?.call();
        }
      },
      child: ListTile(
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
      ),
    );
  }
}
