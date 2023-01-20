import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'custom_text.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset("assets/json/empty.json"),
          SizedBox(
            height: 20,
          ),
          CustomText(
            "No Data Found",
            textStyleEnum: TextStyleEnum.title,
          ),
        ],
      ),
    );
  }
}
