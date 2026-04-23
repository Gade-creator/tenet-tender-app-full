import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';

// ── KYC REVIEW ───────────────────────────────────────────────
class KycReviewScreen extends StatefulWidget {
  const KycReviewScreen({super.key});
  @override
  State<KycReviewScreen> createState() => _KycReviewScreenState();
}

class _KycReviewScreenState extends State<KycReviewScreen> {
  final _users = [
    {
      'initials': 'AT', 'name': 'Abebe Tesfaye General Construction', 'type': 'Construction',
      'city': 'Addis Ababa', 'submitted': 'Jan 14, 2026',
      'docs': [('License', 'verified'), ('Tax Cert', 'verified'), ('Portfolio', 'pending')],
      'status': 'pending', 'color': const Color(0xFF2563EB),
    },
    {
      'initials': 'LM', 'name': 'Lemlem Mulatu IT Solutions PLC', 'type': 'IT Services',
      'city': 'Hawassa', 'submitted': 'Jan 15, 2026',
      'docs': [('License', 'verified'), ('Tax Cert', 'verified'), ('Portfolio', 'verified')],
      'status': 'pending', 'color': const Color(0xFF7C3AED),
    },
    {
      'initials': 'BG', 'name': 'Biruk & Genet Catering Services', 'type': 'Catering',
      'city': 'Bahir Dar', 'submitted': 'Jan 16, 2026',
      'docs': [('License', 'pending'), ('Tax Cert', 'missing'), ('Portfolio', 'missing')],
      'status': 'incomplete', 'color': const Color(0xFFEA580C),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textMuted),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('KYC Verification Queue'),
        subtitle: const Text('4 pending verifications', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _users.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final u = _users[i];
          final docs = u['docs'] as List<(String, String)>;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.dark3,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderDim),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(color: u['color'] as Color, shape: BoxShape.circle),
                      child: Center(child: Text(u['initials'] as String,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(u['name'] as String,
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          Text('${u['type']} • ${u['city']}',
                              style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                          Text('Submitted: ${u['submitted']}',
                              style: const TextStyle(fontSize: 11, color: AppColors.textDim)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8, runSpacing: 6,
                  children: docs.map((doc) {
                    final (name, status) = doc;
                    final type = status == 'verified' ? ChipType.green
                        : status == 'pending' ? ChipType.gold : ChipType.red;
                    final label = status == 'verified' ? '$name ✓'
                        : status == 'pending' ? '$name ⏳' : '$name ✗';
                    return StatusChip(label: label, type: type);
                  }).toList(),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textMuted,
                          side: const BorderSide(color: AppColors.borderDim),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {},
                        child: const Text('👁 Review Docs', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.greenDim,
                          foregroundColor: AppColors.green,
                          minimumSize: const Size(0, 42),
                          side: BorderSide(color: AppColors.green.withOpacity(0.3)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: u['status'] == 'incomplete' ? null : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('✅ User approved!'), backgroundColor: AppColors.green),
                          );
                        },
                        child: const Text('✓ Approve', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.redDim,
                          foregroundColor: AppColors.red,
                          minimumSize: const Size(0, 42),
                          side: BorderSide(color: AppColors.red.withOpacity(0.3)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('✗ User rejected'), backgroundColor: AppColors.red),
                          );
                        },
                        child: const Text('✗ Reject', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── POST TENDER ───────────────────────────────────────────────
class PostTenderScreen extends StatefulWidget {
  const PostTenderScreen({super.key});
  @override
  State<PostTenderScreen> createState() => _PostTenderScreenState();
}

class _PostTenderScreenState extends State<PostTenderScreen> {
  String _selectedCategory = 'Construction';
  final _categories = ['Construction', 'IT', 'Supply', 'Catering', 'Medical', 'Consulting'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textMuted),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Post New Tender'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Smart match preview
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.goldDim,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Text('🎯', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Smart Matching Preview', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.w600, fontSize: 13)),
                        Text('This tender will notify 34 matched contractors', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                      ],
                    ),
                  ),
                  const Text('34', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.gold)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildField('Tender Title', 'Supply of Medical Equipment — Black Lion Hospital', icon: Icons.title),
            const SizedBox(height: 14),
            _buildTextArea('Scope of Work', 'Supply and installation of diagnostic imaging equipment...'),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: _buildField('Budget Min (ETB)', '2,500,000', icon: Icons.attach_money)),
              const SizedBox(width: 12),
              Expanded(child: _buildField('Budget Max (ETB)', '4,000,000', icon: Icons.attach_money)),
            ]),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: _buildField('Location', 'Addis Ababa', icon: Icons.location_on_outlined)),
              const SizedBox(width: 12),
              Expanded(child: _buildField('Deadline', 'Feb 28, 2026', icon: Icons.calendar_today_outlined)),
            ]),

            const SizedBox(height: 14),
            const SectionLabel('Category Tags'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: _categories.map((cat) {
                final sel = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: sel ? AppColors.goldDim : AppColors.dark4,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sel ? AppColors.gold : AppColors.borderDim),
                    ),
                    child: Text(cat, style: TextStyle(fontSize: 12, color: sel ? AppColors.gold : AppColors.textMuted, fontWeight: sel ? FontWeight.w600 : FontWeight.w400)),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 52, width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('🚀 Tender posted! 34 contractors notified.'), backgroundColor: AppColors.green),
                  );
                  Navigator.pop(context);
                },
                child: const Text('🚀  Post Tender & Notify Contractors'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, {IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label),
        const SizedBox(height: 6),
        TextField(
          controller: TextEditingController(text: hint),
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: icon != null ? Icon(icon, size: 16, color: AppColors.textMuted) : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.borderDim)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.borderDim)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.gold)),
            filled: true, fillColor: AppColors.dark4,
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label),
        const SizedBox(height: 6),
        TextField(
          controller: TextEditingController(text: hint),
          maxLines: 4,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.borderDim)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.borderDim)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.gold)),
            filled: true, fillColor: AppColors.dark4,
          ),
        ),
      ],
    );
  }
}
