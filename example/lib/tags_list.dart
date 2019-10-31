import 'package:flutter/material.dart';
import 'package:flutter_calamp_example/tag_row.dart';
import 'package:provider/provider.dart';

import 'package:flutter_calamp/flutter_calamp.dart';
import 'package:flutter_calamp/sci_tag.model.dart';

class TagsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
