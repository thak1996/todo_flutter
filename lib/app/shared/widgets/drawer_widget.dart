import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/l10n/app_localizations.dart';
import 'package:todo_flutter/app/page/home/home.controller.dart';
import 'package:todo_flutter/app/page/home/home.state.dart';
import 'package:todo_flutter/app/shared/helpers/capitalize_name.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context).textTheme;
    return Drawer(
      child: BlocBuilder<HomeController, HomeState>(
        builder: (context, state) {
          final user = state is HomeLoaded ? state.user : null;
          return Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.red,
                      backgroundImage: user?.photoUrl != null
                          ? NetworkImage(user!.photoUrl!)
                          : null,
                      child: (user?.photoUrl == null)
                          ? Text(
                              (user?.name?.isNotEmpty ?? false)
                                  ? user!.name![0].toUpperCase()
                                  : '',
                              style: const TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            capitalizeName(user?.name ?? l10n.user),
                            style: theme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if ((user?.email?.isNotEmpty ?? false))
                            Text(
                              user!.email!,
                              style: theme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(l10n.profile),
                onTap: () => context.pop(),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(l10n.settings),
                onTap: () => context.pop(),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Informações'),
                onTap: () => context.pop(),
              ),
              Text("Drawer PhotoUrl: ${user?.photoUrl ?? " notFound"}"),
              const Spacer(),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(l10n.logout),
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(l10n.logout),
                        content: Text('Deseja realmente sair?'),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(false),
                            child: Text(l10n.cancel),
                          ),
                          TextButton(
                            onPressed: () => context.pop(true),
                            child: Text(l10n.logout),
                          ),
                        ],
                      ),
                    );
                    if (context.mounted && confirm == true) {
                      context.read<HomeController>().logout();
                      context.go('/login');
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
