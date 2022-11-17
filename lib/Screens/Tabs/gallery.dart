import 'package:asbar/Constants/colors.dart';
import 'package:asbar/Widgets/bigTexT.dart';
import 'package:asbar/Widgets/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class MyGallery extends StatelessWidget {
  const MyGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          GalleryPicCard(),
          SizedBox(
            height: 3.h,
          ),
          GalleryPicCard(),
          SizedBox(
            height: 3.h,
          ),
          GalleryPicCard(),
        ]),
      ),
    );
  }
}

class GalleryPicCard extends StatelessWidget {
  const GalleryPicCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 90.w,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.h)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Row(children: [
            SizedBox(
              width: 5.w,
            ),
            Container(
              height: 13.h,
              width: 15.h,
              child: Image.asset(
                'assets/female.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 7.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  text: 'Alin Alin',
                  size: 14,
                ),
                SmallText(text: '25 years'),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('View Case',style: TextStyle(color: kBlue1),),
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.h))),
                )
              ],
            ),
            Spacer(),
            SmallText(
              height: 1.5,
              textAlign: TextAlign.start,
              text: 'Date\n 10/08/2022',
              size: 9,
            ),
            SizedBox(width: 3.w)
          ]),
        ),
      ),
    );
  }
}
