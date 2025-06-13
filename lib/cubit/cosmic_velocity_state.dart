abstract class CosmicVelocityState {}

class LoadingState extends CosmicVelocityState {}

class InitialCalculatorState extends CosmicVelocityState {}

class ResultState extends CosmicVelocityState {
  final double result;

  ResultState({required this.result});
}