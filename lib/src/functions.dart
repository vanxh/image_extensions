import "dart:io";
import "package:http/http.dart";
import "package:image/image.dart";

/// URL regex
final RegExp urlRegex = RegExp(
    r"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");

/// load an image from network.
/// [url] is the image url.
Future<Image?> loadNetworkImage(String url) async =>
    decodeImage((await get(Uri.parse(url))).bodyBytes);

/// load image from a local file or network.
/// [path] can be a local file path or a network url.
/// returns null if it can not load the image.
Future<Image?> loadImage(String path) async {
  try {
    if (urlRegex.hasMatch(path)) {
      return await loadNetworkImage(path);
    } else {
      return decodeImage(await File(path).readAsBytes());
    }
  } catch (e) {
    return null;
  }
}

/// draw canvas
Image drawCanvas(int x, int y) => Image(x, y);

/// Removes the alpha channel on [dst].
///
/// Equivalent to
/// ```dart
/// Image.fromBytes(
///   canvas.width,
///   canvas.height,
///   canvas.getBytes(format: Format.rgb),
///   format: Format.rgb,
/// );
/// ```
Image removeAlphaChannel(Image dst) {
  for (int i = 0; i < dst.data.length; i++) {
    dst.data[i] = dst.data[i] | 0xff000000;
  }

  Image.fromBytes(
    dst.width,
    dst.height,
    dst.getBytes(format: Format.rgb),
    format: Format.rgb,
  );

  return dst;
}
