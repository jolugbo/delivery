import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/modules/login/welcome_back.dart';
import 'package:gt_delivery/provider/auth_provider.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestLocationPermission();
    });
  }

  Future<void> loginUser(AuthProvider authProvider) async {
    
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const WelcomeBack()));
     
  }

  Future<void> _requestLocationPermission() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentStatus = await Permission.location.status;
    if (currentStatus.isGranted) {
      print('Permission already granted');
      loginUser( authProvider);
    } else if (currentStatus.isDenied || currentStatus.isRestricted) {
      // Request permission explicitly
      final newStatus = await Permission.location.request();
      if (newStatus.isGranted) {
      loginUser( authProvider);
      } else if (newStatus.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Location permission is required to continue.')),
        );
      } else if (newStatus.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Permission permanently denied. Please enable it in settings.'),
            action: SnackBarAction(
              label: 'Settings',
              onPressed: openAppSettings,
            ),
          ),
        );
      }
    } else if (currentStatus.isPermanentlyDenied) {
      print('Permission permanently denied. Opening settings...');
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Image(image: AssetImage(AppImages.welcome)),
              const SizedBox(height: 30),
              Text(
                textAlign: TextAlign.center,
                'Welcome to GTDeliveries!',
                style: AppTextStyle.body(size: 33, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Bridging Borders, Delivering Excellence',
                style: AppTextStyle.body(size: 14),
              ),
              const SizedBox(height: 80),
              AppButton(
                title: 'Continue to Home',
                onTap: () => _requestLocationPermission(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
