import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../data/mock_data.dart';

// ── PAYMENT TRACKER ───────────────────────────────────────────
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
        title: const Text('Financial Tracker'),
        actions: [
          TextButton(
            onPressed: () => context.go('/contractor/invoice'),
            child: const Text('📄 Invoice', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── PROGRESS CARD ──
            InfoCard(
              borderColor: AppColors.border,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Contract Progress',
                      style: TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w600, letterSpacing: 0.8)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // Ring
                      SizedBox(
                        width: 88, height: 88,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 88, height: 88,
                              child: CircularProgressIndicator(
                                value: 0.65,
                                strokeWidth: 8,
                                backgroundColor: AppColors.dark5,
                                valueColor: const AlwaysStoppedAnimation(AppColors.gold),
                              ),
                            ),
                            const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('65%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.gold)),
                                  Text('Paid', style: TextStyle(fontSize: 9, color: AppColors.textDim)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _MoneyRow('Contract Value', '875,000 ETB', AppColors.textMuted),
                            const SizedBox(height: 8),
                            _MoneyRow('Total Paid', '568,750 ETB', AppColors.green),
                            const SizedBox(height: 8),
                            _MoneyRow('Remaining', '306,250 ETB', AppColors.textPrimary),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const PaymentProgressBar(percent: 0.65, paid: '568,750 ETB', remaining: '306,250 ETB'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const SectionLabel('Payment History'),
            const SizedBox(height: 10),

            ...MockData.payments.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _PaymentRow(payment: p),
            )),

            const SizedBox(height: 24),

            // ── LOG PAYMENT ──
            const SectionLabel('Log New Payment'),
            const SizedBox(height: 10),
            InfoCard(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const SectionLabel('Amount (ETB)'),
                          const SizedBox(height: 6),
                          TextField(
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: '0.00',
                              filled: true, fillColor: AppColors.dark4, isDense: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.borderDim)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.borderDim)),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.gold)),
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const SectionLabel('Date'),
                          const SizedBox(height: 6),
                          TextField(
                            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Jan 20, 2026',
                              filled: true, fillColor: AppColors.dark4, isDense: true,
                              prefixIcon: const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textMuted),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.borderDim)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.borderDim)),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.gold)),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SectionLabel('Reference Number'),
                    const SizedBox(height: 6),
                    TextField(
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Bank transaction ID or reference',
                        filled: true, fillColor: AppColors.dark4, isDense: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.borderDim)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.borderDim)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.gold)),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 14),
                  SizedBox(height: 46, width: double.infinity,
                      child: ElevatedButton(onPressed: () {}, child: const Text('Record Payment'))),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _MoneyRow extends StatelessWidget {
  final String label, amount;
  final Color color;
  const _MoneyRow(this.label, this.amount, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        Text(amount, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final PaymentModel payment;
  const _PaymentRow({required this.payment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.dark3,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderDim),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: AppColors.greenDim, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.account_balance, size: 18, color: AppColors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(payment.method, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                Row(children: [
                  Text(payment.date, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  const SizedBox(width: 6),
                  Text('· ${payment.reference}', style: const TextStyle(fontSize: 11, color: AppColors.textDim)),
                ]),
              ],
            ),
          ),
          Text('${payment.amount} ETB', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.green)),
        ],
      ),
    );
  }
}

