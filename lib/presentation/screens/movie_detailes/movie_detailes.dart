import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:neop_task/core/themes/colors.dart';
import 'package:neop_task/core/utiles/responsive.dart';
import 'package:neop_task/presentation/components/custom_text.dart';
import 'package:neop_task/presentation/components/loadinganderror.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neop_task/presentation/components/network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cubit/movie_detailes_cubit.dart';

class MovieDetailes extends StatefulWidget {
  MovieDetailes({super.key, required this.movieId});
  String movieId;
  @override
  State<MovieDetailes> createState() => _MovieDetailesState();
}

class _MovieDetailesState extends State<MovieDetailes> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = MovieDetailesCubit.get(context);
      await cubit.getOneMovie(widget.movieId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDetailesCubit, MovieDetailesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = MovieDetailesCubit.get(context);

        return Scaffold(
          //   appBar: AppBar(),
          body: SafeArea(
            child: LoadingAndError(
              isError: state is MovieDetailesError,
              isLoading: state is MovieDetailesLoading,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.black,
                              )),
                          SizedBox(
                            width: 400.w,
                            // height: 50,
                            child: CustomText(
                              cubit.movieDetailesModel?.title ?? '',
                              color: AppColors.black,
                              textStyleEnum: TextStyleEnum.title,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    NetworkImagesWidgets(
                      cubit.movieDetailesModel?.image ?? '',
                      height: 400.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating:
                            (cubit.movieDetailesModel?.rating?.star ?? 0)
                                .toDouble(),
                        unratedColor: AppColors.grey.withOpacity(.5),
                        itemSize: 18,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 10,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    CustomText(
                      'Description',
                      color: AppColors.secondary,
                      textStyleEnum: TextStyleEnum.title,
                      fontsize: 22,
                    ),
                    CustomText(
                      cubit.movieDetailesModel?.plot ?? '',
                      color: AppColors.black,
                      textStyleEnum: TextStyleEnum.normal,
                      fontsize: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: 300.w,
                        child: Divider(color: AppColors.black),
                      ),
                    ),
                    CustomText(
                      'Genre',
                      color: AppColors.secondary,
                      textStyleEnum: TextStyleEnum.title,
                      fontsize: 22,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 52),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.movieDetailesModel?.genre?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.black.withOpacity(.2)),
                              // height: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  cubit.movieDetailesModel?.genre?[index] ?? '',
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 300.w,
                        child: Divider(color: AppColors.black),
                      ),
                    ),
                    CustomText(
                      'Actors',
                      color: AppColors.secondary,
                      textStyleEnum: TextStyleEnum.title,
                      fontsize: 22,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 52),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.movieDetailesModel?.actors?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.black.withOpacity(.2)),
                              // height: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  cubit.movieDetailesModel?.actors?[index] ??
                                      '',
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 300.w,
                        child: Divider(color: AppColors.black),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          String url = cubit.movieDetailesModel?.imdb ?? '';
                          if (await canLaunchUrl(Uri.tryParse(url) ?? Uri())) {
                            await launchUrl(Uri.tryParse(url) ?? Uri());
                          } else {
                            throw 'Could not launch ${url}';
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.black.withOpacity(.2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              'Visit Site',
                              color: AppColors.black,
                              textStyleEnum: TextStyleEnum.title,
                              fontsize: 22,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
