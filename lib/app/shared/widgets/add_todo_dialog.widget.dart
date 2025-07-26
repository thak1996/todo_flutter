import 'package:flutter/material.dart';

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

  const AddTodoDialog({required this.onAdd, required this.grupos, super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  int priority = 0;
  String? selectedGroupId;
  DateTime? completedAt;
  DateTime? createAt = DateTime.now();
  DateTime? deletedAt;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Tarefa'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
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
              decoration: const InputDecoration(
                labelText: 'Grupo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: priority,
              onChanged: (value) {
                if (value != null) setState(() => priority = value);
              },
              items: const [
                DropdownMenuItem(value: 0, child: Text('Baixa prioridade')),
                DropdownMenuItem(value: 1, child: Text('Média prioridade')),
                DropdownMenuItem(value: 2, child: Text('Alta prioridade')),
              ],
              decoration: const InputDecoration(
                labelText: 'Prioridade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final title = titleController.text;
            if (title.isNotEmpty) {
              widget.onAdd(
                title: title,
                description: descriptionController.text.isEmpty
                    ? null
                    : descriptionController.text,
                priority: priority,
                completedAt: completedAt,
                createAt: createAt,
                deletedAt: deletedAt,
                groupId: selectedGroupId,
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
