import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universities/logic/bloc/auth_bloc.dart';
import 'package:universities/logic/bloc/dashboard_bloc.dart';
import 'package:universities/logic/bloc/form_bloc.dart';
import 'package:universities/logic/bloc/image_upload_bloc.dart';
import 'package:universities/logic/bloc/university_api_bloc.dart';
import 'package:universities/presentation/page/home_page.dart';
import 'package:universities/presentation/page/login_page.dart';
import 'package:universities/presentation/router/routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var instance = await SharedPreferences.getInstance();
  bool login = instance.getBool('login') ?? false;

  runApp(MyApp(login: login));
}

class MyApp extends StatelessWidget {
  final login;
  const MyApp({super.key, required this.login});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => AuthBloc())),
        BlocProvider(create: ((context) => ImageUploadBloc())),
        BlocProvider(create: ((context) => FormBloc())),
        BlocProvider(create: ((context) => DashBoardBloc())),
        BlocProvider(create: ((context) => UniversityApiBloc())),
      ],
      child: MaterialApp(
        
        title: 'Flutter Demo',
        home: login ? const HomePage() : const LoginPage(),
        routes: AppRoutes.appRoutes(context),
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
