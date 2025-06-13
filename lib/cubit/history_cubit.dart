import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/database_provider.dart';
import '../models/calculation.dart';

abstract class HistoryState {}
class HistoryInitial extends HistoryState {}
class HistoryLoading extends HistoryState {}
class HistoryLoaded extends HistoryState {
  final List<Calculation> calculations;
  HistoryLoaded(this.calculations);
}

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  final DBProvider db = DBProvider();

  void loadHistory() async {
  emit(HistoryLoading());

  try {
    final calculations = await db.getAllCalculations();
    emit(HistoryLoaded(calculations));
  } catch (e) {
    emit(HistoryLoaded([]));
  }
}
}