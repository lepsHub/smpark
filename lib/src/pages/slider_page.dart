import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double _valorSlider = 100.0;
  bool _bloquearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            _crearSlider(),
            _checkBox(),
            _crearSwitch(),
            Expanded(
              child: _crearImagen()
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearSlider() {

    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de la imagen',
      // divisions: 20,
      value: _valorSlider,
      min: 10,
      max: 400,
      onChanged: ( _bloquearCheck) ? null : (valor){

        setState(() {
          _valorSlider = valor;
        });

        

      },
    );

  }

  Widget _crearImagen() {

    return Image(
      image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/MCM_2013_-_Batman_%288979342250%29.jpg/1200px-MCM_2013_-_Batman_%288979342250%29.jpg'),
      width: _valorSlider,
      fit: BoxFit.contain,
    );

  }

  Widget _checkBox() {

    // return Checkbox(
    //   value: _bloquearCheck,
    //   onChanged: (valor) {
    //     setState(() {
    //       if (valor != null) {
    //         _bloquearCheck = valor;
    //       }
    //     });
    //   },
    // );

    return CheckboxListTile(
      title: Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (valor) {
        setState(() {
          if (valor != null) {
            _bloquearCheck = valor;
          }
        });
      },
    );

  }

  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (valor) {
        setState(() {
            _bloquearCheck = valor;
        });
      },
    );
  }
}