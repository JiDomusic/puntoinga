import 'package:flutter_test/flutter_test.dart';
import 'package:puntorojo/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(initialScreen: HomeScreen()));

    // Aquí deberías ajustar las expectativas a lo que realmente muestra tu HomeScreen
    // Por ejemplo, si tienes un texto 'Nosotros' en la pantalla:
    expect(find.text('Nosotros'), findsOneWidget);

    // Si tienes un contador, tendrías que adaptar el test a esa funcionalidad.
  });
}
