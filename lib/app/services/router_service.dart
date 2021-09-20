import "package:injectable/injectable.dart";
import "package:arm_test/app/router/router.dart";
    
@lazySingleton
class RouterService {
  final ArmTestRouter router = ArmTestRouter();
}