import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController(text: 'mikael@taye.et');
  final _passCtrl = TextEditingController(text: '••••••••');
  bool _obscure = true;
  bool _loading = false;
  String _selectedRole = 'contractor';

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _loading = false);
    if (_selectedRole == 'admin') {
      context.go('/admin/dashboard');
    } else {
      context.go('/contractor/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),

                // ── LOGO ──
                Row(
                  children: [
                    Container(
                      width: 42, height: 42,
                      decoration: const BoxDecoration(
                        color: AppColors.gold,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('T',
                            style: TextStyle(
                              color: AppColors.dark,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            )),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('Tenet',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.gold,
                          letterSpacing: -0.5,
                        )),
                  ],
                ),

                const SizedBox(height: 40),

                const Text('Welcome back',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    )),
                const SizedBox(height: 6),
                const Text('Sign in to your Tenet account',
                    style: TextStyle(fontSize: 14, color: AppColors.textMuted)),

                const SizedBox(height: 32),

                // ── ROLE SELECTOR ──
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.dark3,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.borderDim),
                  ),
                  child: Row(
                    children: [
                      _roleTab('contractor', '🔨', 'Contractor'),
                      _roleTab('admin', '⚙️', 'Admin'),
                      _roleTab('owner', '🏢', 'Tender Owner'),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── EMAIL ──
                const _FieldLabel('Email Address'),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'you@company.et',
                    prefixIcon: Icon(Icons.email_outlined, color: AppColors.textMuted, size: 20),
                  ),
                  validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                ),

                const SizedBox(height: 16),

                // ── PASSWORD ──
                const _FieldLabel('Password'),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: _obscure,
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Your password',
                    prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textMuted, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: AppColors.textMuted, size: 20),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  validator: (v) => (v == null || v.length < 6) ? 'Min 6 characters' : null,
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text('Forgot password?',
                        style: TextStyle(color: AppColors.gold, fontSize: 13, fontWeight: FontWeight.w500)),
                  ),
                ),

                const SizedBox(height: 28),

                // ── LOGIN BUTTON ──
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _login,
                    child: _loading
                        ? const SizedBox(width: 22, height: 22,
                            child: CircularProgressIndicator(color: AppColors.dark, strokeWidth: 2.5))
                        : const Text('Sign In'),
                  ),
                ),

                const SizedBox(height: 20),

                // ── DIVIDER ──
                Row(children: [
                  const Expanded(child: Divider(color: AppColors.borderDim)),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('or', style: TextStyle(color: AppColors.textDim, fontSize: 13))),
                  const Expanded(child: Divider(color: AppColors.borderDim)),
                ]),

                const SizedBox(height: 20),

                // ── REGISTER LINK ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ",
                        style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                    GestureDetector(
                      onTap: () => context.go('/register'),
                      child: const Text('Create Account',
                          style: TextStyle(color: AppColors.gold, fontSize: 14, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // ── DEMO HINT ──
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.goldDim,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Row(
                    children: [
                      Text('💡', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Showcase mode: tap Sign In to explore the full app workflow',
                          style: TextStyle(color: AppColors.gold, fontSize: 12, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleTab(String role, String emoji, String label) {
    final isActive = _selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedRole = role),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: isActive ? AppColors.gold : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 2),
              Text(label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isActive ? AppColors.dark : AppColors.textMuted,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontSize: 11, fontWeight: FontWeight.w600,
          letterSpacing: 0.5, color: AppColors.textDim,
        ));
  }
}
