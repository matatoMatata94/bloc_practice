import 'package:bloc_practice/ui/screens/home_screen.dart';
import 'package:bloc_practice/ui/screens/second_screen.dart';
import 'package:bloc_practice/ui/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brain/cubit/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterCubit _counterCubit = CounterCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Bloc Practice',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => BlocProvider.value(
                value: _counterCubit,
                child: const HomeScreen(
                  title: 'Home Screen',
                  color: Colors.blueAccent,
                ),
              ),
          '/second': (context) => BlocProvider.value(
              value: _counterCubit,
              child: const SecondScreen(
                title: 'Second Screen',
                color: Colors.redAccent,
              )),
          '/third': (context) => BlocProvider.value(
              value: _counterCubit,
              child: const ThirdScreen(
                title: 'Third Screen',
                color: Colors.greenAccent,
              )),
        },
      ),
    );
  }

  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }
}
