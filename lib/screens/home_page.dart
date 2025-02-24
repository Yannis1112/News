import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/navigation/app_router.gr.dart';

import '../domain/actu_repository.dart';
import '../model/actu.dart';
import '../model/network_datasource.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Actu>>(
      future: ActuRepository().getActus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final actus = snapshot.data!;
          return ListView.builder(
            itemCount: actus.length,
            itemBuilder: (context, index) {
              final actu = actus[index];
              return Card(
                child: ListTile(
                  leading: Image.network(actu.image.toString()),
                  title: Text(actu.title.toString()),
                  subtitle: Text(actu.description.toString()),
                ),
              );
            },
          );
        } else {
          return Center(child: Text('Aucune donnée disponible'));
        }
      },
    );
  }
}