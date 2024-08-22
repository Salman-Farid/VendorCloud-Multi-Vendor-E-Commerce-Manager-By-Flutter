import 'package:get/get.dart';
import '../../controllers/oerder_controller.dart';
class OrderlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(()=>OrderController());
  }
}
