import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:todo_flutter/app/l10n/app_localizations.dart';
import 'package:todo_flutter/app/page/home/home.controller.dart';
import 'package:todo_flutter/app/page/home/home.state.dart';
import 'package:todo_flutter/app/shared/helpers/capitalize_name.helper.dart';
import 'package:todo_flutter/app/shared/widgets/export.widgets.dart';

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
                    ProfileImagePicker(
                      radius: 32,
                      fallbackText: (user?.name?.isNotEmpty ?? false)
                          ? user!.name![0].toUpperCase()
                          : '',
                      fallbackBgColor: Colors.red,
                      networkImageUrl: user?.photoUrl,
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
                leading: const Icon(AntDesign.home_outline),
                title: Text(l10n.todo),
                onTap: () => context.go('/home'),
              ),
              ListTile(
                leading: const Icon(AntDesign.profile_outline),
                title: Text(l10n.profile),
                onTap: () => context.go('/profile'),
              ),

              ListTile(
                leading: const Icon(AntDesign.group_outline),
                title: Text(l10n.groups),
                onTap: () => context.go('/groups'),
              ),
              ListTile(
                leading: const Icon(AntDesign.setting_outline),
                title: Text(l10n.settings),
                onTap: () => context.go('/settings'),
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(AntDesign.info_outline),
                title: const Text('Informações'),
                onTap: () => context.go('/information'),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ListTile(
                  leading: const Icon(AntDesign.logout_outline),
                  title: Text(l10n.logout),
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(l10n.logout),
                        content: Text(l10n.logoutConfirmation),
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
