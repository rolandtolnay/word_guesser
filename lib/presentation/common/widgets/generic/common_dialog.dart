import 'package:flutter/material.dart';

import 'max_width_container.dart';

class CommonDialog extends StatelessWidget {
  final Widget? child;

  const CommonDialog({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return MaxWidthContainer(
      maxWidth: kPhoneWidth,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: child,
      ),
    );
  }
}
