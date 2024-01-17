import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keuangan/material/base_control.dart';
import 'package:keuangan/material/button.dart';
import 'package:keuangan/material/random_string.dart';

import 'form.dart';

SelectData? _selectedData;
MultiSelectData? _multiSelectedData;
SelectState _selectStates = SelectState();

class Select {
  static Future<SelectData?> singleV2({
    List<SelectData>? data,
    String? selectedId,
    required title,
    required context,
    SelectStyle? style,
    bool? withSearch = false,
    bool onlySelect = false,
    double? fontSize,
    bool isFull = false,
    bool fullScreen = true,
  }) async {
    style ??= SelectStyle();
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    await Future.delayed(Duration.zero, () async {
      return showModalBottomSheet<void>(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          if (_selectStates.context != context) {
            _selectStates.offset = 0;
          }
          _selectStates.context = context;
          return SelectBaseV2(
            fontSize: fontSize,
            withSearch: withSearch,
            data: data ?? [],
            selectedid: selectedId,
            title: title,
            style: style!,
            isFull: isFull,
            onlySelect: onlySelect,
          );
        },
      );
    });
    return _selectedData;
  }

  static Future<SelectData?> single({
    List<SelectData>? data,
    String? selectedId,
    required title,
    required context,
    SelectStyle? style,
    bool? withSearch = false,
    bool onlySelect = false,
    double? fontSize,
    bool isFull = false,
    bool fullScreen = true,
    double? offset,
    bool addIfEmpty = false,
  }) async {
    style ??= SelectStyle();
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    await Future.delayed(Duration.zero, () async {
      return showModalBottomSheet<void>(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) => SelectBase(
          fontSize: fontSize,
          withSearch: withSearch,
          data: data ?? [],
          selectedid: selectedId,
          title: title,
          style: style!,
          isFull: isFull,
          onlySelect: onlySelect,
          fullScreen: fullScreen,
          offset: offset,
          addIfEmpty: addIfEmpty,
        ),
      );
    });
    return _selectedData;
  }

  static Future<MultiSelectData?> multi({List<SelectData>? data, List<String>? selectedId, required title, required context, SelectStyle? style}) async {
    style ??= SelectStyle();
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    await Future.delayed(Duration.zero, () async {
      return showModalBottomSheet<void>(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) => MultiSelectBase(
          data: data ?? [],
          selectedid: selectedId,
          title: title,
          style: style!,
        ),
      );
    });
    return _multiSelectedData;
  }
}

class SelectBase extends StatefulWidget {
  final List<SelectData>? data;
  final String? selectedid;
  final String title;
  final SelectStyle style;
  final bool? withSearch;
  final bool onlySelect;
  final double? fontSize;
  final double? offset;
  final bool isFull;
  final bool fullScreen;
  final bool addIfEmpty;
  const SelectBase({
    Key? key,
    this.data,
    this.selectedid,
    required this.title,
    required this.style,
    this.withSearch = true,
    this.onlySelect = false,
    this.fontSize,
    this.isFull = false,
    this.fullScreen = true,
    this.offset,
    required this.addIfEmpty,
  }) : super(key: key);

  static getSelectedData() {
    return _selectedData;
  }

  @override
  SelectBased createState() => SelectBased();
}

class SelectBased extends State<SelectBase> {
  final _c = ScrollController();
  final _searching = MaterialXFormController(
      prefix: const Padding(
    padding: EdgeInsets.only(right: 6),
    child: Icon(Icons.search),
  ));

  selected(SelectData selectedData) {
    _selectedData = selectedData;
    Navigator.pop(context);
  }

  current(id) {
    _selectedData = null;
    if (id != null && id != '') {
      for (SelectData i in widget.data ?? []) {
        if (i.id == id) {
          _selectedData = i;
        }
      }
    }

    if (widget.data!.where((SelectData value) => value.title!.toUpperCase().contains(_searching.controller!.text.toUpperCase())).isEmpty && widget.addIfEmpty) {
      _searching.focusNode?.requestFocus();
    }
  }

  @override
  void initState() {
    super.initState();
    current(widget.selectedid);
    if (widget.offset != null) {
      Future.delayed(Duration.zero, () {
        _c.jumpTo(widget.offset!);
      });
    }
  }

