import 'app/app.dart';
import 'bootstrap.dart';
import 'core/utils/constants.dart';

void main() {
  bootstrap(
    () => const App(),
    environment: Environment.production,
  );
}
