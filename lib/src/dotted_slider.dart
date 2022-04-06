import 'package:flutter/material.dart';


class SliderController {
  int selected;

  int dots;
  bool infinite;

  void Function()? listener;

  SliderController({
    required this.selected,
    required this.dots,
    
    this.infinite = false
  });

  void next() {
    jumpTo(selected+1);
  }

  void previuos() {
    jumpTo(selected-1);
  }

  void addDot([int n = 1]) {
    dots += n;
    _update();
  }

  void popDot([int n = 1]) {
    dots -= n;
    if (dots < 0) {
      dots = 0;
    }

    if (dots == 0) {
      selected = 0;
    } else if (selected >= dots) {
      selected = dots - 1;
    }

    _update();
  }

  void jumpTo(int index) {
    if (index < 0) {
      selected = 0;
    } else if (infinite) {
      selected = index % dots;
    } else if (index < dots) {
      selected = index;
    }

    _update();
  }

  void _update() {
    if (listener != null) {
      listener!();
    }
  }
}

class DottedSlider extends StatefulWidget {
  final double dotSize;
  final double dotScaleFactor;

  final double dotGap;

  final Color dotColor;
  final SliderController controller;

  final Duration animationDuration;

  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const DottedSlider({
    Key? key,

    required this.controller,

    this.dotColor = const Color(0xff333333),
    this.animationDuration = const Duration(milliseconds: 300),

    this.dotSize = 4,
    this.dotScaleFactor = 3.0,

    this.dotGap = 4,

    this.mainAxisAlignment,
    this.crossAxisAlignment,
  }) : super(key: key);

  @override
  createState() => _DottedSlider();
}

class _DottedSlider extends State<DottedSlider> {
  final List<Key> _keys = [];

  List<Widget> _buildDots() {
    var widgets = <Widget>[];
    for (int pos = 0; pos < widget.controller.dots; ++pos) {
      widgets.add(AnimatedContainer(
        key: _keys[pos],
        duration: widget.animationDuration,

        height: widget.dotSize,
        width: widget.controller.selected == pos ? widget.dotSize * widget.dotScaleFactor : widget.dotSize,

        decoration: BoxDecoration(
          color: widget.dotColor,
          borderRadius: BorderRadius.circular(2)
        ),
      ));

      widgets.add(SizedBox(width: widget.dotGap));
    }

    if (widgets.isNotEmpty) {
      widgets.removeLast();
    }

    return widgets;
  }

  void _initKeys() {
    for (int _ = _keys.length; _ < widget.controller.dots; ++_) {
      _keys.add(UniqueKey());
    }

    widget.controller.listener = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_keys.length < widget.controller.dots) {
      _initKeys();
    }

    return Row(
      children: _buildDots(),

      mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.center,
      crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.start,
    );
  }
}

