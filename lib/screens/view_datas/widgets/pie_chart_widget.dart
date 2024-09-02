import 'package:conta/domain/models/entities/expense/expense_comparison_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final int currentIndex;
  final List<ExpenseComparisonEntity> expenses; // Adicionado para receber dados

  const PieChartWidget({
    super.key,
    required this.currentIndex,
    required this.expenses, // Recebe a lista de despesas
  });

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections;

    if (currentIndex == 1) {
      if (expenses.isEmpty) {
        // Caso a lista de despesas esteja vazia
        sections = [
          PieChartSectionData(
            value: 1, // Um valor pequeno para mostrar um gráfico vazio
            color: Colors.grey,
            title: 'Sem Dados',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ];
      } else {
        // Calcular o total das despesas
        final totalExpense = expenses.fold(0.0, (sum, expense) => sum + expense.totalExpense);

        sections = expenses.map((expense) {
          final percentage = (expense.totalExpense / totalExpense) * 100;
          return PieChartSectionData(
            value: percentage,
            color: Colors.primaries[expenses.indexOf(expense) % Colors.primaries.length],
            title: '${percentage.toStringAsFixed(1)}%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList();
      }
    } else {
      // Dados fixos para outros índices
      sections = [
        PieChartSectionData(
          value: 30,
          color: Colors.red,
          title: '30%',
          radius: 60,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        PieChartSectionData(
          value: 40,
          color: Colors.green,
          title: '40%',
          radius: 60,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        PieChartSectionData(
          value: 30,
          color: Colors.blue,
          title: '30%',
          radius: 60,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ];
    }

    return PieChart(
      PieChartData(
        sections: sections,
        centerSpaceRadius: 45,
        sectionsSpace: 2,
      ),
    );
  }
}
