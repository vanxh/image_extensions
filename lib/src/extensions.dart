import "dart:io";
import "package:image/image.dart";
import "functions.dart" as functions;

extension Encode on Image {
  /// Removes the alpha channel from this image.
  Image removeAlphaChannel() => functions.removeAlphaChannel(this);
}

extension Save on Image {
  /// Save the image as a PNG.
  void saveAsPNGSyncWithoutAlpha(String path) =>
      File(path).writeAsBytesSync(encodePng(removeAlphaChannel()));

  /// Save the image as a PNG.
  Future<void> saveAsPNG(String path) async =>
      await File(path).writeAsBytes(encodePng(removeAlphaChannel()));
}
