import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projeto_final/models/authenticate.dart';
import 'package:projeto_final/theme/app_theme.dart';
import 'package:projeto_final/types/login.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers e variáveis de exemplo
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _passwordVisibility = false;
  LoginMode _mode = LoginMode.signIn;

  // Validação simples
  String? _validateNotEmpty(String? value) {
    return (value == null || value.isEmpty) ? 'Campo obrigatório' : null;
  }

  // Lista de idiomas para o dropdown
  final List<bool> selectedLanguage = <bool>[true, false];

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    // Tamanhos da tela
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Cores do tema customizado (usando o Theme.of(context))
    final primaryColor = Theme.of(ctx).colorScheme.primary;
    final secondaryColor = Theme.of(ctx).colorScheme.secondary;
    final alternateColor = Theme.of(ctx).colorScheme.alternate;
    final primaryText = Theme.of(ctx).colorScheme.primaryText;
    final secondaryText = Theme.of(ctx).colorScheme.secondaryText;
    final primaryBackground = Theme.of(ctx).colorScheme.primaryBackground;
    final secondaryBackground = Theme.of(ctx).colorScheme.secondaryBackground;
    final errorColor = Theme.of(ctx).colorScheme.error;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: width * 0.35,
                  height: height * 0.6,
                  decoration: BoxDecoration(
                    color: secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: alternateColor, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20,
                      children: [
                        // Cabeçalho com texto gradiente e subtítulo
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GradientText(
                              'TuneIn',
                              // Utilizando headlineLarge (em vez de headline4)
                              style: Theme.of(
                                context,
                              ).textTheme.headlineLarge!.copyWith(
                                fontFamily: 'Oswald',
                                fontWeight: FontWeight.bold,
                              ),
                              colors: [primaryColor, secondaryColor],
                              gradientDirection: GradientDirection.ltr,
                              gradientType: GradientType.linear,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Music for everyone',
                              // Utilizando bodyMedium (em vez de bodyText2)
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: secondaryText,
                              ),
                            ),
                          ],
                        ),
                        // Formulário
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Campo de Username (apenas no signUp)
                            if (_mode == LoginMode.signUp)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: SizedBox(
                                  width: width * 0.2,
                                  child: TextFormField(
                                    controller: _usernameController,
                                    focusNode: _usernameFocusNode,
                                    style: TextStyle(color: primaryText),
                                    cursorColor: primaryText,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Username',
                                      // Usando bodyLarge (em vez de bodyText1)
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: secondaryText),
                                      filled: true,
                                      fillColor: primaryBackground,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: primaryText,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: errorColor,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.person,
                                        color: secondaryText,
                                      ),
                                    ),
                                    validator: _validateNotEmpty,
                                  ),
                                ),
                              ),
                            // Campo de Email
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SizedBox(
                                width: width * 0.2,
                                child: TextFormField(
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  style: TextStyle(color: primaryText),
                                  cursorColor: primaryText,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Email',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: secondaryText),
                                    filled: true,
                                    fillColor: primaryBackground,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primaryText,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: errorColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: secondaryText,
                                    ),
                                  ),
                                  validator: _validateNotEmpty,
                                ),
                              ),
                            ),
                            // Campo de Senha
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SizedBox(
                                width: width * 0.2,
                                child: TextFormField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  obscureText: !_passwordVisibility,
                                  style: TextStyle(color: primaryText),
                                  cursorColor: primaryText,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Password',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: secondaryText),
                                    filled: true,
                                    fillColor: primaryBackground,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primaryText,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: errorColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _passwordVisibility =
                                              !_passwordVisibility;
                                        });
                                      },
                                      child: Icon(
                                        _passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: secondaryText,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  validator: _validateNotEmpty,
                                ),
                              ),
                            ),
                            // Botão de ação (Sign In / Sign Up)
                            SizedBox(
                              width: width * 0.2,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () async {
                                  var user = await Authenticate().sign(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    mode: _mode,
                                  );


                                  if (user != null) {
                                    ProviderScope.containerOf(context).read(userProvider.notifier).setUser(user);
                                    Navigator.pushNamed(context, '/main');
                                  }
                                  else{
                                    showDialog(
                                      context: context,
                                      builder:(context) {
                                        return AlertDialog(
                                          title: Text("Error!"),
                                          content: Text("Wrong user or password"),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Close Tab"),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryText,
                                  // foregroundColor agora é definido via "onPrimary" para o texto,
                                  // mas aqui usamos o padrão do tema para o botão
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  _mode == LoginMode.signIn
                                      ? 'SIGN IN'
                                      : 'SIGN UP',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge!.copyWith(
                                    color: primaryBackground,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Linha separadora com "OR"
                        if (_mode == LoginMode.signIn)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                constraints: BoxConstraints(maxHeight: 2),
                                decoration: BoxDecoration(color: secondaryText),
                              ),
                              Text(
                                ' OR ',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.copyWith(
                                  fontFamily: 'Inter',
                                  color: secondaryText,
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 100,
                                constraints: BoxConstraints(maxHeight: 2),
                                decoration: BoxDecoration(color: secondaryText),
                              ),
                            ],
                          ),
                        // Botão "Continue with Google" (apenas no signIn)
                        if (_mode == LoginMode.signIn)
                          SizedBox(
                            width: width * 0.2,
                            height: 40,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                print('Continue with Google');
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.google,
                                size: 15,
                                color: primaryText,
                              ),
                              label: const Text('Continue with Google'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: primaryText,
                                side: BorderSide(color: primaryText, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        // RichText com link para alternar entre signIn/signUp
                        RichText(
                          text: TextSpan(
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              fontFamily: 'Inter',
                              letterSpacing: 1,
                              color: secondaryText,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    _mode == LoginMode.signIn
                                        ? "Don't have an account? "
                                        : "Already have an account? ",
                              ),
                              TextSpan(
                                text:
                                    _mode == LoginMode.signIn
                                        ? 'SIGN UP'
                                        : 'SIGN IN',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: primaryText,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          _mode =
                                              _mode == LoginMode.signIn
                                                  ? LoginMode.signUp
                                                  : LoginMode.signIn;
                                        });
                                      },
                              ),
                            ],
                          ),
                        ),
                        // Exemplo simples de seletor de idioma
                        if (_mode == LoginMode.signIn)
                          ToggleButtons(
                            onPressed: (int index) {
                              setState(() {
                                // The button that is tapped is set to true, and the others to false.
                                for (
                                  int i = 0;
                                  i < selectedLanguage.length;
                                  i++
                                ) {
                                  selectedLanguage[i] = i == index;
                                }
                              });
                            },
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            selectedBorderColor: primaryBackground,
                            selectedColor: secondaryBackground,
                            fillColor: primaryText,
                            color: Colors.white,
                            constraints: const BoxConstraints(
                              minHeight: 40.0,
                              minWidth: 80.0,
                            ),
                            isSelected: selectedLanguage,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Image.network(
                                          'https://flagcdn.com/w80/us.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' English (US)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              selectedLanguage[0]
                                                  ? primaryBackground
                                                  : primaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Image.network(
                                          'https://flagcdn.com/w80/br.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' Portuguese (BR)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              selectedLanguage[1]
                                                  ? primaryBackground
                                                  : primaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (_mode == LoginMode.signIn)
                          Text(
                            'Copyright © 2025 - Erik e Nicholas',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              fontFamily: 'Inter',
                              color: secondaryText,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
