import '../fluttermap_markerpopup.dart';

/// Controls what happens when a MarkerData is tapped.
class MarkerTapBehavior {
  final Function(MarkerData marker, PopupController popupController)
      _onLongPress;

  /// Toggle the popup of the tapped marker and hide all other popups. This is
  /// the recommended behavior if you only want to show one popup at a time.
  MarkerTapBehavior.togglePopupAndHideRest()
      : _onLongPress = ((MarkerData marker, PopupController popupController) {
          if (popupController.selectedMarkers.contains(marker)) {
            popupController.hideAllPopups();
          } else {
            popupController.showPopupsOnlyFor([marker]);
          }
        });

  /// Toggle the popup of the tapped marker and leave all other visible popups
  /// as they are. This is the recommended behavior if you want to show multiple
  /// popups at once.
  MarkerTapBehavior.togglePopup()
      : _onLongPress = ((MarkerData marker, PopupController popupController) {
          popupController.togglePopup(marker);
        });

  /// Do nothing when tapping the marker. This is useful if you want to control
  /// popups exclusively with the [PopupController].
  MarkerTapBehavior.none(
      Function(MarkerData marker, PopupController popupController) onLongPress)
      : _onLongPress = ((_, __) {});

  /// Define your own custom behavior when tapping a marker.
  MarkerTapBehavior.custom(
      Function(MarkerData marker, PopupController popupController) onLongPress)
      : _onLongPress = onLongPress;

  void apply(MarkerData marker, PopupController popupController) =>
      _onLongPress(marker, popupController);
}
