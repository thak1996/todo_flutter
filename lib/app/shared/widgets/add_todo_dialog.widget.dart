import 'package:flutter/material.dart';

class AddTodoDialog extends StatefulWidget {
  final void Function(String title, String description, int priority) onAdd;

  const AddTodoDialog({required this.onAdd, super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  int priority = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Tarefa'),
      content: Column(
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
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final title = titleController.text;
            final description = descriptionController.text;
            if (title.isNotEmpty) {
              widget.onAdd(title, description, priority);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
