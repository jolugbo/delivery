import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/modules/create_account/welcome.dart';
import 'package:gt_delivery/provider/auth_provider.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/app_text_fields.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';
import 'package:provider/provider.dart';

class SecurityQuestion extends StatefulWidget {
  final List<dynamic> questions;
  final userId;
  const SecurityQuestion(
      {super.key, required this.questions, required this.userId});

  @override
  State<SecurityQuestion> createState() => _SecurityQuestionState();
}

class _SecurityQuestionState extends State<SecurityQuestion> {
  TextEditingController answerController = TextEditingController();
  bool isLoading = false;

  String? selectedQuestionId; // Holds the selected question ID

  Future<void> submitAnswer(AuthProvider authProvider) async {
    if (selectedQuestionId == null || answerController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a question and provide an answer.')),
      );
      return;
    }

    final Map<String, dynamic> requestBody = {
      "userId": widget.userId,
      "questionAnswers": [
        {
          "questionId": selectedQuestionId,
          "answer": answerController.text,
        }
      ]
    };

    setState(() {
      isLoading = true;
    });
    try {
      final response = await authProvider.setSecQue(body: requestBody);
      if (response["data"]["succeeded"]) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Welcome()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to submit: ${response["data"]["message"]}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    print("got here.... ${widget.userId}");

    return Scaffold(
        body: Stack(
            //overflow: Overflow.visible,
            children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 50),
              const GoBackButtton(
                iconColor: AppColor.black,
              ),
              const SizedBox(height: 25),
              Text(
                'Security Question',
                style: AppTextStyle.body(size: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Set a security question and answer',
                style: AppTextStyle.body(size: 14, color: AppColor.lightdark),
              ),
              const SizedBox(height: 25),
              Text('Security Question',
                  style:
                      AppTextStyle.body(size: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                hint: Text(
                  'Select Question',
                  style: AppTextStyle.body(size: 14),
                ),
                    style: AppTextStyle.body(
                          fontWeight: FontWeight.bold, size: 15),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                items: widget.questions.map((question) {
                  return DropdownMenuItem<String>(
                    value: question["id"],
                    child: Text(
                      question["question"],
                    style: AppTextStyle.body(
                          fontWeight: FontWeight.bold, size: 15),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedQuestionId = value;
                  });
                  print("Selected Question ID: $value");
                },
              ),
              const SizedBox(height: 10),
              Text('Answer',
                  style:
                      AppTextStyle.body(size: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              AppTextFields(
                  controller: answerController,
                  hint: 'Answer to Security Question'),
              const SizedBox(height: 40),
              AppButton(
                  title: 'Set Question',
                  onTap: () {
                    submitAnswer(authProvider);
                  }),
            ]),
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
