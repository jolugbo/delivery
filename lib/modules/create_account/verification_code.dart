// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gt_delivery/core/custom_snackbar.dart';
import 'package:gt_delivery/modules/create_account/security_question.dart';
import 'package:gt_delivery/provider/auth_provider.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:provider/provider.dart';

class VerificationCode extends StatefulWidget {
  final String emailOrPhone;
  final String userId;
  final String channel;
  const VerificationCode({
    super.key,
    required this.emailOrPhone,
    required this.userId,
    required this.channel,
  });

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  //
  late Timer _timer;
  int _remainingSeconds = 60;
  bool _isFormEnabled = true;
  // List of controllers for each TextField
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  // List of focus nodes for each TextField
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  String pin = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        setState(() {
          _isFormEnabled = false;
        });
        _timer.cancel();
      }
    });
  }

  Future<void> verifyUser(AuthProvider authProvider) async {
    if (pin.length != 6) return;

    try {
      setState(() {
        isLoading = true;
      });
      final response = await authProvider.verifyAccount(
          token: pin, userId: widget.userId, channel: widget.channel);
      if (response['success']) {
        //log("Signup successful: ${response['data']}");
        // Navigate to another screen or show success message
        final secQuestions = await authProvider.fetchSecQue();
       
          // Navigate to the next page and pass the questions data
          List<dynamic> questions = secQuestions["data"];
          setState(() {
            isLoading = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SecurityQuestion(questions: questions,userId: widget.userId,)));
        
      } else {
        print("Signup failed: ${response['message']}");
        CustomSnackbar.showError(context,
            "Error ${response['data']["message"] ?? response['message']}");
        // Show error message
      }
    } catch (e) {
      print("Error: $e");
      CustomSnackbar.showError(context, "An unexpected error occurred.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => SecurityQuestion()));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
        body: Stack(
            //overflow: Overflow.visible,
            children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const GoBackButtton(
                  iconColor: AppColor.black,
                ),
                const SizedBox(height: 25),
                Text(
                  'Verification Code',
                  style:
                      AppTextStyle.body(size: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the 6-digit code we sent to ${widget.emailOrPhone}',
                  style: AppTextStyle.body(size: 14),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 50,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "All fields are required";
                          } else {
                            return null;
                          }
                        },
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(
                          color: Colors.black, // Ensures text is black
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: Colors
                              .white, // Sets the background color to white
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColor.primaryColor),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            // Move to the next field
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index + 1]);
                          } else if (value.isEmpty && index > 0) {
                            // Move to the previous field if the current is cleared
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index - 1]);
                          }
                          setState(() {
                            pin = _controllers
                                .map((controller) => controller.text)
                                .join();
                            print("Entered PIN: $pin");
                          });
                        },
                      ),
                    );
                  }),
                ),

                // PinCodeTextField(
                //   pinTextStyle: AppTextStyle.body(),
                //   keyboardType: TextInputType.number,
                //   maxLength: 6,
                //   pinBoxRadius: 10,
                //   pinBoxColor: const Color.fromARGB(13, 255, 255, 255),
                //   pinBoxWidth: 55,
                //   pinBoxHeight: 60,
                //   defaultBorderColor: AppColor.lightgrey,
                //   hasTextBorderColor: AppColor.primaryColor,
                //   onTextChanged: (ss) {
                //     // setState(() {
                //     //   codeController = ss;
                //     // });
                //   },
                // ),
                const SizedBox(height: 20),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'You can resend the code in  ',
                    style: AppTextStyle.body(size: 14),
                  ),
                  TextSpan(
                    text: '$_remainingSeconds ',
                    style: AppTextStyle.body(
                        size: 14,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'seconds ',
                    style: AppTextStyle.body(size: 14),
                  ),
                  TextSpan(
                      text: ' Resend Code',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (_remainingSeconds > 0) return;

                          setState(() {
                            isLoading = true;
                            _remainingSeconds = 60;
                          });

                          var response =
                              await authProvider.requestConfirmationToken(
                                  emailOrPhone: widget.emailOrPhone,
                                  confirmationTokenType: widget.channel,
                                  userId: widget.userId);
                          startTimer();

                          setState(() {
                            isLoading = false;
                          });
                        },
                      style: AppTextStyle.body(
                          fontWeight: FontWeight.bold,
                          size: 14,
                          color: AppColor.primaryColor)),
                ])),
                const SizedBox(height: 70),
                AppButton(
                    color:
                        pin.length != 6 ? AppColor.grey : AppColor.primaryColor,
                    title: 'Verify Account',
                    onTap: () => verifyUser(authProvider))
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              ),
            ),
        ]));
  }
}
