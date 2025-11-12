import 'dart:async';

import 'package:extra_hittest_area/extra_hittest_area.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/customize/widget/Compare_Slider_Rect_Clipper.dart';

/// The result after a drag operation ends, containing the slider's value
/// before and after the drag.
class CompareSliderDragEndResult {

  final double valueDragBefore;
  final double valueDragAfter;

  CompareSliderDragEndResult(
      {
          required this.valueDragBefore,
          required this.valueDragAfter,
      }
  );

}

/// A slider that allows users to compare two widgets.
class CompareSlider extends StatefulWidget {

  /// Defines the drag behavior (defaults to full area dragging).
  /// - false: Enables dragging across the entire component area.
  /// - true: Restricts dragging to the slider thumb only.
  final bool dragOnlyOnSlider;

  /// The current value of the slider.
  final double value;

  /// The widget displayed on the 'before' side of the slider.
  final Widget before;

  /// The widget displayed on the 'after' side of the slider.
  final Widget after;

  /// The slider thumb widget.
  final Widget thumb;

  /// The thickness of the slider.
  final double thickness;

  /// Callback invoked when the slider's value changes.
  final ValueChanged<double> onValueChanged;

  /// Callback invoked when the slider thumb is touched.
  ///
  /// This callback is triggered only when dragging the slider thumb if
  /// [dragOnlyOnSlider] is true; otherwise, it's triggered when dragging
  /// anywhere on the component.
  final VoidCallback ? onSliderThumbTouchBegin;

  /// Callback invoked when the slider thumb touch ends.
  ///
  /// This callback is triggered only when the slider thumb drag ends if
  /// [dragOnlyOnSlider] is true; otherwise, it's triggered when dragging
  /// anywhere on the component ends.
  final VoidCallback ? onSliderThumbTouchEnd;

  /// Callback invoked when the slider drag operation ends.
  final Function(CompareSliderDragEndResult) ? onSliderDragEnd;

  /// Expands the hit-test area for the slider thumb (effective when
  /// [dragOnlyOnSlider] is true).
  final EdgeInsets extraHitTestArea;

  /// The color of the expanded hit-test area (effective when [dragOnlyOnSlider]
  /// is true, for debugging purposes).
  final Color ? debugHitTestAreaColor;

  const CompareSlider(
      {
          super.key,
          this.dragOnlyOnSlider = false,
          required this.value,
          required this.before,
          required this.after,
          required this.thickness,
          required this.thumb,
          required this.onValueChanged,
          this.onSliderThumbTouchBegin,
          this.onSliderThumbTouchEnd,
          this.onSliderDragEnd,
          this.extraHitTestArea = EdgeInsets.zero,
          this.debugHitTestAreaColor,
      }
  );

  @override
  State<CompareSlider> createState() => _CompareSliderState();

}

class _CompareSliderState extends State<CompareSlider> {

  /// The current value of the slider.
  double get value => widget.value;

  /// The slider's value before a drag operation began.
  late double valueDragBefore = value;

  /// The slider's value after a drag operation ended.
  late double valueDragAfter = value;

  /// Whether dragging is restricted to the slider thumb only.
  bool get dragOnlyOnSlider => widget.dragOnlyOnSlider;

  /// The height of the slider's container.
  double sliderContainerHeight = 0;

  /// The width of the slider's container.
  double sliderContainerWidth = 0;

  /// The thickness of the slider.
  double get sliderThickness => widget.thickness;

  /// The alignment of the slider within its stack.
  AlignmentDirectional sliderStackAlignment = AlignmentDirectional.centerStart;

  /// The horizontal offset of the slider.
  double get offsetX => value * (sliderContainerWidth - sliderThickness);

  // Tracks currently active pointers.
  final Set<int> activePointers = {};

  // Timer used for debouncing touch events.
  Timer ? delayTimer;

  // Stores information of the first pointer down event.
  PointerDownEvent ? firstPointerEvent;

  // The delay duration in milliseconds for processing touch events.
  static const int delayMilliseconds = 10;

  /// The width of the widget's render box.
  double widgetWidth = 0;

  /// Indicates if the current touch is on the slider thumb.
  ///
  /// This is true only when the slider thumb is being dragged if
  /// [dragOnlyOnSlider] is true; otherwise, it is true when dragging anywhere on the component.
  bool isOnSliderThumb = false;

