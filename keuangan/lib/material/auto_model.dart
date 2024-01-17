import 'package:flutter/cupertino.dart';

class Fresh<T> extends ChangeNotifier {
  late ValueNotifier<T> listener;

  T get value => listener.value;

  Fresh(T values) {
    listener = ValueNotifier<T>(values);
  }

  refresh(Function(ValueNotifier<T> listener) function) async {
    try {
      await function(listener);
      if (listener.hasListeners) {
        listener.notifyListeners();
      }
    } catch (_) {
      print('broken listener');
    }
  }
}

class Fresher<T> extends StatelessWidget {
  final Fresh<T> listener;
  final Function(T value) builder;
  const Fresher({Key? key, required this.listener, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(FresherController.listOfWidget.length);
    return ValueListenableBuilder<T>(
      valueListenable: listener.listener,
      builder: (_, v, __) {
        return builder(v);
      },
    );
  }
}
