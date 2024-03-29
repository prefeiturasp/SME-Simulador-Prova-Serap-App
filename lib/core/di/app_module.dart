import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

@module
abstract class AppModule {
  @lazySingleton
  InternetConnectionCheckerPlus get internetConnectionCheckerPlus => InternetConnectionCheckerPlus();

  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();
}
