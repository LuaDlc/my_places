// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_places/pages/map_page.dart';
import 'package:my_places/utils/location_util.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;
  const LocationInput({
    Key? key,
    required this.onSelectPosition,
  }) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String?
      _previewImageUrl; //api do google fornecera uma preview da iamgem setada

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    //navegar para a tela e retornar com um objeto
    // quando fizer um pop dentro dessa tela mapPage ele vai rtornar um location
    final LatLng selectedPosition =
        await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => const MapPage(),
    ));
    if (selectedPosition.isNull) return;

    print(selectedPosition.latitude);

    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    //preview da imagem
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? const Text('Localizacao nao informada')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation, //referencia da funcao
              icon: const Icon(Icons.location_on),
              label: const Text(
                'Localizacao atual',
                style: TextStyle(),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Selecione no mapa'),
            )
          ],
        )
      ],
    );
  }
}
