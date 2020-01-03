import 'package:named_entities_extraction/entities/tagged_entity.dart';
import 'package:named_entities_extraction/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController animationController;
  List<TaggedEntity> taggedEntities;
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
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  // you can use this function to get data.
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  body(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'N E X',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          // i've added this widget to push the title to the middle
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget topBody(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 16),
            child: const Text(
              'Enter some Arabic text.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          _buildComposer(),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 8.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        if (_controller.text != null) {
                          print(_controller.text);
                          List<String> splitedText =
                              _splitText(_controller.text);
                          taggedEntities = tagEntities(splitedText);
                          _controller.text = "";
                        } else {
                          print('the text controller returned null');
                        }
                      });
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Send',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: Placeholder(color: Colors.blue),
          // ),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextField(
                controller: _controller,
                maxLines: null,
                onChanged: (String txt) {},
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'أدخل النص باللغة العربية'),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showResults() {
    if (taggedEntities == null) {
      return Container();
    } else {
      return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _buildItem(index);
            },
            itemCount: taggedEntities.length,
          ));
    }
  }

  Widget _buildItem(int index) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 0.75,
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
        child: ListTile(
          trailing: Text(taggedEntities[index].enitity),
          title: Text(taggedEntities[index].tag),
          leading: SizedBox(),
        ),
      ),
    );
  }

  Widget body() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          topBody(context),
          _showResults(),
        ],
      ),
    );
  }

  List<String> _splitText(String text) {
    return text.split(" ");
  }

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
