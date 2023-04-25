import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/registration/registration_view_model.dart';
import 'package:uni_connect/ui/registration/successfully_registered.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<RegistrationViewModel>();
    final isClosed = context.select((RegistrationViewModel vm) => vm.isClosed);
    final errorText = context.select((RegistrationViewModel vm) => vm.errorText);
    final isLoading = context.select((RegistrationViewModel vm) => vm.isLoading);

    return Scaffold(
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
                        const Text('Registration', style: TextStyle(color: Colors.white),)
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
                        const Text('Create a new account', style: TextStyle(
                            fontSize: 12, color: Colors.white
                        ),),
                        const SizedBox(height: 11,),
                        Container(
                          height: 60,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: AppColors.black
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
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: AppColors.black
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: model.nameController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Name',
                                      hintStyle: TextStyle(color: AppColors.gray, fontSize: 12)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 11,),
                        Container(
                          height: 60,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: AppColors.black
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: model.surnameController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Surname',
                                      hintStyle: TextStyle(color: AppColors.gray, fontSize: 12)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 11,),
                        Container(
                          height: 60,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: AppColors.black
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
                                      hintStyle: TextStyle(color: AppColors.gray, fontSize: 12)
                                    ),
                                    obscureText: isClosed,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: model.changeIsClosed,
                                  child: isClosed
                                    ? SvgPicture.asset('assets/images/ic_eye_closed.svg')
                                    : SvgPicture.asset('assets/images/ic_eye.svg'),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 11,),
                        if(errorText != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 11),
                            child: Text(errorText, style: const TextStyle(
                              color: AppColors.red, fontSize: 12
                            ),),
                          ),
                        GestureDetector(
                          onTap: () async {
                            await model.validateSignUp();
                            if(errorText != null) {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) {
                                    return const SuccessfullyRegistered();
                                  })
                              );
                            }
                          },
                          child: Container(
                            height: 48,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: AppColors.mainColor
                            ),
                            child: Center(
                              child: isLoading
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,)
                                )
                                : const Text(
                                  'Sign Up', style: TextStyle(color: Colors.white),
                                ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have account? ', style: TextStyle(color: AppColors.gray, fontSize: 12),),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 12),)
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
