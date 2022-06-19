import 'package:flutter/widgets.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:fluttermap_markerpopup/src/layout/popup_container_translate.dart';

import 'popup_layout.dart';

abstract class SnapToMarkerLayout {
  static PopupLayout left(MapState mapState, Marker marker, bool markerRotate) {
    return PopupLayout(
      contentAlignment: Alignment.centerRight,
      rotationAlignment: Alignment.centerRight,
      transformationMatrix: marker.rotate ?? markerRotate
          ? PopupContainerTransform.toLeftOfRotatedMarker(mapState, marker)
          : PopupContainerTransform.toLeftOfMarker(mapState, marker),
    );
  }

  static PopupLayout top(MapState mapState, Marker marker, bool markerRotate) {
    return PopupLayout(
      contentAlignment: Alignment.bottomCenter,
      rotationAlignment: Alignment.bottomCenter,
      transformationMatrix: marker.rotate ?? markerRotate
          ? PopupContainerTransform.toTopOfRotatedMarker(mapState, marker)
          : PopupContainerTransform.toTopOfMarker(mapState, marker),
    );
  }

  static PopupLayout right(MapState mapState, Marker marker, bool markerRotate) {
    return PopupLayout(
      contentAlignment: Alignment.centerLeft,
      rotationAlignment: Alignment.centerLeft,
      transformationMatrix: marker.rotate ?? markerRotate
          ? PopupContainerTransform.toRightOfRotatedMarker(mapState, marker)
          : PopupContainerTransform.toRightOfMarker(mapState, marker),
    );
  }

  static PopupLayout bottom(MapState mapState, Marker marker, bool markerRotate) {
    return PopupLayout(
      contentAlignment: Alignment.topCenter,
      rotationAlignment: Alignment.topCenter,
      transformationMatrix: marker.rotate ?? markerRotate
          ? PopupContainerTransform.toBottomOfRotatedMarker(mapState, marker)
          : PopupContainerTransform.toBottomOfMarker(mapState, marker),
    );
  }

  static PopupLayout center(MapState mapState, Marker marker, bool markerRotate) {
    return PopupLayout(
      contentAlignment: Alignment.center,
      rotationAlignment: Alignment.center,
      transformationMatrix: marker.rotate ?? markerRotate
          ? PopupContainerTransform.toCenterOfRotatedMarker(mapState, marker)
          : PopupContainerTransform.toCenterOfMarker(mapState, marker),
    );
  }
}
