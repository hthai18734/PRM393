import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/fake_auth_service.dart';
import '../utils/validators.dart';
import 'success_screen.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _service = FakeAuthService();
  bool _loading = false;
  @override void dispose() {
    _name.dispose(); _email.dispose(); _password.dispose(); _confirm.dispose(); super.dispose();
  }
  Future<void> _submit() async {
    if (_loading || !_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);
    final user = UserModel(name: _name.text.trim(), email: _email.text.trim(),
      password: _password.text);
    try {
      await _service.register(user);
      if (!mounted) return;
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => SuccessScreen(name: user.name)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString().replaceFirst('Exception: ', ''))));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Smart Registration')),
    body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480),
      child: SingleChildScrollView(padding: const EdgeInsets.all(20),
        child: Form(key: _formKey, autovalidateMode: AutovalidateMode.disabled,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Icon(Icons.person_add_alt_1, size: 64, color: Colors.indigo),
            const SizedBox(height: 16),
            TextFormField(controller: _name, decoration: const InputDecoration(
              labelText: 'Họ tên', border: OutlineInputBorder()),
              textInputAction: TextInputAction.next, validator: Validators.requiredField),
            const SizedBox(height: 14),
            TextFormField(controller: _email, decoration: const InputDecoration(
              labelText: 'Email', border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next, validator: Validators.email),
            const SizedBox(height: 14),
            TextFormField(controller: _password, decoration: const InputDecoration(
              labelText: 'Mật khẩu', border: OutlineInputBorder()),
              obscureText: true, textInputAction: TextInputAction.next,
              validator: Validators.password),
            const SizedBox(height: 14),
            TextFormField(controller: _confirm, decoration: const InputDecoration(
              labelText: 'Xác nhận mật khẩu', border: OutlineInputBorder()),
              obscureText: true, textInputAction: TextInputAction.done,
              validator: (value) {
                final required = Validators.requiredField(value);
                if (required != null) return required;
                return value != _password.text ? 'Mật khẩu xác nhận không khớp' : null;
              }, onFieldSubmitted: (_) => _submit()),
            const SizedBox(height: 20),
            FilledButton(onPressed: _loading ? null : _submit,
              child: Padding(padding: const EdgeInsets.all(8),
                child: _loading ? const SizedBox(height: 24, width: 24,
                  child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Đăng ký'))),
            const SizedBox(height: 12),
            const Text('Thử email test@error.com để kiểm tra lỗi giả lập.',
              textAlign: TextAlign.center),
          ]))))));
}
