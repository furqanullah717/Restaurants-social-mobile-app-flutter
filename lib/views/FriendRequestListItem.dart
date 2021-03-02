import 'package:Restaurant_social_mobile_app/data/model/User.dart';
import 'package:Restaurant_social_mobile_app/utils/Styles.dart';
import 'package:Restaurant_social_mobile_app/widget/ImageView.dart';
import 'package:Restaurant_social_mobile_app/widget/ListItemButton.dart';
import 'package:flutter/material.dart';

class FriendRequestListItem extends StatelessWidget {
  final UserResponse user;
  final Function accept;
  final Function reject;
  final String id;

  FriendRequestListItem(this.user, this.id, this.accept, this.reject);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      margin: EdgeInsets.all(10),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: ImageView(user.profilePic)),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  direction: Axis.vertical,
                  children: [
                    Text(
                      user.name,
                      style: Styles.headStyle,
                    ),
                    Text(
                      user.username,
                      style: Styles.style,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListItemButton(
                        () => {accept(user, id)}, Colors.green, "Accept"),
                    SizedBox(
                      height: 5,
                    ),
                    ListItemButton(
                        () => {reject(user, id)}, Colors.red, "Reject"),
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
