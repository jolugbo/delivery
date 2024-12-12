import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/provider/auth_provider.dart';
import 'package:gt_delivery/splash_screen/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],child: const MyApp()));
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
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  //   return MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       title: 'Flutter Demo',
  //       theme: ThemeData(
  //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //         scaffoldBackgroundColor: AppColor.white,
  //         useMaterial3: true,
  //       ),
  //       home: SplashScreen());
   }
}
