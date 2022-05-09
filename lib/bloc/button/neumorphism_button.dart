import 'package:bloc_counter_app/bloc/counter_bloc.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:provider/provider.dart';

class NeumorphismButton extends StatefulWidget {
  final bool isDarkMode;
  final String mathOperation;
  final CounterEvent counterEvent;
  const NeumorphismButton({
    Key? key,
    required this.isDarkMode,
    required this.mathOperation,
    required this.counterEvent,
  }) : super(key: key);

  @override
  State<NeumorphismButton> createState() => _NeumorphismButtonState();
}

class _NeumorphismButtonState extends State<NeumorphismButton> {
  late bool _isPressed;

  @override
  void initState() {
    super.initState();
    _isPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.isDarkMode ? const Color(0xFF2E3239) : const Color(0xFFE7ECEF);
    Offset distance = _isPressed ? const Offset(7, 7) : const Offset(23, 23);
    double blur = _isPressed ? 5.0 : 30.0;
    return Listener(
      onPointerUp: (_) => setState(() => _isPressed = false),
      onPointerDown: (_) => setState(() {
        context.read<CounterBloc>().add(widget.counterEvent);
        _isPressed = true;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(10),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                blurRadius: blur,
                offset: -distance,
                color:
                    widget.isDarkMode ? const Color(0xFF35393F) : Colors.white,
                inset: _isPressed,
              ),
              BoxShadow(
                blurRadius: blur,
                offset: distance,
                color: widget.isDarkMode
                    ? const Color(0xFF23262A)
                    : const Color(0xFFA7A9AF),
                inset: _isPressed,
              )
            ]),
        child: Center(
          child: Text(
            widget.mathOperation,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade500,
            ),
          ),
        ),
      ),
    );
  }
}
