import '../backend/api_requests/api_calls.dart';
import '../utils/theme.dart';
import '../utils/util.dart';
import '../webview/webview_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingWidget extends StatefulWidget {
  const HeadingWidget({Key key}) : super(key: key);

  @override
  _HeadingWidgetState createState() => _HeadingWidgetState();
}

class _HeadingWidgetState extends State<HeadingWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiCallResponse>(
      future: GettopheadingCall.call(
        country: 'us',
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
        final headingGettopheadingResponse = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: CustomTheme.of(context).primaryBackground,
            iconTheme:
                IconThemeData(color: CustomTheme.of(context).primaryText),
            automaticallyImplyLeading: true,
            title: Text(
              'top headings',
              style: CustomTheme.of(context).bodyText1,
            ),
            actions: [
              InkWell(
                onTap: () async {
                  setDarkModeSetting(context, ThemeMode.dark);
                },
                child: FaIcon(
                  FontAwesomeIcons.moon,
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
              child: FutureBuilder<ApiCallResponse>(
                future: GettopheadingCall.call(
                  country: 'us',
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
                  final listViewGettopheadingResponse = snapshot.data;
                  return Builder(
                    builder: (context) {
                      final topheadings = (getJsonField(
                                (listViewGettopheadingResponse?.jsonBody ?? ''),
                                r'''$.articles''',
                              )?.toList() ??
                              [])
                          .take(30)
                          .toList();
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: topheadings.length,
                        itemBuilder: (context, topheadingsIndex) {
                          final topheadingsItem = topheadings[topheadingsIndex];
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebviewWidget(
                                      url: getJsonField(
                                        topheadingsItem,
                                        r'''$.url''',
                                      ).toString(),
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  getJsonField(
                                    topheadingsItem,
                                    r'''$.title''',
                                  ).toString(),
                                  style: CustomTheme.of(context).title3,
                                ),
                                subtitle: Text(
                                  getJsonField(
                                    topheadingsItem,
                                    r'''$.description''',
                                  ).toString(),
                                  style: CustomTheme.of(context).subtitle2,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: CustomTheme.of(context).primaryText,
                                  size: 20,
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
          ),
        );
      },
    );
  }
}
