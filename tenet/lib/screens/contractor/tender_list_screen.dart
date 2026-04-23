import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../data/mock_data.dart';

class TenderListScreen extends StatefulWidget {
  const TenderListScreen({super.key});
  @override
  State<TenderListScreen> createState() => _TenderListScreenState();
}

class _TenderListScreenState extends State<TenderListScreen> {
  String _selectedCategory = 'All';
  final _categories = ['All', 'Construction', 'IT', 'Supply', 'Catering', 'Medical'];

  List<TenderModel> get _filtered {
    if (_selectedCategory == 'All') return MockData.tenders;
    return MockData.tenders.where((t) => t.category.contains(_selectedCategory)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: const Text('Tender Marketplace'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(49),
          child: Column(
            children: [
              const Divider(height: 1, color: AppColors.borderDim),
              SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  itemCount: _categories.length,
                  itemBuilder: (_, i) {
                    final cat = _categories[i];
                    final active = _selectedCategory == cat;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: active ? AppColors.gold : AppColors.dark4,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: active ? AppColors.gold : AppColors.borderDim),
                        ),
                        child: Center(
                          child: Text(cat,
                              style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600,
                                color: active ? AppColors.dark : AppColors.textMuted,
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            color: AppColors.dark2,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search tenders...',
                prefixIcon: const Icon(Icons.search, color: AppColors.textMuted, size: 20),
                fillColor: AppColors.dark4,
                filled: true,
                isDense: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderDim)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.borderDim)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.gold)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
            ),
          ),
          // Match count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderDim))),
            child: Row(
              children: [
                Text('${_filtered.length} tenders', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.goldDim, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.border)),
                  child: const Text('🎯  Smart Match ON', style: TextStyle(fontSize: 11, color: AppColors.gold, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => TenderCard(tender: _filtered[i], onTap: () => context.go('/contractor/tender-detail')),
            ),
          ),
        ],
      ),
    );
  }
}

class TenderCard extends StatelessWidget {
  final TenderModel tender;
  final VoidCallback onTap;
  const TenderCard({super.key, required this.tender, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isClosed = tender.status == 'closed';
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tender.title,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 3),
                      Text(tender.organization,
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StatusChip(label: isClosed ? 'Closed' : 'Open', type: isClosed ? ChipType.gray : ChipType.green),
                    if (!isClosed) ...[
                      const SizedBox(height: 4),
                      StatusChip(
                        label: '${tender.matchPercent}% match',
                        type: tender.matchPercent >= 90 ? ChipType.gold : ChipType.blue,
                      ),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10, runSpacing: 4,
              children: [
                _Meta(icon: Icons.location_on_outlined, text: tender.location),
                _Meta(icon: Icons.calendar_today_outlined, text: tender.deadline),
                _Meta(icon: Icons.label_outline, text: tender.category),
                _Meta(icon: Icons.people_outline, text: '${tender.bidCount} bids'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('ETB ${tender.budgetMin} – ${tender.budgetMax}',
                    style: const TextStyle(fontSize: 13, color: AppColors.gold, fontWeight: FontWeight.w600)),
                const Spacer(),
                if (!isClosed)
                  GoldButton(
                    label: 'Submit Bid',
                    onTap: () => context.go('/contractor/bid-form'),
                    isSmall: true,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Meta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColors.textMuted),
        const SizedBox(width: 3),
        Text(text, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
      ],
    );
  }
}