  /// Notifies listeners to update the slider's value.
  void _updateValue(double value) {
    widget.onValueChanged(value);
  }

  /// Checks if a drag occurred and invokes the [onSliderDragEnd] callback if applicable.
  void checkAndCallOnSliderDragEnd() {

    if (widget.onSliderDragEnd == null) return;

    // Determines if a drag operation actually occurred.
    if (valueDragBefore != valueDragAfter) {
      final result = CompareSliderDragEndResult(valueDragBefore: valueDragBefore, valueDragAfter: valueDragAfter);
      var onSliderDragEnd = widget.onSliderDragEnd;
      if (onSliderDragEnd != null) onSliderDragEnd.call(result);
    }
  }

  /// Handles pointer up or cancel events.
  void handleOnPointerUpOrCancel(PointerEvent event) {
    activePointers.remove(event.pointer);

    // If all pointers are released, cancels the debounce timer.
    if (activePointers.isEmpty) {
      _cancelTimer();
      firstPointerEvent = null;
    }

    if (isOnSliderThumb) {
      isOnSliderThumb = false;
      _callOnSliderThumbTouchEnd();
    }
  }

  /// Handles pointer down events.
  void handleOnPointerDown(PointerDownEvent event) {
    // Adds the current pointer.
    activePointers.add(event.pointer);

    // If this is the first pointer down, initiates the debounce timer.
    if (activePointers.length == 1) {
      // On the first pointer down, starts a timer for delayed processing.
      firstPointerEvent = event;
      _cancelTimer();
      delayTimer = Timer(const Duration(milliseconds: delayMilliseconds), () { handleTouchAfterDelay(); } );
    } else {
      // If multiple pointers are detected, cancels the debounce timer.
      _cancelTimer();
    }
  }

  /// Processes a single pointer event after a delay.
  void handleTouchAfterDelay() {
    // Checks if only a single pointer is still active.
    if (activePointers.length != 1) {
      // Debounce check: if multiple pointers are now active, cancels processing.
      return;
    }

    final event = firstPointerEvent;
    if (event == null) {
      // Debounce check: the first pointer event was null.
      return;
    }

    if ( ! dragOnlyOnSlider ) {
      // In full area drag mode, directly triggers the touch start event.
      isOnSliderThumb = true;
      _callOnSliderThumbTouchBegin();
      return;
    }

    // Calculates the slider's current horizontal position relative to the component's left edge.
    double sliderX = widgetWidth * value;

    // Calculates the left and right boundaries of the slider thumb's hit-test area.
    double sliderThumbHitAreaLeft = sliderX - sliderThickness / 2 - widget.extraHitTestArea.left;
    double sliderThumbHitAreaRight = sliderX + sliderThickness / 2 + widget.extraHitTestArea.right;

    // Uses local coordinates to determine if the touch position is on the
    // slider thumb.
    double touchX = event.localPosition.dx;
    if (touchX >= sliderThumbHitAreaLeft && touchX <= sliderThumbHitAreaRight) {
      // The touch area is on the slider thumb.
      isOnSliderThumb = true;
      _callOnSliderThumbTouchBegin();
    } else {
      // The touch area is not on the slider thumb.
      isOnSliderThumb = false;
    }
  }

  @override
  void dispose() {
    _cancelTimer();
    delayTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var compareSliderRectClipper = CompareSliderRectClipper(direction: CompareSliderDirection.horizontal, clipFactor: value);
    var clipRect = ClipRect(clipper: compareSliderRectClipper, child: widget.before);
    var buildSliderContainer = _buildSliderContainer(value);
    var buildListener = _buildListener();
    var children = [
      widget.after,
      clipRect,
      Positioned.fill(child: buildSliderContainer),
      Positioned.fill(child: buildListener),
    ];
    return StackHitTestWithoutSizeLimit(alignment: AlignmentDirectional.center, children: children);
  }

  Widget _buildSliderContainer(double value) {
    builder(context, constraints) {
      sliderContainerWidth = constraints.maxWidth;
      sliderContainerHeight = constraints.maxHeight;
      return _buildSliderBody();
    }
    return LayoutBuilder(builder: builder);
  }

