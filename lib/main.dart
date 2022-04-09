import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/src/controller/provider/authenticationProvider.dart';
import 'package:fluttertest/src/controller/provider/dataProvider.dart';
import 'package:fluttertest/src/model/hiveModel.dart';
import 'package:fluttertest/src/view/Intro/splashScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());
  await Hive.openBox<UserData>("userData");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DataProvider()),
        ChangeNotifierProvider.value(value: AuthProvider()),
        // FutureProvider(create: (_)=> getUsers(), initialData:0 ),
      ],
      child: MaterialApp(
        navigatorKey: navigator,
        title: 'Flutter test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Splash(),
      ),
    );
  }
}
