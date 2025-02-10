import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _appBar(),
        body: _appBody(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Форма регистрации",
        style: TextStyle(color: Colors.black, fontSize: 24),
      ),
    );
  }

  Widget _appBody() {
    return RegistrationForm();
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool passwordObscured = true;
  Color passwordEyeColor = Colors.grey;
  TextEditingController passwordController = TextEditingController();

  bool passwordCheckObscured = true;
  Color passwordCheckColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _textField(lastnameController, "Фамилия"),
                _textField(nameController, "Имя"),
                _textField(patronymicController, "Отчество"),
                _phoneNumberField(),
                _emailField(),
                _passwordField(),
                _passwordCheckField(),
                _submit(context)
              ],
            ),
          ),
        ));
  }

  TextFormField _passwordCheckField() {
    return TextFormField(
      obscureText: passwordCheckObscured,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
          labelText: "Подтверждение пароля",
          suffix: TextButton(
              onPressed: () {
                setState(() {
                  passwordCheckObscured = !passwordCheckObscured;
                  passwordCheckColor =
                      passwordCheckObscured ? Colors.grey : Colors.red;
                });
              },
              child: Icon(
                Icons.remove_red_eye,
                color: passwordCheckColor,
              ))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Поле не может быть пустым";
        } else if (passwordController.text != value) {
          return "Пароли не совпадают";
        }
        return null;
      },
    );
  }

  TextFormField _passwordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: passwordObscured,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
          labelText: "Пароль",
          suffix: TextButton(
              onPressed: () {
                setState(() {
                  passwordObscured = !passwordObscured;
                  passwordEyeColor =
                      passwordObscured ? Colors.grey : Colors.red;
                });
              },
              child: Icon(
                Icons.remove_red_eye,
                color: passwordEyeColor,
              ))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Поле не может быть пустым";
        }
        return null;
      },
    );
  }

  Padding _submit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Успешная регистрация")));

              print(
                  "ФИО: ${lastnameController.text} ${nameController.text} ${patronymicController.text}");
              print("Номер телефона: ${phoneController.text}");
              print("E-mail: ${emailController.text}");
              print("Пароль: ${passwordController.text}");
            }
          },
          child: const Text("Зарегистрироваться")),
    );
  }

  TextFormField _emailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(labelText: "E-mail"),
      validator: (value) {
        RegExp regExp = RegExp(r'^[\w\.]+@[\w\.]+\.(com|ru)$');
        if (value == null || value.isEmpty) {
          return "Поле не может быть пустым";
        } else if (!regExp.hasMatch(value)) {
          return "Не является допустимым e-mail";
        }
        return null;
      },
    );
  }

  TextFormField _phoneNumberField() {
    return TextFormField(
      controller: phoneController,
      decoration: InputDecoration(labelText: "Номер телефона"),
      validator: (value) {
        RegExp phoneRegExp = RegExp(r'^(8|\+[1-9]{1}[0-9]?)[0-9]{10}$');

        if (value == null || value.isEmpty) {
          return "Поле не может быть пустым";
        } else if (!phoneRegExp.hasMatch(value)) {
          return "Не является допустимым номером телефона";
        }
        return null;
      },
    );
  }

  TextFormField _textField(TextEditingController controller, String fieldName) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: fieldName),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Поле не должно быть пустым";
        }
        return null;
      },
    );
  }
}
