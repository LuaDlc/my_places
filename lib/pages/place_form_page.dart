import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_places/providers/my_places.dart';
import 'package:my_places/widgets/image_input.dart';
import 'package:my_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormPage extends StatefulWidget {
  const PlaceFormPage({Key? key}) : super(key: key);

  @override
  State<PlaceFormPage> createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final _titleController = TextEditingController();
  File? pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pickedImage) {
    //setar a imagem que pertence ao meu estado usando a imagem q acabei de receber
    pickedImage = pickedImage;
  }

  void _selectPosition(LatLng position) {
    _pickedPosition = position;
  }

  bool _isValidForm() {
    return _titleController.text.isNotEmpty &&
        pickedImage != null &&
        _pickedPosition != null;
  }

  void _submitForm() {
    if (!_isValidForm()) {
      return;
    }
    Provider.of<MyPlaces>(context, listen: false)
        .addPlace(_titleController.text, pickedImage!, _pickedPosition!);
    // o comportamento esperado é que se as informacoes estiverem preenchidas
    //com o nome e a imagem, o formulario sera submetido e a tela sera fechada
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            //expanded pra ajustar o botao na parte inferior da tela, ao inves do mainaxisalignment
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Titulo'),
                    //criar controller pra gerenciar o textfield
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectImage),
                  const SizedBox(
                    height: 10,
                  ),
                  LocationInput(
                    onSelectPosition: _selectPosition,
                  )
                ]),
              ),
            ),
          ),
          //fica fora da primeira coluna para ficar sempre visivel quando fizer scroll da tela
          TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: _isValidForm() ? _submitForm : null,
              icon: const Icon(Icons.add),
              label: Text(
                'Adicionar',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ],
      ),
    );
  }
}
