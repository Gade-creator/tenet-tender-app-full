import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../data/mock_data.dart';

// ── TENDER DETAIL ─────────────────────────────────────────────
class TenderDetailScreen extends StatelessWidget {
  const TenderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tender = MockData.tenders.first;
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textMuted),
          onPressed: () => context.go('/contractor/tenders'),
        ),
        title: const Text('Tender Detail'),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined, color: AppColors.textMuted), onPressed: () {}),
          IconButton(icon: const Icon(Icons.bookmark_border_outlined, color: AppColors.textMuted), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── TITLE ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(tender.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                ),
                const SizedBox(width: 10),
                const StatusChip(label: 'Open', type: ChipType.green),
              ],
            ),
            const SizedBox(height: 6),
            Text(tender.organization, style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),

            const SizedBox(height: 14),

            // ── MATCH BANNER ──
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.goldDim,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Text('🎯', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${tender.matchPercent}% Profile Match',
                          style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w600, fontSize: 13)),
                      const Text('Your Construction skills align with this tender',
                          style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ── DETAILS GRID ──
            InfoCard(
              child: Column(
                children: [
                  _DetailRow('💰 Budget', 'ETB ${tender.budgetMin} – ${tender.budgetMax}', isGold: true),
                  const Divider(color: AppColors.borderDim, height: 16),
                  _DetailRow('📅 Deadline', tender.deadline),
                  const Divider(color: AppColors.borderDim, height: 16),
                  _DetailRow('📍 Location', tender.location),
                  const Divider(color: AppColors.borderDim, height: 16),
                  _DetailRow('🏷 Category', tender.category),
                  const Divider(color: AppColors.borderDim, height: 16),
                  _DetailRow('👥 Bids Submitted', '${tender.bidCount} contractors'),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ── SCOPE ──
            const SectionLabel('Scope of Work'),
            const SizedBox(height: 8),
            InfoCard(
              child: const Text(
                'Supply of materials and construction services for the rehabilitation of approximately 4.2km of asphalt road in Bole Sub-City. Work includes milling of existing pavement, base course repair, new asphalt overlay, drainage improvements, road markings, and traffic signage installation. Contractor must comply with AACRA specifications.',
                style: TextStyle(fontSize: 13, color: AppColors.textMuted, height: 1.7),
              ),
            ),

            const SizedBox(height: 18),

            // ── REQUIRED DOCS ──
            const SectionLabel('Required Documents'),
            const SizedBox(height: 8),
            InfoCard(
              child: Column(
                children: [
                  _DocRow('📄 Valid Business License (Grade 3+)'),
                  const SizedBox(height: 8),
                  _DocRow('📄 Tax Clearance Certificate (Current Year)'),
                  const SizedBox(height: 8),
                  _DocRow('📄 Portfolio of Similar Projects (Min. 2)'),
                  const SizedBox(height: 8),
                  _DocRow('📄 Equipment & Machinery List'),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: const BoxDecoration(
          color: AppColors.dark2,
          border: Border(top: BorderSide(color: AppColors.borderDim)),
        ),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: () => context.go('/contractor/bid-form'),
            child: const Text('Submit Your Bid →'),
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label, value;
  final bool isGold;
  const _DetailRow(this.label, this.value, {this.isGold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted))),
        Text(value,
            style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600,
              color: isGold ? AppColors.gold : AppColors.textPrimary,
            )),
      ],
    );
  }
}

class _DocRow extends StatelessWidget {
  final String text;
  const _DocRow(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: AppColors.dark4, borderRadius: BorderRadius.circular(6)),
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

// ── BID FORM ─────────────────────────────────────────────────
class BidFormScreen extends StatefulWidget {
  const BidFormScreen({super.key});
  @override
  State<BidFormScreen> createState() => _BidFormScreenState();
}

class _BidFormScreenState extends State<BidFormScreen> {
  final _proposalCtrl = TextEditingController(
      text: 'Our approach follows AACRA Phase II specifications. We will deploy two Wirtgen W200 milling machines for pavement removal, followed by base course stabilization...');
  final _priceCtrl = TextEditingController(text: '875000');
  final _timelineCtrl = TextEditingController(text: '75');
  bool _loading = false;

  Future<void> _submitBid() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Bid submitted successfully!'),
        backgroundColor: AppColors.green,
        duration: Duration(seconds: 2),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) context.go('/contractor/projects');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textMuted),
          onPressed: () => context.go('/contractor/tender-detail'),
        ),
        title: const Text('Submit Bid'),
        subtitle: const Text('Road Rehab — Bole Sub-City', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SectionLabel('Technical Proposal'),
            const SizedBox(height: 8),
            TextField(
              controller: _proposalCtrl,
              maxLines: 6,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Describe your methodology, approach, and quality plan...',
                alignLabelWithHint: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderDim)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderDim)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.gold)),
                filled: true, fillColor: AppColors.dark4,
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionLabel('Financial Proposal (ETB)'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _priceCtrl,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: AppColors.gold, fontSize: 20, fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          prefixText: 'ETB ',
                          prefixStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                          filled: true, fillColor: AppColors.dark4,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderDim)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderDim)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.gold, width: 1.5)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionLabel('Timeline (days)'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _timelineCtrl,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          suffixText: 'days',
                          suffixStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                          filled: true, fillColor: AppColors.dark4,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderDim)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderDim)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.gold, width: 1.5)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            const SectionLabel('Documents'),
            const SizedBox(height: 10),
            _AttachmentRow(name: 'Business_License_2025.pdf', status: 'verified'),
            const SizedBox(height: 8),
            _AttachmentRow(name: 'Tax_Clearance_2025.pdf', status: 'verified'),
            const SizedBox(height: 8),
            _AttachmentRow(name: 'Portfolio PDF', status: 'upload'),

            const SizedBox(height: 18),

            // ── CHECKLIST ──
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Bid Checklist', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                  const SizedBox(height: 10),
                  _Check('Technical proposal filled', done: true),
                  _Check('Financial proposal set', done: true),
                  _Check('Timeline provided', done: true),
                  _Check('Business license attached', done: true),
                  _Check('Tax clearance attached', done: true),
                  _Check('Portfolio PDF pending', done: false),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: const BoxDecoration(
          color: AppColors.dark2,
          border: Border(top: BorderSide(color: AppColors.borderDim)),
        ),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: _loading ? null : _submitBid,
            child: _loading
                ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: AppColors.dark, strokeWidth: 2.5))
                : const Text('🚀  Submit Bid — ETB 875,000'),
          ),
        ),
      ),
    );
  }
}

class _AttachmentRow extends StatelessWidget {
  final String name, status;
  const _AttachmentRow({required this.name, required this.status});

  @override
  Widget build(BuildContext context) {
    final isVerified = status == 'verified';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.dark4,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isVerified ? AppColors.green.withOpacity(0.3) : AppColors.borderDim),
      ),
      child: Row(
        children: [
          Text(isVerified ? '✅' : '📎', style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 13)),
                if (isVerified) const Text('From your Document Vault', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
              ],
            ),
          ),
          if (isVerified)
            const StatusChip(label: 'Verified', type: ChipType.green)
          else
            GoldButton(label: 'Upload', onTap: () {}, isSmall: true, isOutline: true),
        ],
      ),
    );
  }
}

class _Check extends StatelessWidget {
  final String label;
  final bool done;
  const _Check(this.label, {required this.done});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(done ? Icons.check_circle : Icons.radio_button_unchecked,
              size: 16, color: done ? AppColors.green : AppColors.orange),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 12, color: done ? AppColors.textPrimary : AppColors.orange)),
        ],
      ),
    );
  }
}
