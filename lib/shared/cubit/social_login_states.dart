
abstract class SocialLoginStates {}

class SocialLoginIntialState extends SocialLoginStates{}

class SocialLoginLoadingstate extends SocialLoginStates{}

class SocialLoginSuccessState extends SocialLoginStates
{
  final String uId;
  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates
{
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialLoginChangePasswordVisibilityState extends SocialLoginStates {}





