import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vindhi_app/core/api.dart';
import 'package:vindhi_app/core/routes.dart';
import 'package:vindhi_app/core/ui.dart';
import 'package:vindhi_app/data/repositories/main_repository.dart';
import 'package:vindhi_app/logic/cubit/banner%20cubit/banner_cubit.dart';
import 'package:vindhi_app/presentation/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BannerCubit(MainRepository(Api()))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vindhi',
        theme: Themes.defaultTheme,
        onGenerateRoute: Routes.onGenerateRoutes,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc: $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("Transition in $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}
