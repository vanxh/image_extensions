import "dart:io";
import "package:image/image.dart";
import "functions.dart";

extension Encode on Image {
  /// Encode the image as a PNG.
  List<int> conertToPNG() => toPNG(this);
}

extension Save on Image {
  /// Save the image as a PNG.
  void saveAsPNGSync(String path) => File(path).writeAsBytesSync(conertToPNG());

  /// Save the image as a PNG.
  Future<void> saveAsPNG(String path) async =>
      await File(path).writeAsBytes(conertToPNG());
}
