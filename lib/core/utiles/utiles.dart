import 'dart:io';

import 'package:flutter/material.dart';

class Utiles {
  static ThemeMode appMode = ThemeMode.light;

  static String baseUrl = "https://imdb-api.tprojects.workers.dev/";
  static void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
