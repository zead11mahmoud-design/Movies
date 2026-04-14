import 'package:fluttertoast/fluttertoast.dart';

import '../theme/app_theme.dart';

class UIUtils {
  static void showSuccessMessage(String message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: AppTheme.green,
    textColor: AppTheme.white,
    fontSize: 16.0,
  );

  static void showErrorMessage(String? message) => Fluttertoast.showToast(
    msg: message ?? 'Something went wrong',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: AppTheme.red,
    textColor: AppTheme.white,
    fontSize: 16.0,
  );
}
