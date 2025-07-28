import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/l10n/app_localizations.dart';
import 'package:todo_flutter/app/page/home/home.controller.dart';
import 'package:todo_flutter/app/page/home/home.state.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Drawer(
      child: BlocSelector<HomeController, HomeState, UserModel?>(
        selector: (state) {
          if (state is HomeUserLoaded) return state.user;
          return null;
        },
        builder: (context, user) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(user?.name ?? l10n.user),
                accountEmail: Text(user?.email ?? ''),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(user?.name?.substring(0, 1) ?? ''),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(l10n.profile),
                onTap: () {
                  Navigator.of(context).pop();
                  // Exemplo: Navigator.of(context).pushNamed('/profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(l10n.settings),
                onTap: () {
                  Navigator.of(context).pop();
                  // Exemplo: Navigator.of(context).pushNamed('/settings');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(l10n.logout),
                onTap: () {
                  context.read<HomeController>().logout();
                  context.go('/login');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
