import 'package:get/get.dart';

class LoginController extends GetxController {
  RxString error = "".obs;
  RxBool passwordVisible = false.obs;
  RxInt n = 0.obs;

  void handlePassword() {
    passwordVisible.value = !passwordVisible.value;
  }

  void handdleError(String errorMessage) {
    print(errorMessage);
    error.value = errorMessage;
  }
}
