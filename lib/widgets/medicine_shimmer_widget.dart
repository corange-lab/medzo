import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/assets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MedicineShimmerWidget extends StatelessWidget {
  final int itemCount;
  final double height;

  const MedicineShimmerWidget(
      {super.key, this.itemCount = 3, this.height = 400});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Column(
              children: [
                // Replace this with your Shimmer placeholder widgets
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          leading: CircleAvatar(),
                          trailing: SvgPicture.asset(SvgIcon.fillbookmark),
                          title: Text("MEDZO"),
                        ),
                      ),
                      Container(
                        height: 10.h,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.whitehome),
                      )
                    ],
                  ),
                  margin: EdgeInsets.all(3),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Divider(
                    height: 3,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class PostShimmerWidget extends StatelessWidget {
  final int itemCount;
  final double height;

  const PostShimmerWidget({super.key, this.itemCount = 3, this.height = 400});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            // Replace this with your Shimmer placeholder widgets
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      leading: CircleAvatar(),
                      trailing: SvgPicture.asset(SvgIcon.fillbookmark),
                      title: Text("MEDZO"),
                    ),
                  ),
                  Container(
                    height: 10.h,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.whitehome),
                  )
                ],
              ),
              margin: EdgeInsets.all(3),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Divider(
                height: 3,
              ),
            ),
          ],
        ));
  }
}

class CommentShimmerWidget extends StatelessWidget {
  final int itemCount;
  final double height;

  const CommentShimmerWidget(
      {super.key, this.itemCount = 3, this.height = 400});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            // Replace this with your Shimmer placeholder widgets
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      leading: CircleAvatar(),
                      trailing: SvgPicture.asset(SvgIcon.fillbookmark),
                      title: Text("MEDZO"),
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.all(3),
            ),
          ],
        ));
  }
}
