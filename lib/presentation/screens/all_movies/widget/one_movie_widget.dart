import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/custom_text.dart';
import '../../../components/network_image.dart';
import '../cubit/all_movies_cubit.dart';

class OneMovieDesign extends StatelessWidget {
  const OneMovieDesign({
    Key? key,
    required this.cubit,
    required this.index,
  }) : super(key: key);

  final AllMoviesCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        NetworkImagesWidgets(
          cubit.movies[index].image ?? '',
          fit: BoxFit.fill,
          width: 300,
          height: 250,
        ),
        Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: AppColors.white.withOpacity(.2)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: CustomText(
                  cubit.movies[index].title ?? '',
                  color: AppColors.secondary,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    CustomText(
                      'Year: ',
                      color: AppColors.secondary,
                      maxLines: 1,
                      fontsize: 12,
                    ),
                    CustomText(
                      "${cubit.movies[index].year ?? ''}",
                      color: AppColors.secondary,
                      maxLines: 1,
                      fontsize: 12,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
