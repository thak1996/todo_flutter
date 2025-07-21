import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_cubit.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Switch(
          value: state == ThemeState.dark,
          onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
          thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
            if (state == ThemeState.dark) {
              return const Icon(Icons.dark_mode);
            }
            return const Icon(Icons.light_mode);
          }),
        );
      },
    );
  }
}

class ThemeSwitchIcon extends StatelessWidget {
  const ThemeSwitchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            state == ThemeState.light ? Icons.dark_mode : Icons.light_mode,
          ),
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          tooltip: state == ThemeState.light
              ? 'Switch to dark mode'
              : 'Switch to light mode',
        );
      },
    );
  }
}
