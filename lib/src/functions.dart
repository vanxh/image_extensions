import "dart:io";
import "package:http/http.dart";
import "package:image/image.dart";

/// URL regex
final RegExp urlRegex = RegExp(r"^https?:\/\/.*(?:png|jpg|jpeg|gif)$");

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

/// Converts an image canvas to a byte array
List<int> toPNG(Image canvas) {
  for (int i = 0; i < canvas.data.length; i++) {
    canvas.data[i] = canvas.data[i] | 0xff000000;
  }

  return encodePng(canvas);
}
