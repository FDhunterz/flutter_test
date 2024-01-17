import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keuangan/material/select.dart';
import 'package:keuangan/model/file_manager.dart';
import 'package:path/path.dart';
import 'package:request_api_helper/global_env.dart';

Future<FileManager?> imagePicker() async {
  FileManager? data;
  await Select.single(
    fullScreen: false,
    title: 'Pilih Metode',
    context: ENV.navigatorKey.currentContext,
    data: [
      SelectData(
        title: 'Kamera',
        id: 'kamera',
      ),
      SelectData(
        title: 'Galeri',
        id: 'galeri',
      ),
    ],
  ).then((value) async {
    if (value?.id == 'kamera') {
      final image = ImagePicker();
      final d = await image.pickImage(source: ImageSource.camera, imageQuality: 60);
      if (d?.path != null) {
        final dd = await convert(d!);
        data = FileManager(path: dd);
      }
    } else if (value?.id == 'galeri') {
      final image = await FilePicker.platform.pickFiles(allowMultiple: false, allowedExtensions: ['jpg']);
      if (image?.paths.isNotEmpty ?? false) {
        data = FileManager(path: image!.paths.first);
      }
    }
  });
  return data;
}

convert(XFile d) async {
  final Uint8List imageBytes = await d.readAsBytes();
  Image image = decodeImage(imageBytes)!;
  final jpgBytes = encodeJpg(image);
  final newImagePath = '${withoutExtension(d.path)}.jpg';
  await File(newImagePath).writeAsBytes(jpgBytes);
  return newImagePath;
}
