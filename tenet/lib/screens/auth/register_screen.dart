import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String _accountType = 'individual';
  String _category = 'Construction';
  bool _agreedToTerms = false;
  int _step = 1;

  final _categories = ['Construction', 'IT & Software', 'Supply & Logistics', 'Catering', 'Medical', 'Consulting', 'Other'];

  @override
  void dispose() {
    _nameCtrl.dispose(); _emailCtrl.dispose(); _phoneCtrl.dispose();
    _passCtrl.dispose(); _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to terms & conditions'), backgroundColor: AppColors.red),
      );
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => _loading = false);
    context.go('/contractor/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textMuted, size: 18),
          onPressed: () => context.go('/login'),
        ),
        title: Row(
          children: List.generate(3, (i) {
            final active = _step == i + 1;
            final done = _step > i + 1;
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 3,
                      decoration: BoxDecoration(
                        color: done || active ? AppColors.gold : AppColors.dark5,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  if (i < 2) const SizedBox(width: 4),
                ],
              ),
            );
          }),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Step indicator
                Text('Step $_step of 3',
                    style: const TextStyle(fontSize: 12, color: AppColors.textDim, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),

                Text(_stepTitle(),
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(_stepSubtitle(),
                    style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),

                const SizedBox(height: 28),

                if (_step == 1) _buildStep1(),
                if (_step == 2) _buildStep2(),
                if (_step == 3) _buildStep3(),

                const SizedBox(height: 24),

                // ── NAV BUTTONS ──
                if (_step < 3)
                  SizedBox(
                    width: double.infinity, height: 52,
                    child: ElevatedButton(
                      onPressed: () => setState(() => _step++),
                      child: Text('Continue to Step ${_step + 1}'),
                    ),
                  ),
                if (_step == 3)
                  SizedBox(
                    width: double.infinity, height: 52,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _register,
                      child: _loading
                          ? const SizedBox(width: 22, height: 22,
                              child: CircularProgressIndicator(color: AppColors.dark, strokeWidth: 2.5))
                          : const Text('Create Account'),
                    ),
                  ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                        style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: const Text('Sign In',
                          style: TextStyle(color: AppColors.gold, fontSize: 14, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _stepTitle() {
    if (_step == 1) return 'Create Account';
    if (_step == 2) return 'Business Profile';
    return 'Verify & Submit';
  }

  String _stepSubtitle() {
    if (_step == 1) return 'Enter your personal details';
    if (_step == 2) return 'Tell us about your business';
    return 'Review your information';
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Account type
        const _Label('Account Type'),
        const SizedBox(height: 8),
        Row(
          children: [
            _typeCard('individual', '👤', 'Individual'),
            const SizedBox(width: 12),
            _typeCard('company', '🏢', 'Company'),
          ],
        ),
        const SizedBox(height: 18),

        const _Label('Full Name / Company Name'),
        const SizedBox(height: 6),
        TextFormField(
          controller: _nameCtrl,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            hintText: _accountType == 'individual' ? 'Mikael Taye' : 'Taye Construction PLC',
            prefixIcon: const Icon(Icons.person_outline, color: AppColors.textMuted, size: 20),
          ),
          validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
        ),
        const SizedBox(height: 14),

        const _Label('Email Address'),
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
        const SizedBox(height: 14),

        const _Label('Phone Number'),
        const SizedBox(height: 6),
        TextFormField(
          controller: _phoneCtrl,
          keyboardType: TextInputType.phone,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: const InputDecoration(
            hintText: '+251 91 234 5678',
            prefixIcon: Icon(Icons.phone_outlined, color: AppColors.textMuted, size: 20),
          ),
          validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
        ),
        const SizedBox(height: 14),

        const _Label('Password'),
        const SizedBox(height: 6),
        TextFormField(
          controller: _passCtrl,
          obscureText: _obscure,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            hintText: 'Min. 8 characters',
            prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textMuted, size: 20),
            suffixIcon: IconButton(
              icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textMuted, size: 20),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
          validator: (v) => (v == null || v.length < 6) ? 'Min 6 characters' : null,
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Label('Business Category'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: _categories.map((cat) {
            final selected = _category == cat;
            return GestureDetector(
              onTap: () => setState(() => _category = cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? AppColors.gold : AppColors.dark4,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: selected ? AppColors.gold : AppColors.borderDim),
                ),
                child: Text(cat,
                    style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600,
                      color: selected ? AppColors.dark : AppColors.textMuted,
                    )),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 18),

        const _Label('Business / License Number'),
        const SizedBox(height: 6),
        TextFormField(
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'GC-Grade-3-2024',
            prefixIcon: Icon(Icons.business_outlined, color: AppColors.textMuted, size: 20),
          ),
        ),
        const SizedBox(height: 14),

        const _Label('TIN Number (Optional)'),
        const SizedBox(height: 6),
        TextFormField(
          keyboardType: TextInputType.number,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: const InputDecoration(
            hintText: '0034-56789',
            prefixIcon: Icon(Icons.numbers_outlined, color: AppColors.textMuted, size: 20),
          ),
        ),
        const SizedBox(height: 14),

        const _Label('Location / City'),
        const SizedBox(height: 6),
        TextFormField(
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'Addis Ababa',
            prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.textMuted, size: 20),
          ),
        ),
        const SizedBox(height: 14),

        const _Label('Skills & Expertise Tags'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.dark4,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderDim),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8, runSpacing: 8,
                children: ['Road Construction', 'Civil Works', 'Asphalt', 'AACRA Grade 3']
                    .map((tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.goldDim,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(tag, style: const TextStyle(fontSize: 11, color: AppColors.gold)),
                              const SizedBox(width: 5),
                              const Icon(Icons.close, size: 12, color: AppColors.gold),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 8),
              const Text('+ Add more tags...', style: TextStyle(fontSize: 12, color: AppColors.textDim)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.dark3,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderDim),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Account Summary',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
              const SizedBox(height: 12),
              _summaryRow('Account Type', _accountType == 'company' ? 'Company' : 'Individual'),
              _summaryRow('Category', _category),
              _summaryRow('Location', 'Addis Ababa'),
              _summaryRow('Email', _emailCtrl.text.isEmpty ? 'Not set' : _emailCtrl.text),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // KYC upload notice
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.blueDim,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.blue.withOpacity(0.3)),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('📋', style: TextStyle(fontSize: 18)),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('KYC Verification Required',
                        style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w600, fontSize: 13)),
                    SizedBox(height: 4),
                    Text(
                      'After registration, upload your Business License and Tax Clearance in your profile. Admin will verify within 24 hours before you can bid.',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 12, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Terms
        GestureDetector(
          onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 20, height: 20,
                decoration: BoxDecoration(
                  color: _agreedToTerms ? AppColors.gold : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _agreedToTerms ? AppColors.gold : AppColors.textDim),
                ),
                child: _agreedToTerms
                    ? const Icon(Icons.check, size: 14, color: AppColors.dark)
                    : null,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'I agree to the Tenet Terms of Service and Privacy Policy. I confirm my business details are accurate.',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _typeCard(String type, String emoji, String label) {
    final selected = _accountType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _accountType = type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: selected ? AppColors.goldDim : AppColors.dark4,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: selected ? AppColors.gold : AppColors.borderDim, width: selected ? 1.5 : 1),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 26)),
              const SizedBox(height: 6),
              Text(label,
                  style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600,
                    color: selected ? AppColors.gold : AppColors.textMuted,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textDim))),
          Text(value, style: const TextStyle(fontSize: 12, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.5, color: AppColors.textDim),
    );
  }
}
