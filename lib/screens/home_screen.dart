import 'package:flutter/material.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:app/screens/search_screen.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> token;

  const HomeScreen({super.key, required this.token});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Lista de widgets para las diferentes páginas
  final List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions.addAll([
      HomePage(),
      SearchPage(token: widget.token),
      ProfilePage(token: widget.token), // Pasar el token a ProfilePage
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cambia el índice seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            _widgetOptions[_selectedIndex], // Display the corresponding widget
      ),
      bottomNavigationBar: BottomNavigationBar(
        type:
            BottomNavigationBarType
                .fixed, // Ensures the items are displayed in a fixed manner
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white, // Color for the selected item
        unselectedItemColor: const Color.fromARGB(
          255,
          71,
          71,
          71,
        ), // Color for unselected items
        backgroundColor: Color(
          0xFF021923,
        ), // Background color of the navigation bar
        onTap: _onItemTapped,
        iconSize: 30, // Increased icon size for better visibility
        selectedFontSize: 14, // Font size for selected item
        unselectedFontSize: 12, // Font size for unselected items
        showUnselectedLabels: true, // Show labels for unselected items
      ),
    );
  }
}

class WelcomePage extends StatefulWidget {
  final Map<String, dynamic> token;

  const WelcomePage({super.key, required this.token});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imagenes/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido de la página
          Center(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Slider de bienvenida
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      children: [
                        _buildSliderPage(
                          '¡Bienvenido a nuestra app!',
                          'assets/imagenes/welcome2.json',
                        ),
                        _buildSliderPage(
                          'Explora nuevas funcionalidades',
                          'assets/imagenes/welcome3.json',
                          showButton:
                              true, // Indica que se debe mostrar el botón
                        ),
                      ],
                    ),
                  ),
                  // Paginador de puntos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _currentPage == index
                                  ? Colors.white
                                  : Colors.white54,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 30), // Espacio adicional
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderPage(
    String text,
    String lottiePath, {
    bool showButton = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(lottiePath, width: 350, height: 350, fit: BoxFit.fill),
        SizedBox(height: 20),
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 50),
        if (showButton) // Mostrar el botón solo en la segunda página
          ElevatedButton(
            onPressed: () {
              // Navegar a la página de inicio
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(token: widget.token),
                ),
              );
            },
            child: Text('Comenzar'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> titles = [
    'Correspondencia',
    'Sefa',
    'Otros proyectos',
    'Card 4',
    'Card 5',
    'Card 6',
    'Card 7',
  ];

  final List<IconData> icons = [
    Icons.mail, // Ícono para Correspondencia
    Icons.business, // Ícono para Sefa
    Icons.folder, // Ícono para Otros proyectos
    Icons.card_travel, // Ícono para Card 4
    Icons.star, // Ícono para Card 5
    Icons.settings, // Ícono para Card 6
    Icons.settings, // Ícono para Card 7
  ];

  void _showDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('Este es el contenido del diálogo para $title.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 233, 233),
      body: Stack(
        children: [
          // Fondo de lava
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 125, // Altura de la lava
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF7b8f90),
                    const Color(0xFF485958),
                    const Color(0xFF021923),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween, // Espacio entre el texto y el ícono
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      16.0,
                    ), // Espaciado alrededor del texto
                    child: Text(
                      'Administrador',
                      style: TextStyle(
                        fontSize: 20, // Tamaño de la fuente
                        color: Colors.white, // Color del texto
                        fontWeight: FontWeight.bold, // Peso de la fuente
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      16.0,
                    ), // Espaciado alrededor del ícono
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white, // Color del ícono
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Contenido principal
          Padding(
            padding: const EdgeInsets.only(
              top: 125,
            ), // Espacio para el fondo de lava
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de columnas
                childAspectRatio:
                    1, // Proporción de ancho a alto de las tarjetas
                crossAxisSpacing: 10, // Espacio horizontal entre las tarjetas
                mainAxisSpacing: 10, // Espacio vertical entre las tarjetas
              ),
              itemCount: titles.length, // Número total de tarjetas
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4, // Sombra de la tarjeta
                  color: const Color(0xFF66030d), // Color de la tarjeta
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[index], // Ícono correspondiente
                          size: 40, // Tamaño del ícono
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ), // Espacio entre el ícono y el texto
                        Text(
                          titles[index],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center, // Centrar el texto
                        ),
                        SizedBox(
                          height: 8,
                        ), // Espacio entre el texto y el botón
                        ElevatedButton(
                          onPressed: () {
                            _showDialog(
                              context,
                              titles[index],
                            ); // Mostrar diálogo al presionar el botón
                          },
                          child: Text('Abrir'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
