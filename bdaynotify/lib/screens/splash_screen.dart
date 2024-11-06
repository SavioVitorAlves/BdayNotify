import 'package:flutter/material.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    
    // Escuta as mudanças de conectividade
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Verifica o primeiro resultado da lista
      if (results.isNotEmpty && results.first == ConnectivityResult.none) {
        _showNoConnectionDialog();
      } else {
        _navigateToHome();
      }
    });

  }

  @override
  void dispose() {
    _subscription?.cancel(); // Cancela a assinatura quando a tela é destruída
    super.dispose();
    
  }

  Future<void> _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      _showNoConnectionDialog();
    } else {
      _navigateToHome();
    } 
  }
  bool _isNavigating = false;

  void _navigateToHome() {
    if (_isNavigating || _isDialogOpen) return; // Evita navegação múltipla
    _isNavigating = true;
    
    Navigator.of(context).pushReplacementNamed('/home');
  }

  bool _isDialogOpen = false;

  void _showNoConnectionDialog() {
    
    if (_isDialogOpen) return; // Evita mostrar múltiplos diálogos
    _isDialogOpen = true;

    showDialog(
      context: context,
      barrierDismissible: false, // Não permite fechar o diálogo clicando fora
      builder: (BuildContext context) => AlertDialog(
        title: Text("Sem Conexão com a Internet"),
        content: Text("Verifique sua conexão e tente novamente."),
        actions: [
          
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Fechar o diálogo
               _isDialogOpen = false;
              await SystemNavigator.pop(); // Fechar o app
            },
            child: Text("Sair"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5A6AF1),
              Color(0xFF273087)
            ],
            begin: Alignment.topCenter,
            end: Alignment.center
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/assets/imgs/logosplashscreen.png'),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
