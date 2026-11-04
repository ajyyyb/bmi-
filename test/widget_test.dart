import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ajybek_caltor/main.dart';

Future<void> showResult(WidgetTester tester, {required double height, required int weight}) {
  return tester.pumpWidget(MaterialApp(home: BMIResultScreen(height: height, weight: weight)));
}

void main() {
  testWidgets('the result screen shows the index and its group', (tester) async {
    await showResult(tester, height: 180, weight: 81);

    expect(find.text('25.0'), findsOneWidget);
    expect(find.text('Артык салмак'), findsOneWidget);
  });

  testWidgets('a normal index is labelled as normal', (tester) async {
    await showResult(tester, height: 175, weight: 70);

    expect(find.text('22.9'), findsOneWidget);
    expect(find.text('Нормалдуу'), findsOneWidget);
  });
}
