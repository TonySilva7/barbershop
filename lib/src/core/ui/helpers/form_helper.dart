import 'package:flutter/widgets.dart';

// sealed class FormHelper {
//   static void unFocus(BuildContext context) => FocusScope.of(context).unfocus();
// }

extension UnFocusExtension on BuildContext {
  void unFocus() => FocusScope.of(this).unfocus();
}
