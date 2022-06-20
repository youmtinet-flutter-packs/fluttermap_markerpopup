import 'package:flutter/rendering.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:fluttermap_markerpopup/src/markerdata.dart';

import 'popup_calculations.dart';

/// Calculates a [Matrix4] that will un-rotate the map container and translate
/// it such that the opposite point of the map container sits next to edge of
/// the [MarkerData] indicated by the popup snap, e.g.:
///   - left: Translates the map container so that it's right middle edge
///     touches the [MarkerData]'s left edge after the rotation is applied to the
///     marker (or no rotation if it is disabled).
///   - toCenterOfMarker: Translates the map container so that it's center
///     touches the [MarkerData]'s center.
abstract class PopupContainerTransform {
  static Matrix4 toLeftOfRotatedMarker(
    MapState mapState,
    MarkerData marker,
  ) {
    final markerPoint = _markerPoint(mapState, marker);

    return Matrix4.translationValues(
      PopupCalculations.mapRightToPointX(mapState, markerPoint),
      PopupCalculations.mapCenterToPointY(mapState, markerPoint),
      0.0,
    )
      ..rotateZ(-mapState.rotationRad)
      ..translate(
        PopupCalculations.leftOffsetX(marker),
        PopupCalculations.centerOffsetY(marker),
      );
  }

  static Matrix4 toLeftOfMarker(
    MapState mapState,
    MarkerData marker,
  ) {
    final markerPoint = _markerPoint(mapState, marker);

    return Matrix4.translationValues(
      PopupCalculations.mapRightToPointX(mapState, markerPoint) +
          PopupCalculations.centerOffsetX(marker),
      PopupCalculations.mapCenterToPointY(mapState, markerPoint) +
          PopupCalculations.centerOffsetY(marker),
      0.0,
    )
      ..rotateZ(-mapState.rotationRad)
      ..translate(
        -PopupCalculations.boundXAtRotation(marker, -mapState.rotationRad),
      );
  }

  static Matrix4 toTopOfRotatedMarker(
    MapState mapState,
    MarkerData marker,
  ) {
    final markerPoint = _markerPoint(mapState, marker);

    return Matrix4.translationValues(
      PopupCalculations.mapCenterToPointX(mapState, markerPoint),
      PopupCalculations.mapBottomToPointY(mapState, markerPoint),
      0.0,
    )
      ..rotateZ(-mapState.rotationRad)
      ..translate(
        PopupCalculations.centerOffsetX(marker),
        PopupCalculations.topOffsetY(marker),
      );
  }

  static Matrix4 toTopOfMarker(
    MapState mapState,
    MarkerData marker,
  ) {
    final markerPoint = _markerPoint(mapState, marker);

    return Matrix4.translationValues(
      PopupCalculations.mapCenterToPointX(mapState, markerPoint) +
          PopupCalculations.centerOffsetX(marker),
      PopupCalculations.mapBottomToPointY(mapState, markerPoint) +
          PopupCalculations.centerOffsetY(marker),
      0.0,
    )
      ..rotateZ(-mapState.rotationRad)
      ..translate(
        0.0,
        -PopupCalculations.boundYAtRotation(marker, -mapState.rotationRad),
      );
  }

  static Matrix4 toRightOfRotatedMarker(
    MapState mapState,
    MarkerData marker,
  ) {
    final markerPoint = _markerPoint(mapState, marker);

    return Matrix4.translationValues(
      PopupCalculations.mapLeftToPointX(mapState, markerPoint),
      PopupCalculations.mapCenterToPointY(mapState, markerPoint),
      0.0,
    )
      ..rotateZ(-mapState.rotationRad)
      ..translate(
        PopupCalculations.rightOffsetX(marker),
        PopupCalculations.centerOffsetY(marker),
      );
  }

  static Matrix4 toRightOfMarker(
    MapState mapState,
    MarkerData marker,
  ) {
    final markerPoint = _markerPoint(mapState, marker);

    return Matrix4.translationValues(
      PopupCalculations.mapLeftToPointX(mapState, markerPoint) +
          PopupCalculations.centerOffsetX(marker),
      PopupCalculations.mapCenterToPointY(mapState, markerPoint) +
          PopupCalculations.centerOffsetY(marker),
      0.0,
    )
      ..rotateZ(-mapState.rotationRad)
      ..translate(
        PopupCalculations.boundXAtRotation(marker, -mapState.rotationRad),
      );
  }

  static Matrix4 toBottomOfRotatedMarker(
    MapState mapState,
    MarkerData marker,
  ) {
    final markerPoint = _markerPoint(mapState, marker);

    return Matrix4.translationValues(
      PopupCalculations.mapCenterToPointX(mapState, markerPoint),
      PopupCalculations.mapTopToPointY(mapState, markerPoint),
      0.0,
    )
      ..rotateZ(-mapState.rotationRad)
      ..translate(
        PopupCalculations.centerOffsetX(marker),
        PopupCalculations.bottomOffsetY(marker),
      );
  }

  static Matrix4 toBottomOfMarker(
    MapState mapState,
    MarkerData marker,
  ) {
    final markerPoint = _markerPoint(mapState, marker);

    return Matrix4.translationValues(
      PopupCalculations.mapCenterToPointX(mapState, markerPoint) +
          PopupCalculations.centerOffsetX(marker),
      PopupCalculations.mapTopToPointY(mapState, markerPoint) +
          PopupCalculations.centerOffsetY(marker),
      0.0,
    )
      ..rotateZ(-mapState.rotationRad)
      ..translate(
        0.0,
        PopupCalculations.boundYAtRotation(marker, -mapState.rotationRad),
      );
  }

  static Matrix4 toCenterOfRotatedMarker(
    MapState mapState,
    MarkerData marker,
  ) {
    final markerPoint = _markerPoint(mapState, marker);

    return Matrix4.translationValues(
      PopupCalculations.mapCenterToPointX(mapState, markerPoint),
      PopupCalculations.mapCenterToPointY(mapState, markerPoint),
      0.0,
    )
      ..rotateZ(-mapState.rotationRad)
      ..translate(
        PopupCalculations.centerOffsetX(marker),
        PopupCalculations.centerOffsetY(marker),
      );
  }

  static Matrix4 toCenterOfMarker(
    MapState mapState,
    MarkerData marker,
  ) {
    final markerPoint = _markerPoint(mapState, marker);

    return Matrix4.translationValues(
      PopupCalculations.mapCenterToPointX(mapState, markerPoint) +
          PopupCalculations.centerOffsetX(marker),
      PopupCalculations.mapCenterToPointY(mapState, markerPoint) +
          PopupCalculations.centerOffsetY(marker),
      0.0,
    )..rotateZ(-mapState.rotationRad);
  }

  static CustomPoint<num> _markerPoint(MapState mapState, MarkerData marker) {
    return mapState
            .project(marker.marker.point)
            .multiplyBy(mapState.getZoomScale(mapState.zoom, mapState.zoom)) -
        mapState.getPixelOrigin();
  }
}
