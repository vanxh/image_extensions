import "dart:io";
import "dart:math";
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
    if (path.startsWith("https://") || path.startsWith("http://")) {
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

/// Fills an arbitrary polygon with [col] in [dst].
///
/// The vertices of this polygon are given by [vertices], where each element should be a list
/// containing a pair of x-y coordinates.
Image fillShape(Image dst, List<List<int>> vertices, int col) {
  if (vertices.first[0] != vertices.last[0] ||
      vertices.first[1] != vertices.last[1]) {
    vertices.add(vertices.first);
  }

  bool isInsideShape(int x, int y) {
    bool inside = false;

    for (int i = 0, j = vertices.length - 1; i < vertices.length; j = i++) {
      if ((vertices[i][1] > y) != (vertices[j][1] > y) &&
          x <
              (vertices[j][0] - vertices[i][0]) *
                      (y - vertices[i][1]) /
                      (vertices[j][1] - vertices[i][1]) +
                  vertices[i][0]) {
        inside = !inside;
      }
    }
    return inside;
  }

  int minX = vertices.first[0];
  int maxX = vertices.first[0];
  int minY = vertices.first[1];
  int maxY = vertices.first[1];

  for (final vertex in vertices) {
    minX = min(minX, vertex[0]);
    maxX = max(maxX, vertex[0]);
    minY = min(minY, vertex[1]);
    maxY = max(maxY, vertex[1]);
  }

  for (int x = minX; x < maxX; x++) {
    for (int y = minY; y < maxY; y++) {
      if (isInsideShape(x, y)) {
        dst.setPixelSafe(x, y, alphaBlendColors(dst.getPixelSafe(x, y), col));
      }
    }
  }

  return dst;
}
