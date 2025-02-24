import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news/navigation/app_router.gr.dart';

import '../domain/actu_repository.dart';

@RoutePage()
class InfosPage extends StatefulWidget {
  const InfosPage({Key? key}) : super(key: key);

  @override
  State<InfosPage> createState() => _InfosPageState();
}

class _InfosPageState extends State<InfosPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: ActuRepository().getPageHtml(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Html(data: snapshot.data!),
          );
        } else {
          return Center(child: Text('Aucune donnée disponible'));
        }
      },
    );
  }
}