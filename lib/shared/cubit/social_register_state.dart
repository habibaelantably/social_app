

class SocialRegisterStates {}

class SocialIntialRegisterState extends SocialRegisterStates {}

class SocialLoadingRegisterstate extends SocialRegisterStates {}

class SocialSuccessRegisterState extends SocialRegisterStates{}

class SocialErrorRegisterState extends SocialRegisterStates {}

class SocialSuccessCreateState extends SocialRegisterStates{
  final String uId;
  SocialSuccessCreateState(this.uId);
}

class SocialErrorCreateState extends SocialRegisterStates {}

class SocialChangePasswordVisibilityRegisterState extends SocialRegisterStates {}





