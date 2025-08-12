import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';

class PostsModel extends Post {
  const PostsModel({
     int? id1,
    required String title1,
    required String body1,
  }) : super(id: id1,title: title1,body: body1);
  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(id1: json["id"], title1: json["title"], body1: json["body"]);
  }
  Map<String, dynamic> toJson( ) {
    return {'id': id, 'title':title, 'body': body};
  }
}
