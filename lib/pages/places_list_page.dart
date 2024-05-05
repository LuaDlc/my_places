import 'package:flutter/material.dart';
import 'package:my_places/providers/my_places.dart';
import 'package:my_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListPage extends StatelessWidget {
  const PlacesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meus Lugares'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.placeForm);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<MyPlaces>(context, listen: false).loadPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<MyPlaces>(
                  child: const Center(
                    child: Text('nenhum local cadastrado'),
                  ),
                  builder: (context, myPlaces, ch) => myPlaces.itemsCount == 0
                      ? ch!
                      : ListView.builder(
                          itemCount: myPlaces.itemsCount,
                          itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(myPlaces
                                      .itemByIndex(i)
                                      .image), //nosso arquivo da camera é o background
                                ),
                                title: Text(myPlaces.itemByIndex(i).title),
                                onTap: () {},
                              ))),
        ));
  }
}
