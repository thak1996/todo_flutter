import 'package:flutter/material.dart';
import 'package:todo_flutter/app/core/models/export.models.dart';

class GroupsListView extends StatelessWidget {
  final List<GroupModel> groups;
  const GroupsListView({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) {
      return const Center(child: Text('Nenhum grupo encontrado.'));
    }
    return ListView.separated(
      itemCount: groups.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (context, index) {
        final group = groups[index];
        return ListTile(
          leading: const Icon(Icons.group),
          title: Text(group.name),
          onTap: () {
            // Navegar para detalhes do grupo, se desejar
          },
        );
      },
    );
  }
}
