import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news/domain/actu_repository.dart';
import 'package:news/navigation/app_router.gr.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String _userImage = '';

  var regexEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  var regexPhone = RegExp(r"^(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nom',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(
              labelText: 'Prénom',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Téléphone',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              TextButton(
                onPressed: () async {
                  setState(() {
                    _userImage = 'loading';
                  });
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile == null) {
                    setState(() {
                      _userImage = '';
                    });
                    return;
                  }
                  final imageFile = File(pickedFile.path);
                  setState(() {
                    _userImage = imageFile.path;
                  });
                },
                child: const Text('Ajouter une image'),
              ),
              const SizedBox(height: 20),
              if (_userImage == 'loading')
                const CircularProgressIndicator()
              else if (_userImage.isNotEmpty)
                Image.file(
                  File(_userImage),
                  height: 200,
                  width: 200,
                )
              else
                const Text('Aucune image sélectionnée'),
            ],
          ),

          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              if(nameController.text.isEmpty || firstNameController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez remplir tous les champs')));
              } else if(!regexEmail.hasMatch(emailController.text)) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email invalide')));
              } else if(!regexPhone.hasMatch(phoneController.text)) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Téléphone invalide')));
              } else {
                ActuRepository().registerUser(nameController.text + firstNameController.text, emailController.text, phoneController.text, _userImage).then((responseBody) {
                  var decodedResponse = jsonDecode(responseBody);
                  var message = decodedResponse['success']['message'];
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                  print(message);
                  context.router.push(const HomeRoute());
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $error')));
                });
              }
            },
            child: const Text('S\'inscrire'),
          ),
        ],
      ),
    );
  }
}