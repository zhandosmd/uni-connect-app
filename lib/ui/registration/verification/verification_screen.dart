import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/registration/registration_screen.dart';
import 'package:uni_connect/ui/registration/verification/verification_view_model.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final String slug;
  const VerificationScreen({Key? key, required this.email, required this.slug}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final codeFormatter = MaskTextInputFormatter(
    mask: '# # # #',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  @override
  Widget build(BuildContext context) {
    final model = context.read<VerificationViewModel>();
    final isErrorCode = context.select((VerificationViewModel vm) => vm.isErrorCode);
    final isLoading = context.select((VerificationViewModel vm) => vm.isLoading);

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
                        const Text('Verification', style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 20,
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: const Icon(Icons.chevron_left)
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
                        const Text('We have send verification code to your email', style: TextStyle(
                            fontSize: 12, color: Colors.white
                        ),),
                        const SizedBox(height: 11,),
                        Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(widget.email, style: const TextStyle(color: Colors.white, fontSize: 12),)
                                ),
                                Text(widget.slug, style: const TextStyle(color: Colors.white, fontSize: 12))
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
                            border: isErrorCode ? Border.all(color: AppColors.red) : null
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    inputFormatters: [codeFormatter],
                                    controller: model.codeController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '_ _ _ _',
                                      hintStyle: TextStyle(color: AppColors.gray, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 11,),
                        GestureDetector(
                          onTap: (){
                            if(codeFormatter.getUnmaskedText().length == 4){
                              model.onTapVerify(context, '${widget.email}${widget.slug}', codeFormatter.getUnmaskedText());
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
                                  'Verify', style: TextStyle(color: Colors.white),
                                ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don’t receive the code? ', style: TextStyle(color: AppColors.gray, fontSize: 12),),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) {
                                    return const RegistrationScreen();
                                  })
                                );
                              },
                              child: const Text('Repeat code', style: TextStyle(color: Colors.white, fontSize: 12),)
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
