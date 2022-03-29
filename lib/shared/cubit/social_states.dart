

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

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialPickCoverImageSuccessState extends SocialStates {}

class SocialPickCoverImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUpdateUserLoadingState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialUploadPostImageSuccessState extends SocialStates {}

class SocialUploadPostImageErrorState extends SocialStates {}

class SocialRemoveImageState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {}

class SocialLikePostsSuccessState extends SocialStates {}

class SocialLikePostsErrorState extends SocialStates {}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialSendMessagesSuccessState extends SocialStates {}

class SocialSendMessagesErrorState extends SocialStates {

}
class SocialGetAllMessagesSuccessState extends SocialStates {}

class SocialCommentSuccessState extends SocialStates {}

class SocialCommentErrorState extends SocialStates {}

class SocialGetCommentSuccessState extends SocialStates {}

class SocialGetCommentLoadingState extends SocialStates {}

class SocialGetCommentErrorState extends SocialStates {}

class SocialButtonActivationState extends SocialStates {}

class SocialButtonDeactivatedState extends SocialStates {}

class SocialLogOutSuccessState extends SocialStates {}

class SocialLogOutErrorState extends SocialStates {}











