import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/extension/exception.extension.dart';
import 'package:todo_flutter/app/core/service/export.service.dart';
import 'package:todo_flutter/app/l10n/app_localizations.dart';
import 'package:todo_flutter/app/shared/widgets/drawer_widget.dart';
import 'groups.controller.dart';
import 'groups.state.dart';
import 'widgets/groups.listview.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (_) => GroupsController(AuthService(), GroupService()),
      child: BlocBuilder<GroupsController, GroupsState>(
        builder: (context, state) {
          return Scaffold(
            drawer: const UserDrawer(),
            appBar: AppBar(
              title: Text(l10n.groups),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => context.read<GroupsController>().init(),
                ),
              ],
            ),
            body: state is GroupsLoading
                ? const Center(child: CircularProgressIndicator())
                : state is GroupsLoaded
                ? GroupsListView(groups: state.groups ?? [])
                : state is GroupsError
                ? Center(child: Text(state.message.userMessage.trim()))
                : const SizedBox.shrink(),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final name = await showDialog<String>(
                  context: context,
                  builder: (context) => const _CreateGroupDialog(),
                );
                if (name != null && name.trim().isNotEmpty && context.mounted) {
                  context.read<GroupsController>().createGroup(name.trim());
                }
              },
              tooltip: l10n.createGroup,
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class _CreateGroupDialog extends StatefulWidget {
  const _CreateGroupDialog();

  @override
  State<_CreateGroupDialog> createState() => _CreateGroupDialogState();
}

class _CreateGroupDialogState extends State<_CreateGroupDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.newGroup),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(labelText: l10n.groupName),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text(l10n.create),
        ),
      ],
    );
  }
}
