import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/core/custom_snackbar.dart';
import 'package:gt_delivery/create_account/verify.dart';
import 'package:gt_delivery/login/welcome_back.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/app_text_fields.dart';
import 'package:gt_delivery/widget/back_button.dart';
import 'package:gt_delivery/widget/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  final TextEditingController dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String category = 'Prepaid';
  String gender = "Male";
  bool isLoading = false;

  Future<void> registerUser(AuthProvider authProvider) async {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform signup if validation passes
      print('Form is valid, proceed with API call');
      setState(() {
        isLoading = true;
      });

      final response = await authProvider.signup(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneController.text,
          email: emailController.text,
          gender: gender[0],
          dateOfBirth: dobController.text,
          confirmPassword: cpasswordController.text,
          username: userNameController.text,
          category: category,
          //accountType: "Customer",
          password: passwordEditingController.text);

      setState(() {
        isLoading = false;
      });

      if (response['success']) {
        log("Signup successful: ${response['data']} ${response["data"]["resultData"]["id"]}");
        log("${response["data"]["resultData"]["id"]}");
        // Navigate to another screen or show success message

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyPage(
                      email: emailController.text,
                      phone: phoneController.text,
                      userId: response["data"]["resultData"]["id"],
                    )));
      } else {
        print("Signup failed: ${response['message']}");
        CustomSnackbar.showError(
            context, response['data']["message"] ?? response['message']);
        // Show error message
      }
    } else {
      print('Form is invalid, show errors');
    }
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => VerifyPage()));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        //overflow: Overflow.visible,
        children: <Widget>[
         SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      const GoBackButtton(
                        iconColor: AppColor.black,
                        color: AppColor.white,
                        borderColor: AppColor.lightgrey,
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'Create Your Account',
                        style: AppTextStyle.body(
                            size: 27,
                            fontWeight: FontWeight.bold,
                            color: AppColor.dark),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lets get you started on GT Deliveries',
                        style: AppTextStyle.body(
                            size: 14, color: AppColor.lightdark),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.42,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'First Name',
                                  style: AppTextStyle.body(
                                      size: 14, fontWeight: FontWeight.w500),
                                ),
                                AppTextFields(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'First Name empty';
                                      }
                                      return null;
                                    },
                                    controller: firstNameController,
                                    error: 'First Name empty',
                                    hint: 'Enter Your Name'),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.42,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Last Name',
                                  style: AppTextStyle.body(
                                      size: 14, fontWeight: FontWeight.w500),
                                ),
                                AppTextFields(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Last Name cannot be empty';
                                      }
                                      return null;
                                    },
                                    controller: lastNameController,
                                    hint: 'Enter Your Name'),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text('Username',
                          style: AppTextStyle.body(
                              size: 14, fontWeight: FontWeight.w500)),
                      SizedBox(height: 8),
                      AppTextFields(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'UserName cannot be empty';
                            } else if (value.length < 3 || value.length > 8) {
                              return 'Username must be between 3 and 8 characters';
                            }
                            return null;
                          },
                          controller: userNameController,
                          hint: 'Enter Your username'),
                      SizedBox(height: 8),
                      Text('Phone Number',
                          style: AppTextStyle.body(
                              size: 14, fontWeight: FontWeight.w500)),
                      SizedBox(height: 8),
                      AppTextFields(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number cannot be empty';
                            } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                              return 'Phone number must contain only digits';
                            } else if (value.length < 10 || value.length > 15) {
                              return 'Phone number must be between 10 and 15 digits';
                            }
                            return null;
                          },
                          controller: phoneController,
                          hint: 'Enter Your Number'),
                      const SizedBox(height: 8),
                      Text('Email',
                          style: AppTextStyle.body(
                              size: 14, fontWeight: FontWeight.w500)),
                      SizedBox(height: 8),
                      AppTextFields(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          controller: emailController,
                          hint: 'Enter Your Email'),
                      SizedBox(height: 8),
                      Text('Category ',
                          style: AppTextStyle.body(
                              size: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                          validator: (String? value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == "Select Category") {
                              return "Please select a category";
                            }
                            return null;
                          },
                          hint: Text(
                            'Select category',
                            style: AppTextStyle.body(size: 14),
                          ),
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.3)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.primaryColor)),
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ))),
                          items: <String>['Prepaid', 'Postpaid']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: AppTextStyle.body(size: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              category = newValue!;
                            });
                          }),
                      const SizedBox(height: 8),
                      Text('Gender',
                          style: AppTextStyle.body(
                              size: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        validator: (String? value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == "Select Gender") {
                            return "Please select a gender";
                          }
                          return null;
                        },
                        hint: Text(
                          'Select gender',
                          style: AppTextStyle.body(size: 14),
                        ),
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.3)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.primaryColor)),
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ))),
                        items: <String>['Female', 'Male'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: AppTextStyle.body(size: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            gender = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      Text('Date of Birth',
                          style: AppTextStyle.body(
                              size: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      AppTextFields(
                        controller: dobController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date of Birth cannot be empty';
                          }
                          //try {
                          //   final dob = DateTime.parse(value);
                          //   final currentDate = DateTime.now();
                          //   final minDate = DateTime(currentDate.year - 18,
                          //       currentDate.month, currentDate.day);
                          //   if (dob.isAfter(currentDate)) {
                          //     return 'Date of Birth cannot be in the future';
                          //   } else if (dob.isAfter(minDate)) {
                          //     return 'You must be at least 18 years old';
                          //   }
                          // } catch (e) {
                          //   return 'Invalid date format';
                          // }
                          return null;
                        },
                        hint: 'Enter D.O.B',
                        isReadOnly: true,
                        onTab: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900), // Earliest possible date
                            lastDate:
                                DateTime.now(), // Latest possible date (today)
                          );

                          if (pickedDate != null) {
                            // Format the date to "yyyy-MM-dd" format
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              dobController.text = formattedDate;
                            });

                            print(formattedDate);
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      Text('Password',
                          style: AppTextStyle.body(
                              size: 14, fontWeight: FontWeight.w500)),
                      SizedBox(height: 8),
                      AppTextFields(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return 'Password must have at least one uppercase letter';
                          } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return 'Password must have at least one digit';
                          } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                              .hasMatch(value)) {
                            return 'Password must have at least one special character';
                          }
                          return null;
                        },
                        controller: passwordEditingController,
                        hint: 'Enter Your Password',
                        isPassword: true,
                      ),
                      const SizedBox(height: 8),
                      Text('Confirm Password',
                          style: AppTextStyle.body(
                              size: 14, fontWeight: FontWeight.w500)),
                      SizedBox(height: 8),
                      AppTextFields(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password cannot be empty';
                          } else if (value != passwordEditingController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        controller: cpasswordController,
                        hint: 'Enter Your Password',
                        isPassword: true,
                      ),
                      const SizedBox(height: 50),
                      AppButton(
                          title: 'Sign Up',
                          onTap: () => registerUser(authProvider)
                          ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: AppTextStyle.body(size: 14),
                            ),
                            TextSpan(
                                text: 'Sign In',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WelcomeBack()));
                                  },
                                style: AppTextStyle.body(
                                    fontWeight: FontWeight.bold,
                                    size: 14,
                                    color: AppColor.primaryColor)),
                          ])),
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
     if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ])

    //   isLoading
    //       ? Loading()
    //       : 
     );
  }
}
