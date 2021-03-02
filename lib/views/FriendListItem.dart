import 'package:Restaurant_social_mobile_app/data/model/User.dart';
import 'package:Restaurant_social_mobile_app/utils/Styles.dart';
import 'package:Restaurant_social_mobile_app/widget/ImageView.dart';
import 'package:flutter/material.dart';

class FriendListItem extends StatelessWidget {
 final UserResponse user;
  FriendListItem(this.user);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ImageView(user.profilePic),
              ),
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
                        style:Styles.headStyle,
                      ),
                      Text(
                        user.username,
                        style: Styles.style,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
