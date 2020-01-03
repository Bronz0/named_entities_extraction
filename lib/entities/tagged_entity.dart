class TaggedEntity{
  String enitity;
  String tag;
  TaggedEntity(this.enitity,this.tag, );

  TaggedEntity.fromJson(Map<String, dynamic> json){
    enitity = json['entity'];
    tag = json['tag'];
  }
}