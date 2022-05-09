import 'package:bloc_counter_app/bloc/button/neumorphism_button.dart';
import 'package:bloc_counter_app/bloc/counter_bloc.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fancy_containers/fancy_containers.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _controller;

  bool isDarkMode = false;
  // bool _isElevated = true;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isDarkMode ? const Color(0xFF2E3239) : const Color(0xFFE7ECEF);

    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text('Counter App'),
        ),
        body: BlocConsumer<CounterBloc, CounterState>(
          listener: (context, state) {
            _controller.clear();
          },
          builder: (context, state) {
            final invalidValue =
                (state is CounterStateInvalid) ? state.invalidValue : '';
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(11.0),
                    margin: const EdgeInsets.all(10),
                    child: FancyContainer(
                      onTap: (() {}),
                      height: 70,
                      color1: Colors.lightGreenAccent,
                      color2: Colors.lightBlue,
                      title: 'Current Value',
                      textcolor: Colors.white,
                      subtitle: ' ${state.value}',
                      subtitlecolor: Colors.white,
                    ),
                  ),
                  Visibility(
                    child: Text(
                      'Invalid Input $invalidValue',
                      style:
                          TextStyle(fontSize: 16, color: Colors.red.shade600),
                    ),
                    visible: state is CounterStateInvalid,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a number here',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     TextButton(
                  //       onPressed: () {
                  //         context
                  //             .read<CounterBloc>()
                  //             .add(DecrementEvent(_controller.text));
                  //       },
                  //       child: const Text('-'),
                  //     ),
                  //     TextButton(
                  //       onPressed: () {
                  //         context
                  //             .read<CounterBloc>()
                  //             .add(IncrementEvent(_controller.text));
                  //       },
                  //       child: const Text('+'),
                  //     ),
                  //   ],
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NeumorphismButton(
                        isDarkMode: isDarkMode,
                        mathOperation: '-',
                        counterEvent: DecrementEvent(_controller.text),
                      ),
                      NeumorphismButton(
                        isDarkMode: isDarkMode,
                        mathOperation: '+',
                        counterEvent: IncrementEvent(_controller.text),
                      )
                      // Listener(
                      //   onPointerUp: (_) => setState(() => isPressed = false),
                      //   onPointerDown: (_) => setState(() => isPressed = true),
                      //   child: NeumorphismButton(
                      //     isPressed: isPressed,
                      //     isDarkMode: isDarkMode,
                      //     mathOperation: '-',
                      //   ),
                      // ),
                      // Listener(
                      //   onPointerUp: (_) => setState(() => isPressed = false),
                      //   onPointerDown: (_) => setState(() => isPressed = true),
                      //   child: NeumorphismButton(
                      //     isPressed: isPressed,
                      //     isDarkMode: isDarkMode,
                      //     mathOperation: '+',
                      //   ),
                      // ),
                    ],
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     _isElevated = !_isElevated;
                  //   },
                  //   child: AnimatedContainer(
                  //     duration: const Duration(microseconds: 200),
                  //     height: 200,
                  //     width: 200,
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[300],
                  //       borderRadius: BorderRadius.circular(50),
                  //       boxShadow: _isElevated
                  //           ? [
                  //               BoxShadow(
                  //                 color: Colors.grey[500]!,
                  //                 offset: const Offset(4, 4),
                  //                 blurRadius: 15,
                  //                 spreadRadius: 1,
                  //               ),
                  //               const BoxShadow(
                  //                 color: Colors.white,
                  //                 offset: Offset(-4, -4),
                  //                 blurRadius: 15,
                  //                 spreadRadius: 1,
                  //               )
                  //             ]
                  //           : null,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
