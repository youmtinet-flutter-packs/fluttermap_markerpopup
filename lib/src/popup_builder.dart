import 'package:flutter/widgets.dart';
import 'package:fluttermap_markerpopup/src/markerdata.dart';

// In a separate file so it can be exported individually in extension_api.dart
typedef PopupBuilder = Widget Function(BuildContext, MarkerData);
