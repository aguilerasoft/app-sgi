import 'package:flutter/material.dart';
import 'package:app/screens/login_screen.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> token;

  const ProfilePage({super.key, required this.token});
  final String profileImageUrl =
      'http://172.16.205.63/assets/fotos/'; // URL de la imagen de perfil

  @override
  Widget build(BuildContext context) {
    print(token['projects_permission'][0]);
    return Scaffold(
      body: Stack(
        children: [
          // Fondo gris
          Container(
            height: MediaQuery.of(context).size.height * 0.39,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7B8F90), Color(0xFF021923)],
                begin: Alignment.topCenter, // Comienza en la parte superior
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          ),
          // Contenido principal
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          profileImageUrl + token['user']['cedula'] + '.jpg',
                        ),
                        onBackgroundImageError: (exception, stackTrace) {
                          print('Error loading image: $exception');
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        token['user']['fullname'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        token['user']['username'],
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(bottom: 30, top: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF66030D),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          token['user']['idtypeuser']['description'],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 0),
            ],
          ),
          // Sección 1 y Sección 2 en un Row
          Positioned(
            top: MediaQuery.of(context).size.height * 0.36,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Sección 1
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          'V-' + token['user']['cedula'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // Sección 2
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Lógica para cerrar sesión
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                              (Route<dynamic> route) =>
                                  false, // Elimina todas las rutas anteriores
                            );
                          },
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ), // Ícono del botón
                          label: Text(
                            'Cerrar sesión',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          // Texto del botón
                          style: ElevatedButton.styleFrom(
                            // Color del texto y del ícono
                            backgroundColor: const Color(0xFF7B8F90),
                            padding: EdgeInsets.symmetric(
                              vertical: 22,
                            ), // Espaciado vertical
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // Esquinas redondeadas
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10), // Espacio entre los cards y el texto
                Card(
                  elevation: 4,
                  color: Colors.white, // Color del card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Esquinas redondeadas
                  ),
                  child: SizedBox(
                    width:
                        double
                            .infinity, // Asegura que el card ocupe todo el ancho
                    child: Padding(
                      padding: EdgeInsets.all(16.0), // Espaciado interno
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Alinear a la izquierda
                        children: [
                          Text(
                            'Empresa', // Título
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ), // Espacio entre el título y el subtítulo
                          Text(
                            token['user']['idcompany']['idtyperif']['description'] +
                                    '-' +
                                    token['user']['idcompany']['rif'] +
                                    ' (' +
                                    token['user']['idcompany']['name'] +
                                    ')' ??
                                'No disponible', // Subtítulo
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  Colors
                                      .black54, // Color más claro para el subtítulo
                            ),
                          ),
                          Divider(),
                          Text(
                            'Proyectos asignados', // Título
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ), // Espacio entre el título y el subtítulo
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ), // Espacio entre el título y la lista
                                // Verifica si hay permisos y muestra la lista
                                if (token['projects_permission'][0] !=
                                    "No tiene proyecto asociado")
                                  ...token['projects_permission'].map<Widget>((
                                    permission,
                                  ) {
                                    print('Entro');
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Código: ${permission['idproject']['code']} ( Rol: ${permission['idrole']['description']})', // Muestra el código
                                          style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Colors
                                                    .black54, // Color más claro para el subtítulo
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ), // Espacio entre permisos
                                      ],
                                    );
                                  }).toList()
                                else
                                  Text(
                                    'No disponible', // Mensaje si no hay permisos
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
