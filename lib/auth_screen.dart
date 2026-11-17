import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_repository.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthRepository _authRepository = AuthRepository();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();
  final FocusNode _correoFocusNode = FocusNode();
  final FocusNode _contraseniaFocusNode = FocusNode();

  bool esRegistro = false;
  bool cargando = false;
  String? error;

  @override
  void dispose() {
    _correoController.dispose();
    _contraseniaController.dispose();
    _correoFocusNode.dispose();
    _contraseniaFocusNode.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    final correo = _correoController.text.trim();
    final contrasenia = _contraseniaController.text;
    if (correo.isEmpty || contrasenia.isEmpty) {
      setState(() => error = 'Escribe tu correo y contrasenia');
      return;
    }
    setState(() {
      cargando = true;
      error = null;
    });
    try {
      if (esRegistro) {
        await _authRepository.registrar(correo, contrasenia);
      } else {
        await _authRepository.iniciarSesion(correo, contrasenia);
      }
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => error = AuthRepository.mensajeDeError(e));
    } finally {
      if (mounted) {
        setState(() => cargando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(esRegistro ? 'crear cuenta' : 'iniciar sesion'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 48,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'img/Plantas/logos/Logo.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 24.0),
                  TextField(
                    controller: _correoController,
                    focusNode: _correoFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    scrollPadding: const EdgeInsets.fromLTRB(24, 48, 24, 200),
                    onSubmitted: (_) => _contraseniaFocusNode.requestFocus(),
                    style: const TextStyle(color: Color(0xFF1F2937)),
                    cursorColor: const Color(0xFF1565C0),
                    decoration: const InputDecoration(
                      labelText: 'Correo electronico',
                      labelStyle: TextStyle(color: Color(0xFF4B5563)),
                      floatingLabelStyle: TextStyle(color: Color(0xFF1565C0)),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1565C0),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  TextField(
                    controller: _contraseniaController,
                    focusNode: _contraseniaFocusNode,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    scrollPadding: const EdgeInsets.fromLTRB(24, 48, 24, 200),
                    onSubmitted: (_) => cargando ? null : _enviar(),
                    style: const TextStyle(color: Color(0xFF1F2937)),
                    cursorColor: const Color(0xFF1565C0),
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Color(0xFF4B5563)),
                      floatingLabelStyle: TextStyle(color: Color(0xFF1565C0)),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1565C0),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  if (error != null) ...[
                    const SizedBox(height: 12.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE4E6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        error!,
                        style: const TextStyle(color: Color(0xFF9F1239)),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: cargando ? null : _enviar,
                      child: cargando
                          ? const SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            )
                          : Text(
                              esRegistro ? 'Crear cuenta' : 'Iniciar sesion',
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: cargando
                        ? null
                        : () => setState(() {
                            esRegistro = !esRegistro;
                            error = null;
                          }),
                    child: Text(
                      esRegistro
                          ? 'Ya tienes cuenta? Inicia sesion'
                          : 'No tienes cuenta? Crea una',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
