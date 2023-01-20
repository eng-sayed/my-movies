import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neop_task/core/themes/colors.dart';
import 'package:neop_task/core/utiles/utiles.dart';
import 'package:neop_task/presentation/screens/all_movies/all_movies.dart';
import 'package:neop_task/presentation/screens/all_movies/cubit/all_movies_cubit.dart';
import 'package:neop_task/presentation/screens/movie_detailes/cubit/movie_detailes_cubit.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'cubit/app_cubit.dart';
import 'data/api/my_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static int view = 1;
  static PageController controllerPageView =
          PageController(viewportFraction: 1 / 3),
      controllerListView = PageController(viewportFraction: 1 / 5);
  static ValueNotifier<ThemeMode> theme =
      ValueNotifier<ThemeMode>(Utiles.appMode);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailesCubit>(
          create: (context) => MovieDetailesCubit(),
        ),
        BlocProvider<AllMoviesCubit>(
          create: (context) => AllMoviesCubit(),
        ),
        BlocProvider<AppCubit>(
          create: (context) => AppCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          Utiles.rebuildAllChildren(context);
          return MaterialApp(
            title: 'My Movies',
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
            ),
            theme: ThemeData(
                brightness: Brightness.light,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(backgroundColor: Colors.blueAccent)),
            themeMode: Utiles.appMode,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              final smartDialog = FlutterSmartDialog.init();
              child = smartDialog(context, child);

              return ResponsiveWrapper.builder(
                child,
                maxWidth: 1200,
                minWidth: 480,
                defaultScale: true,
                breakpoints: [
                  ResponsiveBreakpoint.resize(480, name: MOBILE),
                  ResponsiveBreakpoint.resize(800, name: TABLET),
                  ResponsiveBreakpoint.resize(1000,
                      name: DESKTOP, scaleFactor: 2),
                ],
              );
            },
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}
