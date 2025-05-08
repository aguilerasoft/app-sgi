import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/auth_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;
  bool _isLoading = false; // Estado de carga
  bool _obscureText = true;
  String version = '1.0.1';
  late String downloadUrl =
      'http://172.16.205.63/assets/android/$version/SGI.apk';

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajadegradiente(size),
            logotext(),
            loginform(context),
            if (_isLoading) // Muestra el spinner si está cargando
              Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView loginform(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 280),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  'Iniciar Sesion',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF66030D),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF66030D),
                              width: 2,
                            ),
                          ),
                          hintText: 'Ingrese Usuario',
                          labelText: 'Usuario',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El campo no puede estar vacío'; // Mensaje si está vacío
                          }
                          return null; // Si pasa la validación
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        autocorrect: false,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF66030D),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF66030D),
                              width: 2,
                            ),
                          ),
                          hintText: 'Ingrese Contraseña',
                          labelText: 'Contraseña',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                        validator: (value) {
                          return (value != null && value.length >= 6)
                              ? null
                              : 'La contraseña debe ser mayor o igual a 6 dígitos';
                        },
                      ),
                      SizedBox(height: 40),
                      MaterialButton(
                        onPressed:
                            _isLoading // Deshabilita el botón si está cargando
                                ? null
                                : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading =
                                          true; // Inicia el estado de carga
                                    });

                                    Map<String, dynamic>? token =
                                        await _authService.login(
                                          _usernameController.text,
                                          _passwordController.text,
                                        );

                                    setState(() {
                                      _isLoading =
                                          false; // Finaliza el estado de carga
                                    });

                                    if (token != null) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  WelcomePage(token: token),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        _errorMessage =
                                            'Credenciales inválidas';
                                      });
                                    }
                                  }
                                },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledColor: Colors.grey,
                        color: const Color(0xFF021923),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 15,
                          ),
                          child: Text(
                            'Ingresar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(color: const Color(0xFF66030D)),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          const Text(
            'Division de Tecnología',
            style: TextStyle(
              color: Color.fromARGB(255, 63, 62, 62),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  SafeArea logotext() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        width: double.infinity,
        child: Column(
          children: [
            Image.asset('assets/imagenes/logo.png', width: 250),
            const SizedBox(height: 40),
            const Text(
              'Sistema de Gestión Integral',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const Text(
              '(SGI)',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  Container cajadegradiente(Size size) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7B8F90), Color(0xFF021923)],
          begin: Alignment.topCenter, // Comienza en la parte superior
          end: Alignment.bottomCenter,
          stops: [0.05, 1.2],
        ),
      ),
      width: double.infinity,
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(top: 90, left: 30, child: burbuja()),
          Positioned(top: 30, left: 300, child: burbuja()),
          Positioned(top: 200, left: 200, child: burbuja()),
          Positioned(top: 250, left: 10, child: burbuja()),
        ],
      ),
    );
  }

  Container burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
