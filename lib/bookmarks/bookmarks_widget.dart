
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/model/searchmodel.dart';
import 'package:newsapp/utils/savedata.dart';

import '../utils/theme.dart';
import '../webview/webview_widget.dart';

class BookmarksWidget extends StatefulWidget {
  const BookmarksWidget({Key key}) : super(key: key);

  @override
  _BookmarksWidgetState createState() => _BookmarksWidgetState();
}

class _BookmarksWidgetState extends State<BookmarksWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: CustomTheme.of(context).primaryBackground,
        iconTheme: IconThemeData(color: CustomTheme.of(context).primaryText),
        automaticallyImplyLeading: true,
        title: Text(
          'book marks',
          style: CustomTheme.of(context).bodyText1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: CustomTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: FutureBuilder<List<Articles>>(
            future: BookmarksSave().getSP(),
            builder: (context, snapshot) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.length,
                scrollDirection: Axis.vertical,
                itemBuilder:  (context, index) => 
                snapshot.hasData ?
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebviewWidget(
                            url: snapshot.data[index].url,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(
                        snapshot.data[index].title,
                        style: CustomTheme.of(context).title3,
                      ),
                      subtitle: Text(
                        snapshot.data[index].description,
                        style: CustomTheme.of(context).subtitle2,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: CustomTheme.of(context).primaryText,
                        size: 20,
                      ),
                      tileColor: CustomTheme.of(context).primaryBackground,
                      dense: false,
                    ),
                  ) : CircularProgressIndicator(),
                
              );
            }
          ),
        ),
      ),
    );
  }
}
