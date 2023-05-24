import 'package:get_it/get_it.dart';

import '../resources/api_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api('products'));
}
