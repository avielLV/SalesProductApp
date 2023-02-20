import 'package:flutter/material.dart';
import 'package:proudcto_app/models/models.dart';
import 'package:proudcto_app/provider/login_from_provider.dart';
import 'package:proudcto_app/services/services.dart';
import 'package:proudcto_app/ui/input_decorations.dart';
import 'package:proudcto_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 250),
          CardContainer(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text('Login',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: _LoginForm(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'register');
            },
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                    Colors.deepPurple.withOpacity(0.1)),
                shape: MaterialStateProperty.all(const StadiumBorder())),
            child: const Text(
              'Crear una nueva cuenta',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecorations(
                hintText: 'john.deo@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecorations(
                  hintText: '*******',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              }),
          const SizedBox(height: 30),
          MaterialButton(
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    //Todo:login
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!loginForm.isValidform()) return;
                    loginForm.isLoading = true;
                    final String? error = await authService.login(
                        CreateUserRequest(
                            email: loginForm.email,
                            password: loginForm.password,
                            returnSecureToken: true));
                    if (error == null) {
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      // print('$error');
                      if (error == 'EMAIL_NOT_FOUND') {
                        NotificationsService.showSnackbar('Correo no existe');
                      } else {
                        NotificationsService.showSnackbar(
                            'contraseña incorrecta');
                      }
                      loginForm.isLoading = false;
                    }
                  },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Espere...' : 'Ingresar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
