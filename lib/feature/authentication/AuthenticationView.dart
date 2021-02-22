import 'package:Restaurant_social_mobile_app/data/model/User.dart';

abstract class AuthenticationView {
  onLoad(String msg);

  onclick(bool res);

  onSuccess(UserResponse response);

  onFailed(UserResponse response);
}