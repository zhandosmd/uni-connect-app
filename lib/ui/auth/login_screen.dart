import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/auth/login_view_model.dart';
import 'package:uni_connect/ui/main/main_screen.dart';
import 'package:uni_connect/ui/registration/registration_screen.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    final model = context.read<LoginViewModel>();

    final isLoading = context.select((LoginViewModel vm) => vm.isLoading);
    final hidePassword = context.select((LoginViewModel vm) => vm.hidePassword);
    final isErrorEmail = context.select((LoginViewModel vm) => vm.isErrorEmail);
    final isErrorPassword = context.select((LoginViewModel vm) => vm.isErrorPassword);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/im_login_bg.png'),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/UniConnect.png', height: 32, width: 142,),
                        const Text('Login', style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned.fill(
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height-261 + 20,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: AppColors.backgroundColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 35,),
                        const Text('Login to your personal account', style: TextStyle(
                          fontSize: 12, color: Colors.white
                        ),),
                        const SizedBox(height: 11,),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: AppColors.black,
                            border: isErrorEmail ? Border.all(color: AppColors.red) : null
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: model.emailController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter your ID',
                                      hintStyle: TextStyle(color: AppColors.gray, fontSize: 12)
                                    ),
                                  ),
                                ),
                                const Text('@stu.sdu.edu.kz', style: TextStyle(color: Colors.white, fontSize: 12),)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 11,),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: AppColors.black,
                            border: isErrorPassword ? Border.all(color: AppColors.red) : null
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: model.passwordController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter your password',
                                      hintStyle: TextStyle(color: AppColors.gray, fontSize: 12),
                                    ),
                                    obscureText: hidePassword,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: model.changeHidePassword,
                                  child: hidePassword
                                    ? SvgPicture.asset('assets/images/ic_eye_closed.svg')
                                    : SvgPicture.asset('assets/images/ic_eye.svg'),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 11,),
                        GestureDetector(
                          onTap: () => model.pressLogin(context),
                          child: Container(
                            height: 48,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: AppColors.mainColor
                            ),
                            child: const Center(
                              child: Text(
                                'Login', style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don’t have account? ', style: TextStyle(color: AppColors.gray, fontSize: 12),),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) {
                                    return const RegistrationScreen();
                                  })
                                );
                              },
                              child: const Text('Create now', style: TextStyle(color: Colors.white, fontSize: 12),)
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
