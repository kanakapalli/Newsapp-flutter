import 'dart:convert';

import 'package:newsapp/utils/savedata.dart';

import '../backend/api_requests/api_calls.dart';

import '../model/searchmodel.dart';
import '../utils/theme.dart';
import '../utils/util.dart';
import '../webview/webview_widget.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: CustomTheme.of(context).primaryBackground,
        iconTheme: IconThemeData(color: CustomTheme.of(context).primaryText),
        automaticallyImplyLeading: true,
        title: Text(
          'everything',
          style: CustomTheme.of(context).bodyText1,
        ),
        actions: [
          InkWell(
            onTap: () async {
              setDarkModeSetting(context, ThemeMode.light);
            },
            child: Icon(
              Icons.wb_sunny,
              color: CustomTheme.of(context).primaryText,
              size: 24,
            ),
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: CustomTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        onChanged: (_) => EasyDebounce.debounce(
                          'textController',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'search',
                          hintText: 'search ',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: CustomTheme.of(context).bodyText2.override(
                              fontFamily: 'Poppins',
                              fontSize: 9,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<ApiCallResponse>(
                  future: GeteverthingCall.call(
                    search: valueOrDefault<String>(
                      textController.text,
                      'bitcoin',
                    ),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: CustomTheme.of(context).primaryColor,
                          ),
                        ),
                      );
                    }
                    final listViewGeteverthingResponse = snapshot.data;
                    return Builder(
                      builder: (context) {
                        final overview = (getJsonField(
                                  (listViewGeteverthingResponse?.jsonBody ??
                                      ''),
                                  r'''$.articles''',
                                )?.toList() ??
                                [])
                            .take(30)
                            .toList();
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: overview.length,
                          itemBuilder: (context, overviewIndex) {
                            final overviewItem = overview[overviewIndex];
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebviewWidget(
                                        url: getJsonField(
                                          overviewItem,
                                          r'''$.url''',
                                        ).toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    getJsonField(
                                      overviewItem,
                                      r'''$.title''',
                                    ).toString(),
                                    style: CustomTheme.of(context).title3,
                                  ),
                                  subtitle: Text(
                                    getJsonField(
                                      overviewItem,
                                      r'''$.description''',
                                    ).toString(),
                                    style: CustomTheme.of(context).subtitle2,
                                  ),
                                  trailing: InkWell(
                                    onTap: () {
                                      print('he==========re');
                                      var a = search.fromJson(
                                          listViewGeteverthingResponse
                                              .jsonBody);
                                      print(a.articles[overviewIndex]);
                                      BookmarksSave().addToSP(
                                          a.articles[overviewIndex]);
                                      // print(listViewGeteverthingResponse
                                      //     .jsonBody);
                                    },
                                    child: Icon(
                                      Icons.bookmark,
                                      color:
                                          CustomTheme.of(context).primaryText,
                                      size: 20,
                                    ),
                                  ),
                                  tileColor:
                                      CustomTheme.of(context).primaryBackground,
                                  dense: false,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
