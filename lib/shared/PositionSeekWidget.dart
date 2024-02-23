import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    this.currentPosition,
    this.duration,
    this.seekTo,
  });

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  Duration _visibleValue;
  bool listenOnlyUserInterraction = false;
  double get percent => widget.duration.inMilliseconds == 0 ? 0 : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          durationToString(widget.currentPosition),
          style: TextStyle(color: Get.theme.indicatorColor, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(
          child: SliderTheme(
            data: const SliderThemeData(
              activeTrackColor: Color(0xff1262CC),
              disabledActiveTrackColor: Color(0xff90ACDB),
              inactiveTrackColor: Color(0xff90ACDB),
              inactiveTickMarkColor: Color(0xff1262CC),
              trackHeight: 7,
              trackShape: RectangularSliderTrackShape(),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
              // trackShape: CustomTrackShape(),
            ),
            child: Slider(
              activeColor: const Color(0xff1262CC),
              thumbColor: const Color(0xfff3f3f3),
              min: 0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: percent * widget.duration.inMilliseconds.toDouble(),
              onChangeEnd: (newValue) {
                setState(() {
                  listenOnlyUserInterraction = false;
                  widget.seekTo(_visibleValue);
                });
              },
              onChangeStart: (_) {
                setState(() {
                  listenOnlyUserInterraction = true;
                });
              },
              onChanged: (newValue) {
                setState(() {
                  final to = Duration(milliseconds: newValue.floor());
                  _visibleValue = to;
                });
              },
            ),
          ),
        ),
        Text(
          durationToString(widget.duration),
          style: TextStyle(color: Get.theme.indicatorColor, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    RenderBox parentBox,
    Offset offset = Offset.zero,
    SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
