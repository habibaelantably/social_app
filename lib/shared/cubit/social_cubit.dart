

//import 'dart:html';
import 'dart:io';


import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/components/constants.dart';
import 'package:social_app/components/reusable_components.dart';
import 'package:social_app/models/CommentsModel.dart';
import 'package:social_app/models/MessageModel.dart';
import 'package:social_app/models/PostModel.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/AddPosts.dart';
import 'package:social_app/modules/chats_screen.dart';
import 'package:social_app/modules/feeds_screen.dart';
import 'package:social_app/modules/settings_screen.dart';
import 'package:social_app/modules/social_login.dart';
import 'package:social_app/modules/users_screen.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../network/local/cache_helper.dart';



class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context)=>BlocProvider.of(context);

  UserModel?  socialModel;

  void  getUserdata() {
    FirebaseFirestore.instance.
        collection('users').
        doc(uId).
        get().
        then((value){
          print(value.data());
          socialModel=UserModel.fromJson(value.data()!);
          emit(SocialSuccessState('uId'));
        }).
        catchError((error){
          print(error.toString());
          emit(SocialErrorState());
        });

  }
//getUserData de el 4a8ala 7elw w 7atenaha hena 3a4an han8yr 4wyt 7agat b2a f el fo2
  // emit(SocialLoadingState());
  //
  //     FirebaseFirestore.instance.
  //     collection('users').
  //     doc(uId).
  //     get().
  //     then((value){
  //       print(value.data());
  //       socialModel=UserModel.fromJson(value.data()!);
  //       emit(SocialSuccessState('uId'));
  //     }).
  //     catchError((error){
  //       print(error.toString());
  //       emit(SocialErrorState());
  //     });
  // print(value.data());
  //       socialModel=UserModel.fromJson(value.data()!);
  //       emit(SocialSuccessState('uId'));
  int currentIndex=0;

  List<Widget> screens=
  [
    FeedsScreen(),
    UsersScreen(),
    addPostsScreen(),
    ChatsScreen(),
    SettingsScreen()
  ];
  List<String> titles=
  [
    'Home',
    'users',
    'posts',
    'Chats',
    'Settings'
  ];

  void changeBottomNav(int index)
  {
    if(index==3){
      getAllUsers();
    }
    if(index==2) {
      emit(SocialAddPostState());
    }
    else
      {
        currentIndex = index;
        emit(SocialChangeBottomNavState());
      }

  }
  
   File? profileImage;
   var picker=ImagePicker();

  Future<void> getProfileImage()async{

       final pickedFile=await picker.pickImage(source: ImageSource.gallery);

      if(pickedFile != null) {
        profileImage = File(pickedFile.path);
        print('Image selected');
        print(pickedFile.path);
        emit(SocialPickProfileImageSuccessState());
      }else
        {
        print('no image picked');
        emit(SocialPickProfileImageErrorState());
      }
    }


 File? coverImage;

  Future<void> getCoverImage()async
  {
    //var picker=ImagePicker();

    //final profileImage=await ImagePicker().pickImage(source: ImageSource.gallery);
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      coverImage=File(pickedFile.path);
      print('Image selected');
      emit(SocialPickCoverImageSuccessState());
    }else
    {
      print('no image picked');
      emit(SocialPickCoverImageErrorState());

    }
  }

  List<PostModel> posts=[];
  List<String> postId=[];


  void getPosts(){
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots().listen((event) {
      event.docs.forEach((element){
        element.reference.
        collection('likes').
        snapshots().listen((event) {
          likes.add(event.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostsSuccessState());
        });
      });
    });


  }
  //original getposts
