import 'package:asbar/Constants/colors.dart';
import 'package:asbar/Providers/AuthProvider.dart';
import 'package:asbar/Scaffolds/AuthScaffold.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Providers/MainProvider.dart';
import 'Scaffolds/TabsScaffold.dart';
import 'firebase_options.dart';

final Future<FirebaseApp> _initialization = Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: FutureBuilder(

          ///Firebase Initialization
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Container(color: Colors.amber);
            if (snapshot.connectionState == ConnectionState.done) {
              return Sizer(
                builder: (context, orientation, deviceType) => MaterialApp(
                  title: 'Asbar',
                  routes: {
                    TabsScaffold.id: (context) => TabsScaffold(),
                    AuthScaffold.id: (context) => AuthScaffold(),
                  },
                  initialRoute: Provider.of<AuthProvider>(context).isLoggedIn
                      ? TabsScaffold.id
                      : AuthScaffold.id,
                ),
              );
            }
            return Container(color: kWhite);
          }),
    );
  }
}
