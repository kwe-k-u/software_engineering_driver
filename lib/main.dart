import 'package:vroom_core/environment.dart';
import 'package:bus_driver/screens/login_screen/login_screen.dart';
import 'package:bus_driver/screens/page_control/page_control.dart';
import 'package:vroom_core/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:vroom_core/models/app_state.dart';

void main() async {


  await dotenv.load(fileName: Environment.filename);

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp( name: "bus_driver",
        options:
        FirebaseOptions(
            apiKey: Environment.apiKey,
            appId: Environment.appId,
            messagingSenderId: Environment.messagingSenderId,
            projectId: Environment.productId
        )
    );
  }
  runApp(
    ChangeNotifierProvider<AppState>(
      create: (context)=> AppState(),
      child:  MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {

   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    context.read<AppState>().auth = FirebaseAuth.instance;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vroom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: MaterialColor(ashesiRed.value, {}),
        appBarTheme: const AppBarTheme(
          color: ashesiRed,
          centerTitle: true
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: ashesiRed
        )
      ),
      // home: SplashScreen(),
      home: const BaseScreen()
    );
  }
}



class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: context.read<AppState>().auth!.userChanges(),
          builder: (context,snapshot){

            if (snapshot.hasData) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              return const PageControl();
            }
            Navigator.of(context).popUntil((route) => route.isFirst);
            return const LoginScreen();
          },
        )
    );
  }
}
