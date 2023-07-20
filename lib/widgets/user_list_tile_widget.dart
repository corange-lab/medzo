import 'package:flutter/material.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/model/users_filter_search_respons.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/widgets/user_profile_widget.dart';

class UserListTile extends StatelessWidget {
  UserFilterSearchModel user;
  UserListTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.lightGrey)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserProfileWidget(
                    userModel: UserModel(
                        name: user.name, profilePicture: user.profilePicture),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 5, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width / 2,
                              child: Text(
                                user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        fontSize: 15,
                                        color: AppColors.darkBlue,
                                        fontWeight: FontWeight.w700),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: size.width / 2,
                              child: Text(
                                "${double.tryParse((user.distance).toStringAsFixed(2))} km away",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        fontSize: 13,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w400),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
