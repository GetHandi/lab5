import 'package:flutter_bloc/flutter_bloc.dart';
import 'cosmic_velocity_state.dart';
import 'dart:math';
import '../database/database_provider.dart';
import '../models/calculation.dart';

class CosmicVelocityCubit extends Cubit<CosmicVelocityState> {
  CosmicVelocityCubit() : super(InitialCalculatorState());

  final DBProvider db = DBProvider();

 void calculateVelocity(double mass, double radius) async {
  emit(LoadingState());

  const double G = 6.67430e-11;
  double firstCosmicSpeed = sqrt((G * mass) / radius);

  try {
    await db.insertCalculation(
      Calculation(
        mass: mass,
        radius: radius,
        result: firstCosmicSpeed,
        date: DateTime.now(),
      ),
    );


  } catch (e) {
    print('Ошибка при сохранении: $e');
  }

  emit(ResultState(result: firstCosmicSpeed));

}

  void reset() {
    emit(InitialCalculatorState());
  }
}