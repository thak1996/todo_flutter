import 'package:flutter/material.dart';
import 'package:todo_flutter/app/core/models/export.models.dart';
import 'package:todo_flutter/app/l10n/app_localizations.dart';

class GroupsListView extends StatelessWidget {
  final List<GroupModel> groups;
  const GroupsListView({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (groups.isEmpty) {
      return Center(child: Text(l10n.noGroupsFound));
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
