import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/history_cubit.dart';
import '../../models/calculation.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HistoryCubit>(context);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.loadHistory();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('История расчётов'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              cubit.loadHistory();
            },
          ),
        ],
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded && state.calculations.isNotEmpty) {
            return ListView.builder(
              itemCount: state.calculations.length,
              itemBuilder: (context, index) {
                Calculation calc = state.calculations[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(
                      '${calc.result.toStringAsFixed(2)} м/с',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text('Масса: ${calc.mass.toStringAsFixed(2)} кг'),
                        Text('Радиус: ${calc.radius.toStringAsFixed(2)} м'),
                        SizedBox(height: 4),
                        Text(
                          'Дата: ${calc.date.day}.${calc.date.month}.${calc.date.year}',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            );
          } else if (state is HistoryLoaded) {
            return Center(
              child: Text(
                'История расчётов пуста',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else {
            return Center(child: Text('Загрузка...'));
          }
        },
      ),
    );
  }
}