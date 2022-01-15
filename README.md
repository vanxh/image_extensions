# Image Extensions

A wrapper library for [image package](https://pub.dev/packages/image) with some extra functions.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
    image_extensions: any
```

then run in terminal

```
dart pub get
```

## Usage Example

```dart
import "package:image_extensions/image_extensions.dart";

void main() async {
  final Image? image = await loadImage(
      "https://avatars.githubusercontent.com/u/71810662?s=400&u=20d056ba55558adaa53e125e0bdca43a14e6073f&v=4");

  await copyResize(image!, width: 100, height: 100).saveAsPNG("final.png");
}
```

or use your prefferd text editor or IDE to install the plugin.

## Links

-   [Discord](https://discord.gg/fishstick)
-   [pub.dev](https://pub.dev/packages/image_extensions/)
-   [Documentation](https://pub.dev/documentation/image_extensions/latest/)

## License

Copyright 2021 Vanxh

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
