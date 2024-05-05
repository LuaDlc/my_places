// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_places/models/place.dart';

class MapPage extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadOnly;

  const MapPage({
    Key? key,
    this.initialLocation = const PlaceLocation(
      latitude: 37.422131,
      longitude: -122.084801,
    ),
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Selecione...'),
          actions: [
            if (!widget.isReadOnly)
              IconButton(
                  onPressed: _pickedPosition == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedPosition);
                        },
                  icon: const Icon(Icons.check))
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.latitude,
                widget.initialLocation.longitude),
            zoom: 13,
          ),
          onTap: widget.isReadOnly ? null : _selectPosition,
          markers: _pickedPosition == null
              ? Set()
              : {
                  Marker(
                    markerId: const MarkerId(
                      'p1',
                    ),
                    position: _pickedPosition!,
                  ),
                },
        ));
  }
}
