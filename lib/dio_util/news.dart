class News{
  int?id;
  String?name;
  String?date;
  String?text;
  int?likeCount;
  int?commentCount;
  bool?isLiked;
  bool?isFollowed;
  String?likedId;
  String?commentId;
  int?userid;
  String?label;
  String?activityDate;
  int?userNumber;

  News(this.id,this.name,this.date,this.text,this.likeCount,this.commentCount,this.isLiked,this.isFollowed,this.likedId,this.commentId,this.userid,this.label,this.activityDate,this.userNumber);

}
List<News> convertNews(var received_data)
{
  List activity = received_data['list'];
  List<News> act=[];
  for(int i = 0;i < activity.length;i++)
  {
    act.add(News(activity[i]['id'],activity[i]['name'],activity[i]['date'],activity[i]['text'],
        activity[i]['likeCount'],activity[i]['commentCount'],activity[i]['liked'],
        activity[i]['followed'],activity[i]['likedId'],activity[i]['commentId'],activity[i]['userid'],
        activity[i]['label'],activity[i]['activityDate'],activity[i]['userNumber']));
  }
  //print(act[0].name);
  return act;
}
void News_print(News news)
{
  print('id:${news.id},name:${news.name},date:${news.date},text:${news.text},likeCount:${news.likeCount},'
      'commentCount:${news.commentCount},isLiked:${news.isLiked},isFollowed:${news.isFollowed},likedId:${news.likedId},'
      'commentId:${news.commentId},userid:${news.userid},label:${news.label},activityDate:${news.activityDate},userNumber:${news.userNumber}');
}