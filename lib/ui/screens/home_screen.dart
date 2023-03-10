import 'package:bloc_practice/brain/cubit/counter_cubit.dart';
import 'package:bloc_practice/brain/cubit/internet_cubit.dart';
import 'package:bloc_practice/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../brain/cubit/counter_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.wifi) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.mobile) {
          BlocProvider.of<CounterCubit>(context).decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                  builder: ((context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.wifi) {
                  return Text(
                    'Wifi',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.red),
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.mobile) {
                  return Text(
                    'Mobile',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.red),
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.red),
                  );
                } else {
                  return Text(
                    'Unknown Type of Connection',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.red),
                  );
                }
              })),
              const SizedBox(height: 50),
              const Text(
                'You have pushed the button this many times:',
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Incremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Decremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.counterValue == 5) {
                    return Text(
                      'This is Mambo No. ${state.counterValue.toString()}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue % 2 == 0) {
                    return Text(
                      'This is a good Number: ${state.counterValue.toString()}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue < 0) {
                    return Text(
                      'Negative ${state.counterValue.toString()}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue > 0) {
                    return Text(
                      'Positive ${state.counterValue.toString()}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else {
                    return Text(
                      state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: 'btn1',
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    child: const Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: 'btn2',
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              MaterialButton(
                onPressed: (() {
                  Navigator.of(context).pushNamed('/second');
                }),
                height: 50,
                color: widget.color,
                child: const Text(
                  'Press here for Screen 2',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 50),
              MaterialButton(
                onPressed: (() {
                  Navigator.of(context).pushNamed('/third');
                }),
                height: 50,
                color: widget.color,
                child: const Text(
                  'Press here for Screen 3',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
