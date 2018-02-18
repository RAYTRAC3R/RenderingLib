import 'dart:html';
import 'package:DollLibCorrect/RendererLib.dart';
import 'dart:async';

void main() {
    querySelector('#output').text = 'Your Dart app is running.';
    start();

}

Future<bool> start() async {
    await Loader.preloadManifest();

}
