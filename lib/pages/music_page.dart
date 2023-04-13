import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Theme/Color.dart';

class MusicPage extends StatefulWidget {
  const MusicPage();

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  var prefs;
  final Color _activeTrackColorDisabled = Color.fromARGB(255, 99, 75, 99);
  final Color _inactiveTrackColorEnabled = Color.fromARGB(173, 255, 239, 253);
  final Color _inactiveTrackColorDisabled = Color.fromARGB(172, 103, 97, 103);
  final Icon soundUp = const Icon(
    Icons.volume_up_outlined,
    color: Colors.white,
  );
  final Icon soundOff = const Icon(
    Icons.volume_off_outlined,
    color: Colors.white,
  );
  double _currentMusicValue = 75.0;
  double _currentSoundValue = 75.0;
  List<bool> _isActivatedMusic = [true];
  List<bool> _isActivatedSound = [true];
  Icon _musicIcon = Icon(
    Icons.volume_up_outlined,
    color: Colors.white,
  );
  Icon _soundIcon = Icon(
    Icons.volume_up_outlined,
    color: Colors.white,
  );
  Color _musicActiveTrackColor = secondary;
  Color _soundActiveTrackColor = secondary;
  Color _musicInactiveTrackColor = secondary;
  Color _soundInactiveTrackColor = secondary;
  Color _musicThumbColor = Colors.white;
  Color _soundThumbColor = Colors.white;

  @override
  void initState() {
    super.initState();
    initMusicPage();
  }

