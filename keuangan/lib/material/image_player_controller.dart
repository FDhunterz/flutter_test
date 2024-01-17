import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

import 'auto_model.dart';

class ImagePlayerController {
  static PhotoViewScaleStateController control = PhotoViewScaleStateController();
  static Fresh<List<String>> listImages = Fresh([]);
  static Fresh<ImageProvider?> imagePreview = Fresh(null);
  static String? fileActive;
  static bool isNetwork = false;
  static bool isAsset = false;

  // static share() {
  //   if (isNetwork) {
  //     Share.share(fileActive!);
  //   } else {
  //     Share.shareFiles([fileActive!]);
  //   }
  // }

  static previewUrl({required String url, List<String>? listImage}) async {
    isNetwork = true;
    fileActive = url;
    control = PhotoViewScaleStateController();
    imagePreview.refresh((listener) => listener.value = CachedNetworkImageProvider(url));
    for (var i in listImage ?? []) {
      listImages.value.add(i);
    }
    listImages.refresh((listener) => null);
  }

  static previewLocal({required String path, List<String>? listImage, isAsset}) async {
    isNetwork = false;
    fileActive = path;
    control = PhotoViewScaleStateController();
    if (isAsset) {
      imagePreview.refresh((listener) async => listener.value = MemoryImage((await rootBundle.load(path)).buffer.asUint8List()));
    } else {
      imagePreview.refresh((listener) => listener.value = FileImage(File(path)));
    }
    for (var i in listImage ?? []) {
      listImages.value.add(i);
    }
    listImages.refresh((listener) => null);
  }

  static changeTo(url) {
    fileActive = url;
    if (isNetwork) {
      imagePreview.refresh((listener) => listener.value = CachedNetworkImageProvider(url));
    } else {
      imagePreview.refresh((listener) => listener.value = FileImage(File(url)));
    }
  }

  static dispose() {
    Future.delayed(const Duration(milliseconds: 600), () {
      listImages.value.clear();
      imagePreview.listener.value = null;
      control.dispose();
    });
  }

  static fastDispose() {
    listImages.value.clear();
    imagePreview.listener.value = null;
    control.dispose();
  }
}