  Widget _buildSliderBody() {
    // Handles the 'drag only on slider' mode.
    if (dragOnlyOnSlider) {
      onHorizontalDragUpdate(details) {
        fn() {
          // Uses delta to accumulate drag changes.
          double newOffsetX = (offsetX + details.delta.dx).clamp(0.0, sliderContainerWidth - sliderThickness);
          double newValue = newOffsetX / (sliderContainerWidth - sliderThickness);
          _updateValue(newValue);
        }
        setState(fn);
      }
      Widget resultWidget = GestureDetectorHitTestWithoutSizeLimit(
          onHorizontalDragUpdate: onHorizontalDragUpdate,
          debugHitTestAreaColor: widget.debugHitTestAreaColor,
          extraHitTestArea: widget.extraHitTestArea,
          child: widget.thumb,
      );
      var children = [
        _buildSliderArea(),
        Transform.translate(offset: Offset(offsetX, 0), child: resultWidget),
      ];
      resultWidget = StackHitTestWithoutSizeLimit(alignment: sliderStackAlignment, children: children);
      return resultWidget;
    }

    // Handles the 'full area drag' mode.
    Widget resultWidget = Transform.translate(offset: Offset(offsetX, 0), child: widget.thumb);
    resultWidget = StackHitTestWithoutSizeLimit(alignment: sliderStackAlignment, children: [_buildSliderArea(), resultWidget] );
    onHorizontalDragStart(details) {
      fn() {
        double newValue = (details.localPosition.dx - sliderThickness / 2).clamp(0.0, sliderContainerWidth - sliderThickness) / (sliderContainerWidth - sliderThickness);
        _updateValue(newValue);
      }
      setState(fn);
    }
    onHorizontalDragUpdate(details) {
      fn() {
        double newValue = (details.localPosition.dx - sliderThickness / 2).clamp(0.0, sliderContainerWidth - sliderThickness) / (sliderContainerWidth - sliderThickness);
        _updateValue(newValue);
      }
      setState(fn);
    }
    resultWidget = GestureDetectorHitTestWithoutSizeLimit(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      debugHitTestAreaColor: widget.debugHitTestAreaColor,
      extraHitTestArea: widget.extraHitTestArea,
      child: resultWidget,
    );
    return resultWidget;
  }

  Widget _buildSliderArea() {
    Widget resultWidget = Container(height: sliderContainerHeight, color: Colors.transparent);
    // Important: Ignores hit testing to prevent interference with the 'before' and 'after' widgets.
    resultWidget = IgnorePointer(child: resultWidget);
    return resultWidget;
  }

  Widget _buildListener() {
    onPointerDown(event) {
      valueDragBefore = value;
      if (widget.onSliderThumbTouchBegin == null) return;
      handleOnPointerDown(event);
    }
    onPointerUp(event) {
      // Removes the current pointer.
      valueDragAfter = value;
      checkAndCallOnSliderDragEnd();
      if (widget.onSliderThumbTouchEnd == null) return;
      handleOnPointerUpOrCancel(event);
    }
    onPointerCancel(event) {
      // Handles pointer cancellation (e.g., system gestures, incoming calls).
      valueDragAfter = value;
      checkAndCallOnSliderDragEnd();
      if (widget.onSliderThumbTouchEnd == null) return;
      handleOnPointerUpOrCancel(event);
    }
    var listener = Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: onPointerDown,
      onPointerUp: onPointerUp,
      onPointerCancel: onPointerCancel,
      child: SizedBox.shrink(),
    );
    builder(context, constraints) {
      widgetWidth = constraints.maxWidth;
      // Detects touch events - positioned at the topmost layer to capture all
      // pointer events.
      return listener;
    }
    return LayoutBuilder(builder: builder);
  }

  _cancelTimer() {
    var timer = delayTimer;
    if (timer != null) timer.cancel();
  }

  _callOnSliderThumbTouchEnd() {
    var onSliderThumbTouchEnd = widget.onSliderThumbTouchEnd;
    if (onSliderThumbTouchEnd != null) onSliderThumbTouchEnd.call();
  }

  _callOnSliderThumbTouchBegin() {
    var onSliderThumbTouchBegin = widget.onSliderThumbTouchBegin;
    if (onSliderThumbTouchBegin != null) onSliderThumbTouchBegin.call();
  }

}