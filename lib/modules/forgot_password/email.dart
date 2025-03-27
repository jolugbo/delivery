import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/core/custom_snackbar.dart';
import 'package:gt_delivery/modules/forgot_password/verification_code.dart';
import 'package:gt_delivery/provider/auth_provider.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/app_text_fields.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';
import 'package:provider/provider.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isFormValid = false;
  void _validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  Future<void> requestToken(AuthProvider authProvider) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });
      var response = await authProvider.requestPasswordResetToken(
          emailOrPhone: emailController.text,
          channel: "EMAIL",
          accountType: "Customer");
      setState(() {
        isLoading = false;
      });
      if (response['success']) {
        print(
            "Token Request successful: ${response['data']} ${response["data"]["resultData"]["id"]}");
        print("${response["data"]["resultData"]["id"]}");
        //log("${response["data"]["resultData"]["id"]}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ForgotPasswordVerificationCode(
                      channel: "EMAIL",
                      emailOrPhone: emailController.text,
                    )));
      } else {
        print("Token Request  failed: ${response['message']}");
        CustomSnackbar.showError(context, "Error sending Email ${response['message']}");
        // Show error message
      }
    } else {
      CustomSnackbar.showError(context, "Please Provide a valid email");
    }
    return;
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
                  'Forgot Password',
                  style:
                      AppTextStyle.body(size: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the email linked to your account and we will send you a code to change your password',
                  style: AppTextStyle.body(size: 14),
                ),
                Form(
                    key: _formKey,
                    onChanged: _validateForm,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          Text('Email',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 8),
                          AppTextFields(
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Enter a valid email address';
                                }
                                return null;
                              },
                              hint: 'Enter your email'),
                          const SizedBox(height: 50),
                          AppButton(
                              title: 'Send Code',
                              color: isFormValid
                                  ? AppColor.primaryColor
                                  : AppColor.grey,
                              onTap: () => requestToken(authProvider)),
                        ]))
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