  @override
  void dispose() {
    _searching.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: widget.isFull ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height * 0.9,
          ),
          child: Container(
            decoration: BoxDecoration(color: widget.style.backgroundColor ?? theme.scaffoldBackgroundColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: widget.fullScreen ? MainAxisSize.max : MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                    indent: MediaQuery.of(context).size.width * 0.35,
                    endIndent: MediaQuery.of(context).size.width * 0.35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Text(
                      '${widget.title} ',
                      style: TextStyle(
                        fontSize: widget.fontSize ?? 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  widget.withSearch!
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                              child: MaterialXForm(
                                controller: _searching,
                                centerTextField: false,
                                hintText: 'Pencarian...',
                                onChanged: (val) {
                                  setState(() {});
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )
                      : const SizedBox(),
                  widget.fullScreen
                      ? widget.data!.where((SelectData value) => value.title!.toUpperCase().contains(_searching.controller!.text.toUpperCase())).isEmpty && _searching.controller!.text != '' && widget.addIfEmpty
                          ? NoSplashButton(
                              onTap: () {
                                selected(
                                  SelectData(
                                    id: getRandomString(20),
                                    title: _searching.controller!.text,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Icons.add,
                                            size: 30,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Tambah data baru ',
                                                  style: theme.textTheme.bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                controller: _c,
                                shrinkWrap: true,
                                itemCount: widget.data!.where((SelectData value) => value.title!.toUpperCase().contains(_searching.controller!.text.toUpperCase())).length,
                                itemBuilder: (c, i) {
                                  final base = widget.data!.where((SelectData value) => value.title!.toUpperCase().contains(_searching.controller!.text.toUpperCase())).toList();
                                  final value = base[i];
                                  return value.customview != null
                                      ? NoSplashButton(
                                          onTap: () {
                                            selected(value.apply(offset: _c.offset));
                                          },
                                          child: value.customview!,
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(bottom: i == base.length - 1 ? 12 : 0),
                                          child: ListTile(
                                            tileColor: widget.selectedid == value.id ? widget.style.selectedBackgroundTextColor ?? Colors.transparent : Colors.transparent,
                                            leading: widget.onlySelect
                                                ? null
                                                : Icon(
                                                    Icons.check,
                                                    color: widget.selectedid == value.id! ? widget.style.selectedTextColor ?? (theme.textTheme.bodyMedium != null ? theme.textTheme.bodyMedium!.color : Colors.green) : Colors.transparent,
                                                  ),
                                            title: Row(
                                              children: [
                                                value.assetImage != null
                                                    ? Padding(
                                                        padding: const EdgeInsets.only(right: 12.0),
                                                        child: Image.asset(
                                                          value.assetImage!,
                                                          height: 40,
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                Expanded(
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: '${value.title!} ',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: widget.selectedid == value.id ? widget.style.selectedTextColor ?? (theme.textTheme.bodyMedium != null ? theme.textTheme.bodyMedium!.color : Colors.green) : theme.textTheme.bodyMedium!.color,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: value.titleBold ?? '',
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              selected(value.apply(offset: _c.offset));
                                            },
                                          ),
                                        );
                                },
                              ),
                            )
                      : widget.data!.where((SelectData value) => value.title!.toUpperCase().contains(_searching.controller!.text.toUpperCase())).isEmpty && _searching.controller!.text != '' && widget.addIfEmpty
                          ? Expanded(
                              child: NoSplashButton(
                                onTap: () {
                                  selected(
                                    SelectData(
                                      id: getRandomString(20),
                                      title: _searching.controller!.text,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 8.0),
                                            child: Icon(
                                              Icons.add,
                                              size: 30,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Tambah data baru ',
                                                    style: theme.textTheme.bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Flexible(
                              child: ListView.builder(
                                shrinkWrap: true,
                                controller: _c,
                                itemCount: widget.data!.where((SelectData value) => value.title!.toUpperCase().contains(_searching.controller!.text.toUpperCase())).length,
                                itemBuilder: (c, i) {
                                  final value = widget.data!.where((SelectData value) => value.title!.toUpperCase().contains(_searching.controller!.text.toUpperCase())).toList()[i];
                                  return value.customview != null
                                      ? NoSplashButton(
                                          onTap: () {
                                            selected(value.apply(offset: _c.offset));
                                          },
                                          child: value.customview!,
                                        )
                                      : ListTile(
                                          tileColor: widget.selectedid == value.id ? widget.style.selectedBackgroundTextColor ?? Colors.transparent : Colors.transparent,
                                          title: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: widget.selectedid == value.id! ? const Color(0xffE3E8F3) : null,
                                              border: widget.selectedid == value.id! ? Border.all(width: 1, color: const Color(0xff8CA0CC)) : null,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              children: [
                                                value.assetImage != null
                                                    ? Padding(
                                                        padding: const EdgeInsets.only(right: 12.0),
                                                        child: Image.asset(
                                                          value.assetImage!,
                                                          height: 40,
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                Expanded(
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: '${value.title} ',
                                                          style: theme.textTheme.bodyMedium,
                                                        ),
                                                        TextSpan(
                                                          text: value.titleBold ?? '',
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            selected(value.apply(offset: _c.offset));
                                          },
                                        );
                                },
                              ),
                            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MultiSelectBase extends StatefulWidget {
  final List<SelectData>? data;
  final List<String>? selectedid;
  final String title;
  final SelectStyle style;
  const MultiSelectBase({
    Key? key,
    this.data,
    this.selectedid,
    required this.title,
    required this.style,
  }) : super(key: key);

  static getSelectedData() {
    return _selectedData;
  }

  @override
  MultiSelectBased createState() => MultiSelectBased();
}

class MultiSelectBased extends State<MultiSelectBase> {
  List<ModelMultiSelect> _parseList = [];
  final List<String> _id = [], _name = [];
  List<ModelMultiSelect> _filterList = [];
  Timer? delay;

  selected(name, id, active) {
    bool activated = false;
    if (!active) {
      _id.add(id);
      _name.add(name);
      activated = true;
    } else {
      _id.remove(id);
      _name.remove(name);
      activated = false;
    }

    for (var i in _parseList) {
      if (i.id == id) {
        i.active = activated;
      }
    }

    setState(() {});
  }

  parse() {
    List<String> selectedId = widget.selectedid ?? [];
    _parseList = [];

    if (widget.data != null) {
      if (widget.data is List) {
        for (SelectData i in widget.data ?? []) {
          bool havevalue = false;
          for (String j in selectedId) {
            if (i.id == j) {
              _id.add(i.id!);
              _name.add(i.title!);
              havevalue = true;
              break;
            }
          }
          _parseList.add(ModelMultiSelect(
            active: havevalue,
            id: i.id,
            name: i.title,
          ));
        }
        _filterList = _parseList;
      }
    }
  }

  @override
  void initState() {
    _multiSelectedData = null;
    _parseList.clear();
    _id.clear();
    _name.clear();
    super.initState();
    parse();
  }

  @override
  Widget build(BuildContext context) {
    return BaseControl(
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -2),
                    color: const Color(0xff00A2E9).withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Color(0xff828282),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text(
                        '${widget.title} ',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: MaterialXForm(
                        controller: MaterialXFormController(),
                        hintText: 'Pencarian...',
                        onChanged: (val) {
                          if (delay != null) {
                            delay!.cancel();
                          }
                          delay = Timer(
                            const Duration(milliseconds: 400),
                            () {
                              _parseList = _filterList.where((e) => e.name!.toUpperCase().contains(val.toUpperCase())).toList();
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _parseList.length,
                        itemBuilder: (context, index) {
                          var value = _parseList[index];
                          return ListTile(
                            leading: Icon(
                              Icons.check,
                              color: value.active == true ? Theme.of(context).primaryColor : Colors.transparent,
                            ),
                            title: Text(
                              value.name ?? '',
                              style: TextStyle(color: value.active == true ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium?.color),
                            ),
                            onTap: () {
                              selected(value.name ?? '', value.id, value.active);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                      child: MaterialXButton(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        title: 'Pilih',
                        onTap: () {
                          _multiSelectedData = MultiSelectData(
                            id: _id,
                            title: _name,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectBaseV2 extends StatefulWidget {
  final List<SelectData>? data;
  final String? selectedid;
  final String title;
  final SelectStyle style;
  final bool? withSearch;
  final bool onlySelect;
  final double? fontSize;
  final bool isFull;
  const SelectBaseV2({
    Key? key,
    this.data,
    this.selectedid,
    required this.title,
    required this.style,
    this.withSearch = true,
    this.onlySelect = false,
    this.fontSize,
    this.isFull = false,
  }) : super(key: key);

  static getSelectedData() {
    return _selectedData;
  }

  @override
  State<SelectBaseV2> createState() => _SelectBaseV2();
}

class _SelectBaseV2 extends State<SelectBaseV2> {
  ScrollController scroll = ScrollController();
  final _searching = MaterialXFormController(
      prefix: const Padding(
    padding: EdgeInsets.only(right: 6),
    child: Icon(Icons.search),
  ));

  selected(SelectData selectedData) {
    _selectedData = selectedData;
    Navigator.pop(context);
  }

  current(id) {
    _selectedData = null;
    if (id != null && id != '') {
      for (SelectData i in widget.data ?? []) {
        if (i.id == id) {
          _selectedData = i;
        }
      }
    }
    if (_selectedData != null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        try {
          scroll.jumpTo(_selectStates.offset);
        } catch (_) {}
      });
    }
  }

  @override
  void initState() {
    super.initState();
    current(widget.selectedid);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: widget.isFull ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height * 0.9,
          ),
          child: Container(
            decoration: BoxDecoration(color: widget.style.backgroundColor ?? theme.scaffoldBackgroundColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                    indent: MediaQuery.of(context).size.width * 0.35,
                    endIndent: MediaQuery.of(context).size.width * 0.35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Text(
                      '${widget.title} ',
                      style: TextStyle(
                        fontSize: widget.fontSize ?? 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  widget.withSearch!
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              child: MaterialXForm(
                                controller: _searching,
                                hintText: 'Pencarian...',
                                onChanged: (val) {
                                  setState(() {});
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )
                      : const SizedBox(),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.data!.where((SelectData value) => value.title!.toUpperCase().contains(_searching.controller!.text.toUpperCase())).length,
                      itemBuilder: (c, i) {
                        final value = widget.data!.where((SelectData value) => value.title!.toUpperCase().contains(_searching.controller!.text.toUpperCase())).toList()[i];
                        return InkWell(
                          onTap: () => selected(value),
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  value.assetImage != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(right: 12.0),
                                          child: Image.asset(
                                            value.assetImage!,
                                            height: value.imageSize ?? 40,
                                          ),
                                        )
                                      : const SizedBox(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.title ?? '',
                                        style: Theme.of(context).textTheme.labelSmall?.apply(color: _selectedData?.id == value.id ? Colors.blue : null),
                                        maxLines: 2,
                                      ),
                                      value.subtitle == null
                                          ? const SizedBox()
                                          : Text(
                                              value.subtitle ?? '',
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectResult {
  final TextEditingController name = TextEditingController();
  String? id;
}

class SelectData<T> {
  final Map<String, dynamic>? objectData;
  final List<T>? listData;
  final String? title;
  final String? titleBold;
  final String? id;
  final dynamic data;
  final String? assetImage;
  final Widget? customview;
  final String? subtitle;
  final double? imageSize;
  double? offset;

  SelectData apply({offset}) {
    this.offset = offset;
    return this;
  }

  T parse<T>() {
    return data as T;
  }

  SelectData({this.id, this.listData, this.objectData, this.title, this.data, this.subtitle, this.assetImage, this.titleBold, this.offset, this.imageSize, this.customview});
}

class SelectState {
  double offset;
  BuildContext? context;

  SelectState({this.context, this.offset = 0});
}

class SelectStyle {
  Color? backgroundColor,

      /// default Theme.of(context).textTheme.bodyMedium || Colors.green
      selectedTextColor,
      // default Colors.Transparent
      selectedBackgroundTextColor;
  SelectStyle({this.backgroundColor, this.selectedBackgroundTextColor, this.selectedTextColor});
}

class MultiSelectData {
  List<String>? title;
  List<String>? id;
  List<Map<String, dynamic>>? objectData;
  List<List>? listData;

  MultiSelectData({this.id, this.listData, this.objectData, this.title});
}

class ModelMultiSelect {
  String? id, name;
  bool? active;

  ModelMultiSelect({this.id, this.name, this.active});
}
