

abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialLoadingState extends SocialStates {}

class SocialSuccessState extends SocialStates
{
  final String uId;
  SocialSuccessState(this.uId);
}

class SocialErrorState extends SocialStates {}

class SocialChangeBottomNavState extends SocialStates {}

class SocialAddPostState extends SocialStates {}

class SocialPickProfileImageSuccessState extends SocialStates {}

class SocialPickProfileImageErrorState extends SocialStates {}

class SocialPickCoverImageSuccessState extends SocialStates {}

class SocialPickCoverImageErrorState extends SocialStates {}








