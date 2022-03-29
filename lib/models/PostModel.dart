

class PostModel
{
  String? uId;
  String? userImage;
  String? name;
  String? dateTime;
  String? postText;
  String? postImage;


  PostModel({
    this.uId,
    this.userImage,
    this.name,
    this.dateTime,
    this.postText,
    this.postImage,
  });

  PostModel.fromJson(Map<String,dynamic>json)
  {
    uId=json['uId'];
    userImage=json['Userimage'];
    name=json['name'];
    dateTime=json['dateTime'];
    postText=json['postText'];
    postImage=json['postImage'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'uId':uId,
        'Userimage':userImage,
        'name':name,
        'dateTime':dateTime,
        'postText':postText,
        'postImage':postImage,
      };
  }
}