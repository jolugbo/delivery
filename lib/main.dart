import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/modules/walk_through/root.dart';
import 'package:gt_delivery/provider/config_provider.dart';
import 'package:gt_delivery/provider/delivery_provider.dart';
import 'package:gt_delivery/provider/auth_provider.dart';
import 'package:gt_delivery/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => DeliveryProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => ConfigProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red,
              splashColor: AppColor.primaryColor,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: const WalkthroughScreen(),
          );
        });
  }
}


//remove the internet check (done)

//change the font design Size(done)

//let keyboard go to the bottom of the form

//take out items in the dashboard(done)
