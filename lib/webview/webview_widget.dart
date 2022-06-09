
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/theme.dart';
import '../utils/web_view.dart';

class WebviewWidget extends StatefulWidget {
  const WebviewWidget({
    Key key,
    this.url,
  }) : super(key: key);

  final String url;

  @override
  _WebviewWidgetState createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: CustomTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: WebView(
                  url: widget.url,
                  bypass: false,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  verticalScroll: false,
                  horizontalScroll: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
