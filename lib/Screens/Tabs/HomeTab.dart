import 'package:asbar/Constants/styles.dart';
import 'package:asbar/Constants/values.dart';
import 'package:asbar/Providers/MainProvider.dart';
import 'package:asbar/Widgets/bigTexT.dart';
import 'package:asbar/Widgets/smallText.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.shortestSide;
    double height = MediaQuery.of(context).size.longestSide;

    MainProvider mainProvider = Provider.of<MainProvider>(context);
    MainProvider mainProviderFalse =
        Provider.of<MainProvider>(context, listen: false);

    int styleOptionsIndex = mainProvider.styleOptionsIndex;

    return Container(
      height: 75.h,
      padding: EdgeInsets.symmetric(horizontal: width * .05),
      child: Column(
        children: [
          SizedBox(
            height: 4.h,
          ),
          CustomContainer(
            height: 12,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    BigText(
                      text: 'Dr ibrahim ahmed',
                      size: 15,
                    ),
                    SmallText(
                      text: 'italian 2 - villa 224 ',
                      size: 13,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    BigText(
                      text: 'Status',
                      size: 16,
                    ),
                    SmallText(
                      text: 'Connected',
                      color: Colors.green,
                      size: 13,
                    ),
                  ],
                ),
              ]),
            ),
          ),
          Spacer(),
          CustomContainer(
            height: 27,
          ),
          Spacer(),
          CustomContainer(
            height: 27,
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final double height;

  final Widget? child;
  const CustomContainer({
    Key? key,
    required this.height,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: 100.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -1),
              blurRadius: 10,
              color: Colors.black.withOpacity(0.05),
            )
          ]),
      child: child,
    );
  }
}
