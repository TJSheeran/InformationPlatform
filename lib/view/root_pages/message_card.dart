import 'Mes.dart';
import 'package:flutter/material.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';

class MessageCard extends StatelessWidget {
  final Mes data;

  const MessageCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  Widget renderCover() {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        Positioned(
          left: 0,
          top: 100,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(80, 0, 0, 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget renderUserInfo() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFFCCCCCC),
                  backgroundImage: NetworkImage(
                    data.userImgUrl!)// "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg") //data.userImgUrl),
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
              children: <Widget>[
                    Text(
                    data.author!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColor.bluegreen,
                    ),
                  ),
                    Text(
                      " 回复了你",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:Colors.black.withOpacity(0.8),
                      ),
                    ),]),
                  Padding(padding: EdgeInsets.only(top: 2)),
                  Text(
                    data.createtime!, //data.description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderPublishContent() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              // Container(
              //   margin: EdgeInsets.only(bottom: 14),
              //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              //   decoration: BoxDecoration(
              //     color: AppColor.bluegreen,
              //     borderRadius: BorderRadius.only(
              //       topRight: Radius.circular(8),
              //       bottomLeft: Radius.circular(8),
              //       bottomRight: Radius.circular(8),
              //     ),
              //   ),
              //   child: Text(
              //     '#${data.label}', //data.topic}',
              //     style: TextStyle(
              //       fontSize: 12,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // Padding(padding: EdgeInsets.only(left: 10)),
              // Container(
              //   margin: EdgeInsets.only(bottom: 14),
              //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              //   decoration: BoxDecoration(
              //     color: AppColor.yellow,
              //     borderRadius: BorderRadius.only(
              //       topRight: Radius.circular(8),
              //       bottomLeft: Radius.circular(8),
              //       bottomRight: Radius.circular(8),
              //     ),
              //   ),
                // child: Text(
                //   '人数:${data.userNumber}', //data.topic}',
                //   style: TextStyle(
                //     fontSize: 12,
                //     color: Colors.white,
                //   ),
                // ),
              // ),
              // Padding(padding: EdgeInsets.only(left: 10)),
              // Container(
              //   margin: EdgeInsets.only(bottom: 14),
              //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              //   decoration: BoxDecoration(
              //     color: AppColor.bluegreen,
              //     borderRadius: BorderRadius.only(
              //       topRight: Radius.circular(8),
              //       bottomLeft: Radius.circular(8),
              //       bottomRight: Radius.circular(8),
              //     ),
              //   ),
                // child: Text(
                //   '活动时间:${data.activityDate}', //data.topic}',
                //   style: TextStyle(
                //     fontSize: 12,
                //     color: Colors.white,
                //   ),
                // ),
              // ),
            ],
          ),
          Text(
            data.content!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  // Future<bool> onLikeButtonTapped(bool isLiked) async {
  //   /// send your request here
  //   // final bool success= await sendRequest();
  //   final result = await DioUtil().request(
  //     "/update",
  //     method: DioMethod.post,
  //     data: {
  //       'id': data.id,
  //       'name': data.name,
  //       'text': data.text,
  //       'date': data.date,
  //       'likeCount': data.isLiked!
  //           ? isLiked
  //           ? data.likeCount! - 1
  //           : data.likeCount!
  //           : isLiked
  //           ? data.likeCount!
  //           : data.likeCount! + 1,
  //       'commentCount': data.commentCount,
  //       'isLiked': !isLiked,
  //       'isFollowed': data.isFollowed,
  //       'likedId': data.likedId,
  //       'commentId': data.commentId,
  //       'userid': data.userid,
  //       'label': data.label,
  //       'activityDate': data.activityDate,
  //       'userNumber': data.userNumber
  //     },
  //   );
  //
  //   /// if failed, you can do nothing
  //   if (result == "success")
  //     return !isLiked;
  //   else
  //     return isLiked;
  // }

  Widget renderInteractionArea() {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Row(
          //   children: <Widget>[
          //     // LikeButton(
          //     //   isLiked: data.isLiked!,
          //     //   likeBuilder: (bool isLiked) {
          //     //     return Icon(
          //     //       Icons.favorite,
          //     //       color: isLiked ? AppColor.danger : Colors.grey,
          //     //     );
          //     //   },
          //     //   likeCount: data.likeCount,
          //     //   onTap: onLikeButtonTapped,
          //     // ),
          //     // IconButton(
          //     //   icon: Icon(data.isLiked!?Icons.favorite : Icons.favorite_border),
          //     //   iconSize: 20,
          //     //   color: AppColor.danger,
          //     //   onPressed: (){
          //     //   },
          //     // ),
          //     // Padding(padding: EdgeInsets.only(left: 6)),
          //     // Text(
          //     //   data.likeCount.toString(),
          //     //   style: TextStyle(
          //     //     fontSize: 18,
          //     //     color: Color(0xFF999999),
          //     //   ),
          //     // ),
          //   ],
          // ),
          Row(
            children: <Widget>[
              Icon(
                Icons.message,
                size: 18,
                color: Colors.black.withOpacity(0.6),
              ),
              Padding(padding: EdgeInsets.only(left: 6)),
              Text(
                data.tiezititle!,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
          // Row(
          //   children: <Widget>[
          //     Icon(
          //       Icons.share,
          //       size: 16,
          //       color: Color(0xFF999999),
          //     ),
          //     Padding(padding: EdgeInsets.only(left: 6)),
          //     Text(
          //       data.shares.toString(),
          //       style: TextStyle(
          //         fontSize: 15,
          //         color: Color(0xFF999999),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 4,
            color: Color.fromARGB(20, 0, 0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          this.renderCover(),
          this.renderUserInfo(),
          this.renderPublishContent(),
          SizedBox(
            height: 5,
          ),
          Divider(
              height: 10.0,
              thickness: 1.0,
              indent: 5.0,
              endIndent: 5.0,
              color: AppColor.grey),
          this.renderInteractionArea(),
        ],
      ),
    );
  }
}