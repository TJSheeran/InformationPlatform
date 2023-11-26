class Mes{
  String?author;
  String?createtime;
  String?content;
  int?id;
  String?tiezititle;

  Mes(this.author,this.createtime,this.content,this.id,this.tiezititle);

}
List<Mes> convertMes(var received_data)
{
  List activity = received_data;
  List<Mes> act=[];
  for(int i = 0;i < activity.length;i++)
  {
    act.add(Mes(activity[i]['author'],activity[i]['createtime'],activity[i]['content'],
       activity[i]['id'], activity[i]['tiezititle']));
  }
  //print(act[0].name);
  return act;
}
void News_print(Mes news)
{
  print('name:${news.author},date:${news.createtime},text:${news.content},userid:${news.id},label:${news.tiezititle}');
}