import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_language_app/l10n/l10n.dart';
import 'package:multi_language_app/language/language_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return DropdownButton<String>(
          value: state.locale.languageCode,
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              context.read<LanguageBloc>().add(
                    LanguageChanged(
                      Locale(newValue),
                    ),
                  );
            }
          },
          items: [
            DropdownMenuItem(
              value: 'en',
              child: Text(l10n.english),
            ),
            DropdownMenuItem(
              value: 'hi',
              child: Text(l10n.hindi),
            ),
            DropdownMenuItem(
              value: 'bn',
              child: Text(l10n.bengali),
            ),
          ],
        );
      },
    );
  }
}
