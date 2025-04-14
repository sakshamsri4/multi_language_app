import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_language_app/bloc/theme_cubit.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<ThemeCubit>().toggleTheme();
      },
      icon: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return RotationTransition(turns: animation, child: child);
            },
            child: Icon(
              themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
              key: ValueKey<ThemeMode>(themeMode),
            ),
          );
        },
      ),
    );
  }
}
