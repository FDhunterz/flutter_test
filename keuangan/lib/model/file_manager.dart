import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keuangan/material/router/fade_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:request_api_helper/global_env.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../material/image_player.dart';
import '../../material/image_player_controller.dart';

class FileManager {
  String? url, path, thumbnailPath, thumbailUrl;
  bool isLoading = false;
  // static getDocument(FileManager fileManager) async {
  //   final d = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['doc', 'docx', 'zip', 'pdf'], allowMultiple: false);

  //   fileManager.path = d?.files.first.path;
  // }

  static List<FileData>? toFileData(List<FileManager> fileManager, requestName) {
    final List<FileData> fileData = [];
    for (int i = 0; i < fileManager.length; i++) {
      if (fileManager[i].path != null) {
        fileData.add(FileData(path: fileManager[i].path!, requestName: '$requestName[$i]'));
      }
    }
    if (fileData.isNotEmpty) return fileData;
    return null;
  }

  Future<String> toBase64() async {
    final file = await File(path!).readAsBytes();
    return base64Encode(file);
  }

  static Future<String> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    final paths = '${(await getApplicationDocumentsDirectory()).path}/$path';
    await File(paths).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    return paths;
  }

  extension(tipe) {
    if ((path?.split('.').last.contains('pdf') ?? false) || (path?.split('.').last.contains('docx') ?? false) || (path?.split('.').last.contains('zip') ?? false) || (path?.split('.').last.contains('doc') ?? false) || (url?.split('.').last.contains('pdf') ?? false) || (url?.split('.').last.contains('docx') ?? false) || (url?.split('.').last.contains('zip') ?? false) || (url?.split('.').last.contains('doc') ?? false)) {
      return tipe == 'dokumen';
    } else if (path?.split('.').last == 'png' || path?.split('.').last == 'jpg' || path?.split('.').last == 'jpeg' || path?.split('.').last == 'webp' || url?.split('.').last == 'png' || url?.split('.').last == 'jpg' || url?.split('.').last == 'jpeg' || url?.split('.').last == 'webp') {
      return tipe == 'image';
    } else if (path?.split('.').last == 'mp4' || url?.split('.').last == 'mp4') {
      return tipe == 'video';
    } else {
      return false;
    }
  }

  String getName() {
    return path?.split('/').last ?? url?.split('/').last ?? '';
  }

  Widget getView() {
    if (extension('dokumen')) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xffF6F7F9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      const ImageIcon(
                        AssetImage('assets/icon/document-text.png'),
                        color: Colors.black12,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        getName().split('.').last.toString(),
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 30,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffE0E5ED),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  getName(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else if (extension('image')) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xffF6F7F9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffE0E5ED),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  image: getImageProvider() == null ? null : DecorationImage(image: getImageProvider()!, fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 30,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffE0E5ED),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  getName(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    return const SizedBox();
  }

  getSize() {
    var file = File(path!);
    int bytes = file.lengthSync();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${((bytes / pow(1024, i)).toStringAsFixed(2))} ${suffixes[i]}';
  }

  getThumnail({BoxFit? boxFit}) {
    if (extension('dokumen')) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xffF6F7F9),
          borderRadius: BorderRadius.circular(16),
        ),
        // child: Column(
        //   children: [
        //     const Expanded(
        //       child: Center(
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 12),
        //           child: SizedBox(),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      );
    } else if (extension('image')) {
      return Container(
        color: const Color(0xffF6F7F9),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffE0E5ED),
                  image: getImageProvider() == null ? null : DecorationImage(image: getImageProvider()!, fit: boxFit ?? BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (extension('video')) {
      if (thumbnailPath != null || thumbailUrl != null) {
        return Container(
          color: const Color(0xffF6F7F9),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  // decoration: BoxDecoration(
                  //   color: const Color(0xffE0E5ED),
                  //   image: getImageProvider() == null ? null : DecorationImage(image: getImageProvider()!, fit: boxFit ?? BoxFit.cover),
                  // ),
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return const Column(
          children: [
            Expanded(
              child: SizedBox(
                child: Center(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      }
    }
    return const SizedBox();
  }

  open() async {
    if (isLoading) return;
    isLoading = true;
    if (path != null) {
      if (extension('dokumen')) {
      } else if (extension('image')) {
        isLoading = false;
        ImagePlayerController.previewLocal(path: path!, isAsset: false);

        Navigator.push(
          ENV.navigatorKey.currentContext!,
          fadeIn(
            page: const ImagePlayer(),
          ),
        ).then((value) => ImagePlayerController.dispose());
      } else if (extension('video')) {
        isLoading = false;
      } else {
        isLoading = false;
        // OpenFile.open(path);
      }
      isLoading = false;
    } else if (url != null) {
      if (extension('dokumen')) {
        // RequestApiHelper.sendRequest(
        //   type: Api.download,
        //   url: url,
        //   config: RequestApiHelperDownloadData(
        //     path: paths,
        //     nameFile: getName(),
        //     // header: {
        //     //   'Accept': 'application/json',
        //     //   'Authorization': token!,
        //     // },
        //     onSuccess: (d) {
        //       isLoading = false;
        //       d as RequestApiHelperDownloader;
        //       RequestApiHelper.to(
        //           route: fadeIn(
        //               page: PDFViewer(
        //         path: d.path,
        //       )));
        //     },
        //   ),
        // );
      } else if (extension('image')) {
        isLoading = false;
        await ImagePlayerController.previewUrl(url: url!);
        Navigator.push(
          ENV.navigatorKey.currentContext!,
          fadeIn(
            page: const ImagePlayer(),
          ),
        ).then((value) => ImagePlayerController.dispose());
      } else if (extension('video')) {
        isLoading = false;
      } else {
        isLoading = false;
        launchUrlString(url ?? '', mode: LaunchMode.externalApplication);
      }
    }
  }

  ImageProvider? getImageProvider() {
    if (extension('image')) {
      if (url != null) {
        return CachedNetworkImageProvider(url!);
      } else if (path != null) {
        return FileImage(File(path!));
      }
    } else {
      if (thumbnailPath != null) {
        return FileImage(File(path!));
      } else if (thumbailUrl != null) {
        return CachedNetworkImageProvider(thumbailUrl!);
      }
    }

    return null;
  }

  FileManager({
    this.url,
    this.path,
    this.thumbnailPath,
    this.thumbailUrl,
  });
}