  Future<void> initMusicPage() async {
    prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('musicValue')){
      await prefs.setDouble('musicValue', 75.0);
    }
    if(!prefs.containsKey('soundValue')){
      await prefs.setDouble('soundValue', 75.0);
    }
    if(!prefs.containsKey('musicIsActivated')){
      await prefs.setBool('musicIsActivated', true);
    }
    if(!prefs.containsKey('soundIsActivated')){
      await prefs.setBool('soundIsActivated', true);
    }
    setState(() {
      _currentMusicValue = prefs.getDouble('musicValue');
      _currentSoundValue = prefs.getDouble('soundValue');
      _isActivatedMusic[0] = prefs.getBool('musicIsActivated') ?? true;
      _isActivatedSound[0] = prefs.getBool('soundIsActivated') ?? true;
      _musicIcon = _isActivatedMusic[0] ? soundUp : soundOff;
      _soundIcon = _isActivatedSound[0] ? soundUp : soundOff;
      _musicActiveTrackColor =
          _isActivatedMusic[0] ? secondary : _activeTrackColorDisabled;
      _soundActiveTrackColor =
          _isActivatedSound[0] ? secondary : _activeTrackColorDisabled;
      _musicInactiveTrackColor = _isActivatedMusic[0]
          ? _inactiveTrackColorEnabled
          : _inactiveTrackColorDisabled;
      _soundInactiveTrackColor = _isActivatedSound[0]
          ? _inactiveTrackColorEnabled
          : _inactiveTrackColorDisabled;
      _musicThumbColor =
          _isActivatedMusic[0] ? Colors.white : _activeTrackColorDisabled;
      _soundThumbColor =
          _isActivatedSound[0] ? Colors.white : _activeTrackColorDisabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Définir des tailles responsives pour les espacements
    double verticalSpacing = screenHeight * 0.025;
    double topSpacing = screenHeight * 0.05;

    return Scaffold(
        body: Stack(
            children: BuildBasicLayout([
      SizedBox(height: topSpacing * 1.5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Musique",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 20)),
          ToggleButtons(
            isSelected: _isActivatedMusic,
            onPressed: (int index) async {
              setState(() {
                _isActivatedMusic[index] = !_isActivatedMusic[index];
                _musicIcon = _musicIcon == soundUp ? soundOff : soundUp;
                _musicActiveTrackColor = _isActivatedMusic[0]
                    ? secondary
                    : _activeTrackColorDisabled;
                _musicInactiveTrackColor = _isActivatedMusic[0]
                    ? _inactiveTrackColorEnabled
                    : _inactiveTrackColorDisabled;
                _musicThumbColor = _isActivatedMusic[0]
                    ? Colors.white
                    : _activeTrackColorDisabled;
              });
              await prefs.setBool('musicIsActivated', _isActivatedMusic[index]);
            },
            children: <Widget>[
              _musicIcon,
            ],
            borderColor: Colors.transparent,
            selectedBorderColor: Colors.transparent,
            disabledBorderColor: Colors.transparent,
            fillColor: Colors.transparent,
          ),
        ],
      ),
      SizedBox(
        width: screenWidth * 0.8,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbColor: _musicThumbColor,
            activeTrackColor: _musicActiveTrackColor,
            inactiveTrackColor: _musicInactiveTrackColor,
            overlayColor: Color.fromARGB(50, 255, 255, 255),
          ),
          child: Slider(
            value: _currentMusicValue,
            max: 100,
            label: _currentMusicValue.round().toString(),
            onChanged: (double value) async {
              setState(() {
                _currentMusicValue = value;
                _isActivatedMusic[0] = _currentMusicValue != 0;
                _musicIcon = _currentMusicValue != 0 ? soundUp : soundOff;
                _musicActiveTrackColor = _isActivatedMusic[0]
                    ? secondary
                    : _activeTrackColorDisabled;
                _musicInactiveTrackColor = _isActivatedMusic[0]
                    ? _inactiveTrackColorEnabled
                    : _inactiveTrackColorDisabled;
                _musicThumbColor = _isActivatedMusic[0]
                    ? Colors.white
                    : _activeTrackColorDisabled;
              });
              await prefs.setDouble('musicValue', value);
              if (value == 0) {
                await prefs.setBool('musicIsActivated', false);
              } else {
                await prefs.setBool('musicIsActivated', true);
              }
            },
          ),
        ),
      ),
      SizedBox(height: verticalSpacing * 2.5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Son",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 20)),
          ToggleButtons(
            isSelected: _isActivatedSound,
            onPressed: (int index) async {
              setState(() {
                _isActivatedSound[index] = !_isActivatedSound[index];
                _soundIcon = _soundIcon == soundUp ? soundOff : soundUp;
                _soundActiveTrackColor = _isActivatedSound[0]
                    ? secondary
                    : _activeTrackColorDisabled;
                _soundInactiveTrackColor = _isActivatedSound[0]
                    ? _inactiveTrackColorEnabled
                    : _inactiveTrackColorDisabled;
                _soundThumbColor = _isActivatedSound[0]
                    ? Colors.white
                    : _activeTrackColorDisabled;
              });
              await prefs.setBool('soundIsActivated', _isActivatedSound[index]);
            },
            children: <Widget>[
              _soundIcon,
            ],
            borderColor: Colors.transparent,
            selectedBorderColor: Colors.transparent,
            disabledBorderColor: Colors.transparent,
            fillColor: Colors.transparent,
          ),
        ],
      ),
      SizedBox(
        width: screenWidth * 0.8,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbColor: _soundThumbColor,
            activeTrackColor: _soundActiveTrackColor,
            inactiveTrackColor: _soundInactiveTrackColor,
            overlayColor: Color.fromARGB(50, 255, 255, 255),
          ),
          child: Slider(
            value: _currentSoundValue,
            max: 100,
            label: _currentSoundValue.round().toString(),
            onChanged: (double value) async {
              setState(() {
                _currentSoundValue = value;
                _isActivatedSound[0] = _currentSoundValue != 0;
                _soundIcon = _currentSoundValue != 0 ? soundUp : soundOff;
                _soundActiveTrackColor = _isActivatedSound[0]
                    ? secondary
                    : _activeTrackColorDisabled;
                _soundInactiveTrackColor = _isActivatedSound[0]
                    ? _inactiveTrackColorEnabled
                    : _inactiveTrackColorDisabled;
                _soundThumbColor = _isActivatedSound[0]
                    ? Colors.white
                    : _activeTrackColorDisabled;
              });
              await prefs.setDouble('soundValue', value);
              if (value == 0) {
                await prefs.setBool('soundIsActivated', false);
              } else {
                await prefs.setBool('soundIsActivated', true);
              }
            },
          ),
        ),
      ),
      SizedBox(height: verticalSpacing * 4 ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('RETOUR'),
        style: SecondaryButton(context),
      ),
    ], false)));
  }
}