// ── INVOICE SCREEN ────────────────────────────────────────────
class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

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
        title: const Text('Invoice'),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined, color: AppColors.gold), onPressed: () {}),
          IconButton(icon: const Icon(Icons.download_outlined, color: AppColors.gold), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Mikael Taye General Contractors',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E))),
                        SizedBox(height: 2),
                        Text('Construction & Civil Works', style: TextStyle(fontSize: 11, color: Colors.grey)),
                        Text('TIN: 0034-56789', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('INVOICE', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.gold, letterSpacing: 2)),
                      Text('#INV-2026-0042', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      Text('Jan 18, 2026', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(height: 2, color: AppColors.gold),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('BILLED TO', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.grey, letterSpacing: 1)),
                        SizedBox(height: 4),
                        Text('Addis Ababa City Roads Authority', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
                        Text('Bole Sub-City, Addis Ababa', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('PROJECT', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.grey, letterSpacing: 1)),
                        SizedBox(height: 4),
                        Text('Road Rehabilitation — Bole Phase II', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
                        Text('Contract: 875,000 ETB', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Table header
              Container(
                color: const Color(0xFF1A1A2E),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: const Row(
                  children: [
                    Expanded(flex: 3, child: Text('Description', style: TextStyle(fontSize: 10, color: AppColors.gold, fontWeight: FontWeight.w700))),
                    Expanded(flex: 2, child: Text('Date', style: TextStyle(fontSize: 10, color: AppColors.gold, fontWeight: FontWeight.w700))),
                    Text('Amount', style: TextStyle(fontSize: 10, color: AppColors.gold, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              ...MockData.payments.map((p) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0)))),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text(p.method, style: const TextStyle(fontSize: 11, color: Color(0xFF333333)))),
                    Expanded(flex: 2, child: Text(p.date, style: const TextStyle(fontSize: 11, color: Colors.grey))),
                    Text('${p.amount} ETB', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF333333))),
                  ],
                ),
              )),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    _TotalRow('Subtotal', '568,750 ETB', false),
                    SizedBox(height: 4),
                    _TotalRow('Balance Remaining', '306,250 ETB', false),
                    SizedBox(height: 8),
                    Divider(color: AppColors.gold, thickness: 1.5),
                    SizedBox(height: 4),
                    _TotalRow('TOTAL PAID', '568,750 ETB', true),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text('Generated by Tenet Tender Ecosystem • tenet.et',
                    style: TextStyle(fontSize: 9, color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label, amount;
  final bool isBold;
  const _TotalRow(this.label, this.amount, this.isBold);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 140,
          child: Text(label, style: TextStyle(fontSize: isBold ? 13 : 11, fontWeight: isBold ? FontWeight.w800 : FontWeight.w400, color: isBold ? AppColors.gold : Colors.grey)),
        ),
        SizedBox(
          width: 100,
          child: Text(amount, textAlign: TextAlign.right, style: TextStyle(fontSize: isBold ? 13 : 11, fontWeight: isBold ? FontWeight.w800 : FontWeight.w600, color: isBold ? AppColors.gold : const Color(0xFF333333))),
        ),
      ],
    );
  }
}

// ── WORKSHOPS ────────────────────────────────────────────────
class WorkshopsScreen extends StatefulWidget {
  const WorkshopsScreen({super.key});
  @override
  State<WorkshopsScreen> createState() => _WorkshopsScreenState();
}

class _WorkshopsScreenState extends State<WorkshopsScreen> {
  final List<bool> _registered = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(backgroundColor: AppColors.dark2, title: const Text('Workshops & Training')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.workshops.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final w = MockData.workshops[i];
          final isReg = _registered[i];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.dark3,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderDim),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56, padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.goldDim,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Text(w.day, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.gold, height: 1)),
                      Text(w.month, style: const TextStyle(fontSize: 10, color: AppColors.gold, letterSpacing: 1)),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(w.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      Text(w.description, style: const TextStyle(fontSize: 12, color: AppColors.textMuted, height: 1.5), maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 10),
                      Wrap(spacing: 8, runSpacing: 6, children: [
                        TagChip('📍 ${w.location}'),
                        TagChip('⏰ ${w.time}'),
                        TagChip('👥 ${w.registeredCount}'),
                      ]),
                      const SizedBox(height: 10),
                      GoldButton(
                        label: isReg ? '✓ Registered' : 'Register →',
                        onTap: () => setState(() => _registered[i] = !_registered[i]),
                        isSmall: true,
                        isOutline: isReg,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
