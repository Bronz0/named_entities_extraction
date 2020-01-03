class Tag{
  String tag;
  String descreption;
  Tag(this.tag, this.descreption);

  Tag.fromJson(Map<String, dynamic> json){
    tag = json['tag'];
    descreption = json['descreption'];
  }
}