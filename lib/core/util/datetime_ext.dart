// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime? {
  String parseDateTime(BuildContext context) {
    if (this == null) return '-';

    final locale = Localizations.maybeLocaleOf(context) ?? const Locale('en', 'US');

    return DateFormat('dd MMMM yyyy', locale.toLanguageTag()).format(this!);
  }
}
