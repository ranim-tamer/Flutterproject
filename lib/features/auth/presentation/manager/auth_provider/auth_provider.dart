import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../core/cache_helper/cache_helper.dart';
import '../../../../../core/functions/navigation.dart';
import '../../../../../core/functions/show_snackbar.dart';
import '../../../../../core/http_services/http_services.dart';
import '../../../../layout/presentation/view/layout_view.dart';
import '../../view/login_view.dart';

class AuthProvider extends ChangeNotifier {
  bool isRegisterLoading = false;

  bool isLoginLoading = false;

  userRegister({
    required Map<String, dynamic> userData,
    required BuildContext context,

  }) async {
    isRegisterLoading = true;
    notifyListeners();
    var response = await HttpServices.postData(
      path: 'users',
      data: userData,
    );
    if (response.statusCode == 200) {
      showSnackBar(
        context: context,
        text: 'Successfully',
        color: Colors.blue,
      );
      navigateAndRemoveUntil(
        context: context,
        screen: const LoginView(),
      );
    } else {
      showSnackBar(
        context: context,
        text: 'Check your information',
        color: Colors.red,
      );
    }
    isRegisterLoading = false;
    notifyListeners();
  }

  userLogin({
    required Map<String, dynamic> userData,
    required BuildContext context,
  }) async {
    isLoginLoading = true;
    notifyListeners();
   var response = await HttpServices.postData(
      path: 'auth/login',
      data: userData,
    );
    if (response.statusCode == 200) {
      CacheHelper.saveData(key: 'token', value: json.decode(response.body)['token']);
      showSnackBar(
        context: context,
        text: 'Successfully',
        color: Colors.blue,
      );
      navigateAndRemoveUntil(
        context: context,
        screen: const LayoutView(),
      );
    } else {
      showSnackBar(
        context: context,
        text: 'Check your information',
        color: Colors.red,
      );
    }
    isLoginLoading = false;
    notifyListeners();
  }
}
