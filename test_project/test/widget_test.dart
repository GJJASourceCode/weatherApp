import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_project/main.dart';

void main() {
  testWidgets('WeatherApp은 날씨를 올바르게 표시합니다', (WidgetTester tester) async {
    // 앱을 빌드하고 화면을 갱신합니다.
    await tester.pumpWidget(const WeatherApp());

    // 초기에 "No weather data" 텍스트를 확인합니다.
    expect(find.text('No weather data'), findsOneWidget);

    // 텍스트 필드에 위치를 입력합니다.
    await tester.enterText(find.byType(TextField), 'New York');

    // 검색 버튼을 탭하고 화면을 갱신합니다.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // "No weather data" 텍스트가 있는지 확인합니다.
    if (find.text('No weather data').evaluate().isEmpty) {
      // 날씨 데이터가 로드될 때까지 대기합니다.
      await tester.pump(Duration(seconds: 2));
    }

    // 날씨 데이터가 표시되는지 확인합니다.
    expect(find.text('No weather data'), findsNothing);
    expect(find.text('Current Weather:'), findsOneWidget);
    expect(find.byIcon(Icons.cloud), findsOneWidget);
    expect(find.text('Sunny'), findsOneWidget);
  });
}
