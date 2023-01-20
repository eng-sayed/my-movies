import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neop_task/core/themes/colors.dart';
import 'package:neop_task/core/utiles/navigate.dart';
import 'package:neop_task/core/utiles/utiles.dart';
import 'package:neop_task/presentation/components/loadinganderror.dart';
import 'package:neop_task/presentation/screens/all_movies/cubit/all_movies_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/app_cubit.dart';
import '../../components/custom_text.dart';
import '../../components/default_text_field.dart';
import '../../components/network_image.dart';
import '../movie_detailes/movie_detailes.dart';
import 'widget/one_movie_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = AllMoviesCubit.get(context);
      await cubit.getAllMovies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllMoviesCubit, AllMoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = AllMoviesCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: CustomText(
                'My Movies',
                color: Colors.white,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () {
                      cubit.changeMode(context);
                    },
                    icon: Icon(
                      (Utiles.appMode == ThemeMode.dark)
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      color: AppColors.secondary,
                    ),
                    color: AppColors.secondary,
                  ),
                )
              ],
              elevation: 0.0,
            ),
            body: LoadingAndError(
                isError: state is AllMoviesError,
                isLoading: state is AllMoviesLoading,
                function: () async {
                  cubit.getAllMovies();
                },
                child: Column(
                  children: [
                    TextFeildWithCustomValidation(
                      hintText: "Search Such as 'Harry Potter'",
                      height: 50,
                      color: Colors.white,
                      validate: (p0) {},
                      keyboardType: TextInputType.multiline,
                      onChange: (p) {
                        cubit.onChangeHandler(p);

                        print(p);
                      },
                    ),
                    Expanded(
                      child: cubit.movies.isEmpty
                          ? Center(
                              child: Lottie.asset(
                              "assets/json/empty.json",
                            ))
                          : GridView.builder(
                              physics: const PageScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: cubit.movies.length,
                              padding: const EdgeInsets.all(8.0),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      navigate(
                                          context: context,
                                          route: MovieDetailes(
                                            movieId:
                                                cubit.movies[index].id ?? '',
                                          ));
                                    },
                                    child: OneMovieDesign(
                                        cubit: cubit, index: index),
                                  ),
                                );
                              }),
                    )
                  ],
                )));
      },
    );
  }
}
