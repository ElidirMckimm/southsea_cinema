import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';
import 'package:southsea_cinema/models/user_settings.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() {
    return _SettingsViewState();
  }
}

class _SettingsViewState extends State<SettingsView> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  bool _receiveNewsLetter = false;
  String _confirmationMessage = '';

  @override
  void initState() {

    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _emailController = TextEditingController();

  }

  @override
  void dispose() {

    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();

  }

  void _saveSettings() {
    final String name = _nameController.text.trim();
    final String address = _addressController.text.trim();
    final String email = _emailController.text.trim();

    final UserSettings settings = UserSettings(
      name: name,
      address: address,
      email: email,
      receiveNewsLetter: _receiveNewsLetter,
    );

    setState(() {
      _confirmationMessage = 'Settings saved for ${settings.name}';
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appTitle,
          style: cinemaHeaderStyle,
        ),
      ),
      drawer: const NavDrawer(),
      body: const Center(
        child: Text('Settings View')
      )
    );
  }
}