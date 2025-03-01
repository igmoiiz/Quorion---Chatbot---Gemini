import 'package:flutter/widgets.dart';

class InputControllers {
  //  FORM VALIDATOR
  final formKey = GlobalKey<FormState>();
  //  LOADING VARIABLE
  bool loading = false;

  //  TEXT EDITING CONTROLLERS
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController = TextEditingController();
}
