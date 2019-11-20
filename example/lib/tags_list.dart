import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calamp_example/tag_row.dart';
import 'package:provider/provider.dart';

import 'package:flutter_calamp/flutter_calamp.dart';
import 'package:flutter_calamp/sci_tag.model.dart';

class TagsList extends StatefulWidget {
  @override
  _TagsListState createState() => _TagsListState();
}

class _TagsListState extends State<TagsList> {

  StreamSubscription _listener;

  @override
  void initState() {
    super.initState();
    _runListener();
  }

  Future<void> _runListener() async {
    await Future.delayed(Duration.zero);
    // you can listen for stream changes in FlutterCalamp and manipulate with it somehow
    _listener = Provider.of<FlutterCalamp>(context).stream$.listen((tags) {
      List<String> _tags = [];
      tags.forEach((tag) {
        if (_tags.indexOf(tag.id) == -1) {
          _tags.add(tag.id);
        }
      });
      print(_tags);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('${_tags.length} Tags detected'),));
    });
  }

  @override
  void dispose() {
    // dont forget to cancel your StreamSubscriptions
    _listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // you can use StreamBuilder for render data inside widgets
    return StreamBuilder(
      stream: Provider.of<FlutterCalamp>(context).stream$,
      builder: (BuildContext context, AsyncSnapshot<List<SCITag>> snapshot) {
        if (snapshot.error != null) {
          return Text(snapshot.error);
        }
        if (snapshot.data != null) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final tag = snapshot.data[index];
              return TagRow(
                tag: tag,
              );
            },
            itemCount: snapshot.data.length,
          );
        }
        return Text('Waiting for tags.....');
      },
    );
  }
}
