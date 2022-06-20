import 'dart:async';
import 'dart:collection';

import 'package:flutter_map/plugin_api.dart';
import 'package:fluttermap_markerpopup/fluttermap_markerpopup.dart';
import 'package:fluttermap_markerpopup/src/popup_container/marker_with_key.dart';
import 'package:fluttermap_markerpopup/src/popup_event.dart';

import 'popup_controller.dart';

class PopupControllerImpl implements PopupController {
  StreamController<PopupEvent>? streamController;

  /// The [MarkerWithKey]ss for which a popup is currently showing if there is
  /// one. This is for internal use.
  final Set<MarkerWithKey> selectedMarkersWithKeys;

  PopupControllerImpl({List<MarkerData> initiallySelectedMarkers = const []})
      : selectedMarkersWithKeys = LinkedHashSet.from(
          initiallySelectedMarkers.map(
            (marker) => MarkerWithKey(marker),
          ),
        );

  @override
  List<MarkerData> get selectedMarkers =>
      selectedMarkersWithKeys.map((markerWithKey) => markerWithKey.marker).toList();

  @override
  void showPopupsAlsoFor(
    List<MarkerData> markers, {
    bool disableAnimation = false,
  }) {
    streamController?.add(PopupEvent.showAlsoFor(
      markers,
      disableAnimation: disableAnimation,
    ));
  }

  @override
  void showPopupsOnlyFor(
    List<MarkerData> markers, {
    bool disableAnimation = false,
  }) {
    streamController?.add(
      PopupEvent.showOnlyFor(markers, disableAnimation: disableAnimation),
    );
  }

  @override
  void hideAllPopups({bool disableAnimation = false}) {
    streamController?.add(
      PopupEvent.hideAll(disableAnimation: disableAnimation),
    );
  }

  @override
  void hidePopupsOnlyFor(
    List<MarkerData> markers, {
    bool disableAnimation = false,
  }) {
    streamController?.add(
      PopupEvent.hideOnlyFor(markers, disableAnimation: disableAnimation),
    );
  }

  @override
  void togglePopup(MarkerData marker, {bool disableAnimation = false}) {
    streamController?.add(PopupEvent.toggle(marker, disableAnimation: false));
  }
}
