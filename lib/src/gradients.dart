import "dart:math";

import "package:image_extensions/image_extensions.dart";

/// Fills a rectangular area delimited by [x1], [y1], [x2] and [y2] with a radial gradient blending
/// from [c1] to [c2] centered at ([cx], [cy])
Image drawRadialGradient(
    Image destination, int x1, int y1, int x2, int y2, int cx, int cy, int c1, int c2,
    [double scale = 1]) {
  x1 = x1.clamp(0, destination.width);
  x2 = x2.clamp(x1, destination.width);
  y1 = y1.clamp(0, destination.height);
  y2 = y2.clamp(y1, destination.height);

  int distanceSquared(int x1, int y1, int x2, int y2) =>
      (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);

  List<int> distances = [];

  if (cx > x1 && cx < x2 && cy > y1 && cy < y2) {
    distances.add(0);
  } else if (cx > x1 && cx < x2) {
    if (cy < y1) {
      distances.add(pow(y1 - cy, 2).floor());
    } else {
      distances.add(pow(cy - y2, 2).floor());
    }
  } else if (cy > y1 && cy < y2) {
    if (cx < x1) {
      distances.add(pow(x1 - cx, 2).floor());
    } else {
      distances.add(pow(cx - x2, 2).floor());
    }
  }

  distances.add(distanceSquared(x1, y1, cx, cy));
  distances.add(distanceSquared(x1, y2, cx, cy));
  distances.add(distanceSquared(x2, y1, cx, cy));
  distances.add(distanceSquared(x2, y2, cx, cy));

  int minDistance = distances.reduce(min);
  int maxDistance = distances.reduce(max);

  for (int x = x1; x < x2; x++) {
    for (int y = y1; y < y2; y++) {
      int distance = distanceSquared(x, y, cx, cy);

      num interpolation = pow((distance - minDistance) / (maxDistance - minDistance), scale);

      int fraction = (interpolation * 255).floor();

      destination.setPixelSafe(x, y, alphaBlendColors(c1, c2, fraction));
    }
  }

  return destination;
}

/// Fills a rectangular area delimited by [x1], [y1], [x2] and [y2] with a liner gradient blending
/// from [c1] to [c2] along the X-axis.
Image drawLinearGradient(Image destination, int x1, int y1, int x2, int y2, int c1, int c2) {
  x1 = x1.clamp(0, destination.width);
  x2 = x2.clamp(x1, destination.width);
  y1 = y1.clamp(0, destination.height);
  y2 = y2.clamp(y1, destination.height);

  for (int x = x1; x < x2; x++) {
    int col = alphaBlendColors(c1, c2, ((x - x1) / (x2 - x1) * 255).floor());

    for (int y = y1; y < y2; y++) {
      destination.setPixelSafe(x, y, col);
    }
  }

  return destination;
}
