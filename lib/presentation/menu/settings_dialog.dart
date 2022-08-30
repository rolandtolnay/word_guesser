import 'package:flutter/material.dart';

import '../common/widgets/generic/common_dialog.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(Roland): Implement
    return CommonDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(onPressed: () {}, child: Text('Exit to Main Menu'))
        ],
      ),
    );
  }
}
