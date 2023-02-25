import 'package:bloc_practice/brain/cubit/internet_cubit.dart';
import 'package:bloc_practice/ui/screens/home_screen.dart';
import 'package:bloc_practice/ui/screens/second_screen.dart';
import 'package:bloc_practice/ui/screens/third_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brain/cubit/counter_cubit.dart';

void main() {
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.connectivity});

  final CounterCubit _counterCubit = CounterCubit();

  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
      ],
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
}
