import 'dart:math';

import 'package:named_entities_extraction/entities/tagged_entity.dart';

class LocalDataSource {
  final List<String> tags = [
    'PERSON',
    'ORG',
    'DATE',
    'OLOC',
    'LCLUE',
    'PCLUE',
    'DCLUE',
    'OTHER',
    'PREP',
    'DEF',
    'CONJ'
  ];
  final Random rand = new Random();

  List<TaggedEntity> tagEntities(List<String> entities) {
    List<TaggedEntity> _taggedEntities = new List<TaggedEntity>();
    for (var entity in entities) {
      if (entity != '' && entity != ' ' && entity != null && entity != '\n') {
        _taggedEntities.add(new TaggedEntity(entity, tags[rand.nextInt(11)]));
      }
    }
    return _taggedEntities;
  }
}
