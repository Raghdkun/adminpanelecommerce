
import 'package:adminpanelecommerce/controllers/auth_controller.dart';
import 'package:adminpanelecommerce/controllers/orders_controller.dart';
import 'package:adminpanelecommerce/controllers/product_controller.dart';
import 'package:adminpanelecommerce/screens/main/main_screen.dart';
import 'package:adminpanelecommerce/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'shared/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "", // Your apiKey
      appId: "", // Your appId
      messagingSenderId: "", // Your messagingSenderId
      projectId: "", // Your projectId
    ),
  );
  await DioHelper.init();
  //DesktopWindow.setMinWindowSize(Size(1300, 800));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthController(),
    ),
    ChangeNotifierProxyProvider<AuthController, MenuController>(
      update: (context, auth, previousMenu) => MenuController(auth),
      create: (BuildContext context) => MenuController(null),
    ),
    ChangeNotifierProvider(
      create: (context) => OrdersController()..getAllorders(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductController()..getallProduct(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MainScreen(),
    );
  }
}
