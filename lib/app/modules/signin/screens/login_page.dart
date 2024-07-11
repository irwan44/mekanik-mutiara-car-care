import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mekanik/app/componen/color.dart';
import '../../../data/data_endpoint/login.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../common/common.dart';
import '../widgets/custom_widget.dart';
import 'fade_animationtest.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.black,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              height: 740,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black
                        .withOpacity(0.0),
                    Colors.black
                        .withOpacity(0.9),
                    Colors.black,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInAnimation(
                            delay: 1.3,
                            child: Text(
                              "Selamat Datang",
                              style: Common().mediumTheme,
                            ),
                          ),
                          FadeInAnimation(
                            delay: 1.6,
                            child: Text(
                              "Mutiara Car Care",
                              style: Common().titelTheme,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        child: Column(
                          children: [
                            FadeInAnimation(
                              delay: 1.9,
                              child: CustomTextFormField(
                                hinttext: 'Masukkan email Anda',
                                obsecuretext: false,
                                controller:
                                    _emailController, // Tambahkan controller untuk TextFormField
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FadeInAnimation(
                              delay: 2.2,
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: obscureText,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18),
                                  hintText: "Masukkan kata sandi Anda",
                                  hintStyle: Common().hinttext,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: togglePasswordVisibility,
                                    icon: Icon(
                                      obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FadeInAnimation(
                              delay: 2.5,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Get.to(const ForgetPasswordPage());
                                  },
                                  child: Text(
                                    "",
                                    style: Common().semiboldblack,
                                  ),
                                ),
                              ),
                            ),
                            FadeInAnimation(
                              delay: 2.8,
                              child: CustomElevatedButton(
                                message: "Masuk",
                                function: () async {
                                  HapticFeedback.lightImpact();
                                  if (_emailController.text.isNotEmpty &&
                                      _passwordController.text.isNotEmpty) {
                                    try {
                                      Token aksesPX = await API.login(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );

                                      if (aksesPX.status != false) {
                                        if (aksesPX.token != null) {
                                          Get.offAllNamed(Routes.HOME);
                                        }
                                      } else {
                                        String errorMessage = aksesPX.message ??
                                            'Terjadi kesalahan saat login';
                                        Object errorDetail = aksesPX.data ?? '';
                                        Get.snackbar('Error',
                                            '$errorMessage: $errorDetail',
                                            backgroundColor: Colors.redAccent,
                                            colorText: Colors.white
                                        );
                                      }
                                    } catch (e) {
                                      print('Error during login: $e');
                                      Get.snackbar('Gagal Login',
                                          'Terjadi kesalahan saat login',
                                          backgroundColor: Colors.redAccent,
                                          colorText: Colors.white
                                      );
                                    }
                                  } else {
                                    Get.snackbar('Gagal Login',
                                        'Username dan Password harus diisi',
                                        backgroundColor: Colors.redAccent,
                                      colorText: Colors.white
                                    );
                                  }

                                  setState(() {
                                    flag = !flag;
                                  });
                                },
                                color: MyColors.appPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 305,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
