import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get usuarioActual => _auth.currentUser;
  Stream<User?> get cambiosDeSecion => _auth.authStateChanges();
  Future<void> registrar(String correo, String contrasenia) async {
    await _auth.createUserWithEmailAndPassword(
      email: correo,
      password: contrasenia,
    );
  }

  Future<void> iniciarSesion(String correo, String contrasenia) async {
    await _auth.signInWithEmailAndPassword(
      email: correo,
      password: contrasenia,
    );
  }

  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }

  static String mensajeDeError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'El correo electronico ya esta en uso.';
      case 'invalid-email':
        return 'El correo electronico es invalido.';
      case 'weak-password':
        return 'La contraseña es demasiado debil.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo electronico o contrassnia erroneos.';
      case 'network-request-failed':
        return 'Sin conexion a internet, intentalo mas tarde.';
      default:
        return 'Error fatal, ya no funciona este asunto.';
    }
  }
}
