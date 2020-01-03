import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:named_entities_extraction/entities/tag.dart';

import '../theme/app_theme.dart';

class TagsScreen extends StatefulWidget {
  @override
  _TagsScreenState createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  List<Tag> _tagsForDisplay = List<Tag>();
  List<Tag> _tags = List<Tag>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: AppBar().preferredSize.height + 8,
              ),
              getSearchBarUI(),
              // FutureBuilder(
              //     future: getData(),
              //     builder: (context, snapshot) {
              //       if (snapshot.data != null) {
              //         return Expanded(
              //           child: ListView.builder(
              //             itemBuilder: (context, index) {
              //               print(snapshot.data[index]["descreption"]);

              //               return item(
              //                 new Tag(
              //                   snapshot.data[index]["tag"],
              //                   snapshot.data[index]["descreption"],
              //                 ),
              //               );
              //             },
              //             itemCount: snapshot.data.length,
              //           ),
              //         );
              //       } else {
              //         return CircularProgressIndicator();
              //       }
              //     }),

              FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return item(index);
                          },
                          itemCount: _tagsForDisplay.length,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Tag>> getData() async {
    // here you can get data from your api
    dynamic data = await DefaultAssetBundle.of(context)
        .loadString("assets/tags_descreption.json");
    final jsonResult = json.decode(data);
    var tags = List<Tag>();
    // for (int i = 0; i < jsonResult.length; i++) {
    //   print(jsonResult[i]["tag"]);
    // }
    var result = await jsonResult;
    for (int i = 0; i < result.length; i++) {
      tags.add(new Tag(result[i]["tag"], result[i]["descreption"]));
    }
    for (var tag in tags) {
      print(tag.tag);
    }
    _tags = tags;
    if (_tagsForDisplay.isEmpty) {
      _tagsForDisplay = tags;
    }
    return tags;
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: Colors.grey[600],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                    ),
                    onChanged: (text) {
                      print('onChaged!');
                      text = text.toLowerCase();
                      setState(() {
                        _tagsForDisplay = _tags.where((tag) {
                          var t = tag.tag.toLowerCase();
                          print(t);
                          return t.contains(text);
                        }).toList();
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.search, size: 20, color: AppTheme.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget item(int index) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              offset: const Offset(4, 4),
              blurRadius: 8),
        ],
      ),
      child: ExpansionTile(
        title: Center(
            child: Text(
          '${_tagsForDisplay[index].tag}',
          style: AppTheme.headline,
        )),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '${_tagsForDisplay[index].descreption}',
              style: AppTheme.body1,
            ),
          ),
        ],
      ),
    );
  }
}
