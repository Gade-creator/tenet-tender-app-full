import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../data/mock_data.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

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
            const Text('Tenet Admin', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.w800, fontSize: 18)),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(icon: const Icon(Icons.notifications_outlined, color: AppColors.textMuted), onPressed: () {}),
              Positioned(
                top: 8, right: 8,
                child: Container(
                  width: 9, height: 9,
                  decoration: const BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 34, height: 34,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF4C1D95)]),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            child: const Center(child: Text('SK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Admin Dashboard', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('Platform overview — Jan 18, 2026', style: TextStyle(fontSize: 13, color: AppColors.textMuted)),

            const SizedBox(height: 20),

            // ── KYC ALERT ──
            GestureDetector(
              onTap: () => context.go('/admin/kyc'),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.redDim,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.red.withOpacity(0.3)),
                ),
                child: const Row(
                  children: [
                    Text('🪪', style: TextStyle(fontSize: 18)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('4 KYC Verifications Pending', style: TextStyle(color: AppColors.red, fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('Tap to review documents and approve or reject', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.red),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: const [
                StatCard(number: '42', label: 'Active Tenders', delta: '↑ 5 this week', emoji: '📋', accentColor: AppColors.gold),
                StatCard(number: '187', label: 'Registered Users', delta: '↑ 12 new today', emoji: '👥', accentColor: AppColors.blue),
                StatCard(number: '23', label: 'Live Projects', delta: '3 near deadline', emoji: '🏗️', accentColor: AppColors.green),
                StatCard(number: '4', label: 'KYC Pending', delta: '⚠️ Needs review', emoji: '🪪', accentColor: AppColors.red),
              ],
            ),

            const SizedBox(height: 24),

            const SectionLabel('Admin Actions'),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: _AdminAction(emoji: '➕', label: 'Post Tender', onTap: () => context.go('/admin/post-tender'))),
              const SizedBox(width: 10),
              Expanded(child: _AdminAction(emoji: '🪪', label: 'KYC Queue', badge: '4', onTap: () => context.go('/admin/kyc'))),
              const SizedBox(width: 10),
              Expanded(child: _AdminAction(emoji: '📊', label: 'Bid Reviews', onTap: () {})),
            ]),

            const SizedBox(height: 24),

            SectionHeader(
              title: 'Recent Bid Activity',
              action: const Text('View all', style: TextStyle(color: AppColors.gold, fontSize: 13, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 12),

            InfoCard(
              child: Column(
                children: MockData.bids.map((bid) {
                  final chipType = bid.status == 'awarded' ? ChipType.green
                      : bid.status == 'shortlisted' ? ChipType.gold
                      : bid.status == 'rejected' ? ChipType.red : ChipType.gray;
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderDim, width: bid == MockData.bids.last ? 0 : 1))),
                    child: Row(
                      children: [
                        Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(color: AppColors.dark5, borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text(bid.contractorName[0], style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.gold))),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(bid.contractorName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                              Text('${bid.amount} ETB · ${bid.timelineDays} days', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                            ],
                          ),
                        ),
                        StatusChip(label: bid.status, type: chipType),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: AppColors.dark2, border: Border(top: BorderSide(color: AppColors.borderDim))),
        child: BottomNavigationBar(
          currentIndex: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.gold,
          unselectedItemColor: AppColors.textDim,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: (i) {
            const routes = ['/admin/dashboard', '/admin/post-tender', '/admin/kyc', '/contractor/chat'];
            context.go(routes[i]);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), activeIcon: Icon(Icons.add_box), label: 'Post'),
            BottomNavigationBarItem(icon: Icon(Icons.verified_user_outlined), activeIcon: Icon(Icons.verified_user), label: 'KYC'),
            BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), activeIcon: Icon(Icons.chat), label: 'Chat'),
          ],
        ),
      ),
    );
  }
}

class _AdminAction extends StatelessWidget {
  final String emoji, label;
  final String? badge;
  final VoidCallback onTap;
  const _AdminAction({required this.emoji, required this.label, required this.onTap, this.badge});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
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
          if (badge != null)
            Positioned(
              top: -6, right: -6,
              child: Container(
                width: 20, height: 20,
                decoration: const BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
                child: Center(child: Text(badge!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white))),
              ),
            ),
        ],
      ),
    );
  }
}
