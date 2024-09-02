import 'package:conta/config/theme.dart';
import 'package:flutter/material.dart';

class GroupAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GroupAppBar({super.key});

  static const String _titleText = 'Configurações';
  static const String _leadingText = 'Voltar';
  static const String _actionSaveText = 'Salvar';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        _titleText,
        style: TextStyle(
          color: AppColors.textBigTitle,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: const TextButton(onPressed: null, child: Text(_leadingText)),
      leadingWidth: 70,
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            _actionSaveText,
            style: TextStyle(
              color: AppColors.textBigTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
