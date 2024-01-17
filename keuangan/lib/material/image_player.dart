import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sql_query/viewer/part/button.dart';

import 'auto_model.dart';
import 'image_player_controller.dart';

class ImagePlayer extends StatelessWidget {
  final bool isBack;
  final bool helper;
  const ImagePlayer({Key? key, this.helper = true, this.isBack = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: StatefulBuilder(builder: (context, s) {
              return Fresher<ImageProvider?>(
                listener: ImagePlayerController.imagePreview,
                builder: (v) {
                  if (v == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return PhotoView(
                    scaleStateController: ImagePlayerController.control,
                    imageProvider: v,
                    // initialScale: MultiPlayerController.currentZoom,
                    onScaleEnd: (context, scale, controller) {
                      if (ImagePlayerController.control.scaleState == PhotoViewScaleState.zoomedOut) {
                        ImagePlayerController.control.reset();
                      }
                      ImagePlayerController.imagePreview.refresh((listener) => null);
                    },
                    maxScale: 2.0,
                  );
                },
              );
            }),
          ),
          helper
              ? Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Fresher<List<String>>(
                      listener: ImagePlayerController.listImages,
                      builder: (v) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: v.map<Widget>(
                              (e) {
                                return GestureDetector(
                                  onTap: () {
                                    ImagePlayerController.changeTo(e);
                                  },
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: ImagePlayerController.isNetwork
                                        ? CachedNetworkImage(
                                            imageUrl: e,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            File(e),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox(),
          // Positioned(
          //   top: 40,
          //   child: SizedBox(
          //     width: MediaQuery.of(context).size.width,
          //     child: TopNavigationBar(
          //       isBack: true,
          //       color: Colors.white,
          //       share: () {
          //         ImagePlayerController.share();
          //       },
          //     ),
          //   ),
          // )

          Positioned(
            left: 20,
            top: 30,
            child: NoSplashButton(
              onTap: () {
                Navigator.pop(context);
              },
              // height: MediaQuery.of(context).size.height,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
