import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../data/mock_data.dart';

class ContractorDashboard extends StatelessWidget {
  const ContractorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: Row(
          children: [
            Container(
              width: 30, height: 30,
              decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
              child: const Center(child: Text('T', style: TextStyle(color: AppColors.dark, fontWeight: FontWeight.w900, fontSize: 14))),
            ),
            const SizedBox(width: 8),
            const Text('Tenet', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.w800, fontSize: 18)),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: AppColors.textMuted),
                onPressed: () {},
              ),
              Positioned(
                top: 8, right: 8,
                child: Container(
                  width: 9, height: 9,
                  decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              width: 34, height: 34,
              decoration: BoxDecoration(
                color: AppColors.gold,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: const Center(child: Text('MT', style: TextStyle(color: AppColors.dark, fontWeight: FontWeight.w700, fontSize: 11))),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: AppColors.borderDim),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── GREETING ──
            const Text('Good morning, Mikael 👋',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            const Text("Here's what's happening today",
                style: TextStyle(fontSize: 13, color: AppColors.textMuted)),

            const SizedBox(height: 20),

            // ── KYC BANNER ──
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.greenDim,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.green.withOpacity(0.3)),
              ),
              child: const Row(
                children: [
                  Text('✅', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('KYC Verified', style: TextStyle(color: AppColors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                        Text('Your profile is fully verified. You can bid on all open tenders.',
                            style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── STATS GRID ──
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: const [
                StatCard(number: '12', label: 'Active Bids', delta: '↑ 3 this week', emoji: '📋', accentColor: AppColors.gold),
                StatCard(number: '4', label: 'Won Projects', delta: '↑ 1 new award', emoji: '🏆', accentColor: AppColors.green),
                StatCard(number: '28', label: 'Matched Tenders', delta: '↑ 8 new matches', emoji: '💡', accentColor: AppColors.blue),
                StatCard(number: '2.4M', label: 'ETB Earned', delta: '↑ 340K this month', emoji: '💰', accentColor: AppColors.orange),
              ],
            ),

            const SizedBox(height: 24),

            // ── QUICK ACTIONS ──
            const SectionLabel('Quick Actions'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _QuickAction(emoji: '🔍', label: 'Browse Tenders', onTap: () => context.go('/contractor/tenders'))),
                const SizedBox(width: 10),
                Expanded(child: _QuickAction(emoji: '🏗️', label: 'My Projects', onTap: () => context.go('/contractor/projects'))),
                const SizedBox(width: 10),
                Expanded(child: _QuickAction(emoji: '💬', label: 'Messages', onTap: () => context.go('/contractor/chat'))),
              ],
            ),

            const SizedBox(height: 24),

            // ── RECENT ACTIVITY ──
            const SectionHeader(title: 'Recent Activity'),
            const SizedBox(height: 12),
            _ActivityTile(emoji: '🎉', title: 'Bid Awarded!', subtitle: 'Road Rehabilitation Phase II — 875,000 ETB', chip: StatusChip(label: 'Awarded', type: ChipType.green), onTap: () => context.go('/contractor/projects')),
            const SizedBox(height: 8),
            _ActivityTile(emoji: '🔔', title: 'New Tender Match', subtitle: 'IT Infrastructure Supply — Hawassa', chip: StatusChip(label: 'New', type: ChipType.gold), onTap: () => context.go('/contractor/tenders')),
            const SizedBox(height: 8),
            _ActivityTile(emoji: '💰', title: 'Payment Received', subtitle: 'Admin logged 131,250 ETB via Awash Bank', chip: StatusChip(label: 'Paid', type: ChipType.blue), onTap: () => context.go('/contractor/payments')),

            const SizedBox(height: 24),

            // ── RECOMMENDED TENDERS ──
            SectionHeader(
              title: 'Recommended for You',
              action: GestureDetector(
                onTap: () => context.go('/contractor/tenders'),
                child: const Text('See all', style: TextStyle(color: AppColors.gold, fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 12),
            ...MockData.tenders.take(2).map((tender) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _RecommendedTenderCard(tender: tender, onTap: () => context.go('/contractor/tender-detail')),
            )),

            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(currentIndex: 0),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String emoji, label;
  final VoidCallback onTap;
  const _QuickAction({required this.emoji, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.dark3,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderDim),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String emoji, title, subtitle;
  final Widget chip;
  final VoidCallback onTap;
  const _ActivityTile({required this.emoji, required this.title, required this.subtitle, required this.chip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.dark3,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderDim),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
            ),
            chip,
          ],
        ),
      ),
    );
  }
}

class _RecommendedTenderCard extends StatelessWidget {
  final TenderModel tender;
  final VoidCallback onTap;
  const _RecommendedTenderCard({required this.tender, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.dark3,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderDim),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(tender.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                StatusChip(label: '${tender.matchPercent}% match',
                    type: tender.matchPercent >= 90 ? ChipType.gold : ChipType.blue),
              ],
            ),
            const SizedBox(height: 4),
            Text(tender.organization, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.attach_money, size: 13, color: AppColors.gold),
                Text('ETB ${tender.budgetMin}–${tender.budgetMax}',
                    style: const TextStyle(fontSize: 12, color: AppColors.gold, fontWeight: FontWeight.w600)),
                const Spacer(),
                const Icon(Icons.calendar_today_outlined, size: 11, color: AppColors.textMuted),
                const SizedBox(width: 3),
                Text(tender.deadline, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  const _BottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.dark2,
        border: Border(top: BorderSide(color: AppColors.borderDim)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: AppColors.textDim,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: (i) {
          const routes = [
            '/contractor/dashboard',
            '/contractor/tenders',
            '/contractor/projects',
            '/contractor/chat',
          ];
          context.go(routes[i]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), activeIcon: Icon(Icons.assignment), label: 'Tenders'),
          BottomNavigationBarItem(icon: Icon(Icons.construction_outlined), activeIcon: Icon(Icons.construction), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), activeIcon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
    );
  }
}