//FirebaseFirestore.instance
//         .collection('posts')
//         .get().then((value)
//     {
//       value.docs.forEach((element){
//         element.reference.
//         collection('likes').
//         get().then((value){
//           likes.add(value.docs.length);
//           postId.add(element.id);
//           posts.add(PostModel.fromJson(element.data()));
//           emit(SocialGetPostsSuccessState());
//         }).catchError((error){});
//      });
//     })
//         .catchError((error){
//           emit(SocialGetPostsErrorState());
//     });


  void getComments(String? postId){
    emit(SocialGetCommentLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments').snapshots().listen((event) {
      comments.clear();
      event.docs.forEach((element) {
            comments.add(CommentsModel.fromJson(element.data()));
          });
          emit(SocialGetCommentSuccessState());
    });

  }


  //String profileImageUrl='';

  void upLoadProfileImage({
    required String name,
    required String bio,
    required String phone,
})
  {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().
    child('users/${Uri.file(profileImage!.path).pathSegments.last}').
    putFile(profileImage!).
    then((value) {
      value.ref.getDownloadURL().
      then((value) {
       // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, bio: bio, phone: phone,image: value);
        //profileImageUrl=value;
      }).
      catchError((error){
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error){
      emit(SocialUploadProfileImageErrorState());
    });
  }

  //String coverImageUrl='';

  void upLoadCoverImage({
    required String name,
    required String bio,
    required String phone,
})
  {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().
    child('users/${Uri.file(coverImage!.path).pathSegments.last}').
    putFile(coverImage!).
    then((value) {
      value.ref.getDownloadURL().
      then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, bio: bio, phone: phone,cover: value);
       // coverImageUrl=value;
      }).
      catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }

//   void updateUserImages({
//   required String name,
//     required String bio,
//     required String phone
// })
//   {
//     emit(SocialUpdateUserLoadingState());
//
//     if(profileImage != null)
//     {
//       upLoadProfileImage();
//     }
//     else if(coverImage !=null)
//     {
//       upLoadCoverImage();
//     }
//     else if(profileImage != null && coverImage !=null)
//     {
//
//     }else
//       {
//         updateUser(name: name, bio: bio, phone: phone);
//       }
//
//   }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
})
{
UserModel model=UserModel
(
uId: socialModel!.uId,
name:name,
phone:phone,
email: socialModel!.email,
image:image??socialModel!.image,

);

FirebaseFirestore.instance.
collection('users').
doc(socialModel!.uId).
update(model.toMap()).then((value)
{
  getUserdata();
}).
catchError((error){
print(error.toString());
emit(SocialUpdateUserErrorState());
});
}


     File? postImage;

  Future<void> getPostImage()async{

     final pickedFile= await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null) {
      postImage = File(pickedFile.path);
      print('Image selected');
      emit(SocialUploadProfileImageSuccessState());
    }else
    {
      print('no image picked');
      emit(SocialUploadPostImageErrorState());
    }
  }


  void  createNewPostImage({
    // required String uId,
    // required String userImage,
    // required String name,
    required String dateTime,
    required String postText,
  })
  {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().
    child('posts/${Uri.file(postImage!.path).pathSegments.last}').
    putFile(postImage!).
    then((value) {
      value.ref.getDownloadURL().
      then((value) {
        print(value);
        createNewPost(dateTime: dateTime, postText: postText,postImage: value);
        emit(SocialUploadPostImageSuccessState());

      }).
      catchError((error){
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  void removeImage()
  {
    postImage=null;
    emit(SocialRemoveImageState());
  }

  void createNewPost({
    required String dateTime,
    required String postText,
    String? postImage,
  })
  {
    emit(SocialCreatePostLoadingState());

    PostModel model=PostModel
      (
        uId: socialModel!.uId,
        userImage:socialModel!.image,
        name:socialModel!.name,
        dateTime:dateTime,
        postText: postText,
        postImage: postImage??''
    );

    FirebaseFirestore.instance.
    collection('posts').
    // doc('1').
    add(model.toMap()).then((value)
    {
      emit(SocialCreatePostSuccessState());

    }).
    catchError((error){
      print(error.toString());
      emit(SocialCreatePostErrorState() );
    });
  }

  List<int> likes=[];
  void postLikes(String postId)
  {
    FirebaseFirestore.instance.
    collection('posts').
    doc(postId).
    collection('likes').
    doc(socialModel!.uId).
    set({'like': true}).
    then((value){
      emit(SocialLikePostsSuccessState());
    }).
    catchError((error){
      emit(SocialLikePostsErrorState());
    });
  }


   void  emitFirstState(){
    emit(SocialButtonActivationState());
  }

  void emitSecondState(){
    emit(SocialButtonDeactivatedState());
  }
  List<CommentsModel> comments=[];
  //List<int> commentsId=[];
  //List<int> commentsCount=[];
  void comment({required String? postId,String? text}){

    CommentsModel model=CommentsModel(
      name: socialModel!.name,
      image: socialModel!.image,
      text: text,
    );
    FirebaseFirestore.instance.
    collection('posts').
    doc(postId).
    collection('comments').
    //doc(socialModel!.uId).
    add(model.toMap()).then((value) {
      emit(SocialCommentSuccessState());
    }).catchError((error){
      emit(SocialCommentErrorState());
    });
  }


  List<UserModel> allUsers=[];

   void getAllUsers()
   {
     if(allUsers.length==0)
     FirebaseFirestore.instance
         .collection('users')
         .get().then((value) {
       value.docs.forEach((element) {
         if(element.data()['uId'] != socialModel!.uId)
         allUsers.add(UserModel.fromJson(element.data()));
         emit(SocialGetAllUsersSuccessState());
       });
     })
         .catchError((error){
       emit(SocialGetAllUsersErrorState(error.toString()));
     });
  }
  
  void sendMessages({
  required String? receiverId,
  required String? dateTime,
  required String? text
}){
     MessageModel model=MessageModel(
       senderId:socialModel!.uId,
       recieverId: receiverId,
       dateTime: dateTime,
       text: text
     );
     
     FirebaseFirestore.instance.
     collection("users").
     doc(socialModel!.uId).
     collection("chats").
     doc(model.recieverId).
     collection("messages").
     add(model.toMap()).then((value){
       emit(SocialSendMessagesSuccessState());
     }).catchError((error){
       emit(SocialSendMessagesErrorState());
     });

     FirebaseFirestore.instance.
     collection("users").
     doc(receiverId).
     collection("chats").
     doc(socialModel!.uId).
     collection("messages").
     add(model.toMap()).then((value){
       emit(SocialSendMessagesSuccessState());
     }).catchError((error){
       emit(SocialSendMessagesErrorState());
     });
  }

  List<MessageModel> messages=[];

   void getMessages({
  required String? receiverId
}){
     FirebaseFirestore.instance.
     collection("users").
     doc(socialModel!.uId).
     collection("chats").
     doc(receiverId).
     collection("messages").orderBy('dateTime').
     snapshots().
     listen((event) {
       messages=[];
       event.docs.forEach((element) {
         messages.add(MessageModel.fromJson(element.data()));
       });
       emit(SocialGetAllMessagesSuccessState());
     });


   }

  void logOut(context)
  {
    FirebaseAuth.instance.signOut().then((value) {
     NavigateAndKill(context, LoginScreen());
     CacheHelper.removeData(key: 'uId');
      emit(SocialLogOutSuccessState());
      //ListenState();
      print(uId);

    }).catchError((error){
      emit(SocialLogOutErrorState());
    });
  }



}