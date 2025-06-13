import 'screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cosmic_velocity_cubit.dart';
import 'screens/cosmic_velocity_screen.dart';
import 'cubit/history_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CosmicVelocityCubit()),
        BlocProvider(create: (_) => HistoryCubit()),
      ],
      child: MaterialApp(
        title: 'Лабораторная работа #5 (Иваненков А.И.)',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CosmicVelocityScreen(),
        routes: {
          '/history': (context) => HistoryScreen(),
        },
      ),
    );
  }
}