import 'package:flutter/material.dart';
import 'package:keuangan/material/auto_model.dart';

enum ScrollStatus { start, update, down, end, cancel, nothing }

class ScrollXController {
  Offset? current;
  Offset? lastOffset;
  bool isLoadingHold = false;
  double percentshow = 0.0;
  double overPercent = 0.0;
  double showIconAt = -50;
  double maxShowIconAt = -150;
  Fresh<bool> refresher = Fresh(false);
  ScrollController scrollController = ScrollController();
  ScrollStatus status = ScrollStatus.nothing;
  Function? refreshFunction;
  void Function()? listenerf;

  ScrollXController changeRefresh(Function? function) {
    scrollController.removeListener(listenerf!);
    scrollController.addListener(listenerf!);
    refreshFunction = function;
    return this;
  }

  ScrollXController() {
    listenerf = () {
      if (refreshFunction != null) {
        if (!isLoadingHold && status == ScrollStatus.end) {
          if (scrollController.offset <= showIconAt) {
            percentshow = (scrollController.offset - (showIconAt)) / maxShowIconAt;
            overPercent = percentshow;
            refresher.refresh((listener) => null);
            if (percentshow > 1) {
              percentshow = 1;
            }
          }
          if (scrollController.offset == 0) status = ScrollStatus.nothing;
        } else {
          overPercent = (scrollController.offset - (showIconAt)) / maxShowIconAt;
          refresher.refresh((listener) => null);
        }
      }
    };
    scrollController.addListener(listenerf!);
  }

  dispose() {
    scrollController.dispose();
    refresher.dispose();
  }
}

class ScrollX extends StatelessWidget {
  final ScrollXController controller;
  final Widget child;
  const ScrollX({Key? key, required this.controller, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Fresher<bool>(
      listener: controller.refresher,
      builder: (v) {
        return Stack(
          children: [
            GestureDetector(
              onPanStart: (details) {
                controller.status = ScrollStatus.start;
                controller.current = Offset(details.globalPosition.dx, details.globalPosition.dy);
              },
              // onPanDown: (details) {
              //   current = Offset(details.globalPosition.dx, details.globalPosition.dy);
              //   print(current);
              //   print('pan start');
              // },
              onPanUpdate: (details) {
                controller.status = ScrollStatus.update;
                controller.lastOffset = controller.current! - Offset(details.globalPosition.dx, details.globalPosition.dy);
                controller.current = Offset(details.globalPosition.dx, details.globalPosition.dy);
                // print(result);
                // print(controller!.scrollController.position.maxScrollExtent);
                controller.scrollController.jumpTo((controller.scrollController.offset + controller.lastOffset!.dy));
                if (controller.refreshFunction != null) {
                  if (controller.scrollController.offset < controller.showIconAt) {
                    if (controller.isLoadingHold) {
                    } else {
                      controller.percentshow = ((controller.scrollController.offset) - (controller.showIconAt)) / controller.maxShowIconAt;
                      controller.overPercent = controller.percentshow;
                      controller.refresher.refresh((listener) => null);
                      if (controller.percentshow > 1) {
                        controller.percentshow = 1;
                      }
                    }
                  }
                }

                controller.scrollController.position.hold(() {});
              },
              onPanEnd: (details) async {
                if (controller.scrollController.position.maxScrollExtent < controller.scrollController.offset) {
                  controller.scrollController.animateTo(controller.scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
                } else if (controller.scrollController.offset < 0) {
                  controller.scrollController.animateTo(0, duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
                }
                controller.lastOffset = null;
                if (controller.refreshFunction != null) {
                  if (controller.isLoadingHold) {
                  } else {
                    if (controller.percentshow == 1) {
                      controller.status = ScrollStatus.nothing;
                      controller.isLoadingHold = true;

                      await controller.refreshFunction!();
                      controller.percentshow = 0;
                      controller.refresher.refresh((listener) => null);
                      controller.isLoadingHold = false;
                    } else {
                      controller.status = ScrollStatus.end;
                    }
                  }
                }
              },
              onPanCancel: () {
                controller.status = ScrollStatus.cancel;
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.transparent,
                child: SingleChildScrollView(controller: controller.scrollController, physics: const NeverScrollableScrollPhysics(), child: child),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(0, 10 * controller.overPercent),
                      child: Opacity(
                        opacity: controller.percentshow,
                        child: controller.isLoadingHold
                            ? Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 12,
                                  )
                                ]),
                                child: const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator())),
                              )
                            : Column(
                                children: [
                                  Transform.rotate(
                                    angle: (-2 * 3.14159265359) * (1 - controller.percentshow),
                                    child: const Icon(Icons.refresh),
                                  ),
                                  controller.percentshow == 1 ? const Text('Lepaskan Jika Ingin Merefresh') : const SizedBox(),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
