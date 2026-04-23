import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ── STATUS CHIP ──────────────────────────────────────────────
class StatusChip extends StatelessWidget {
  final String label;
  final ChipType type;
  const StatusChip({super.key, required this.label, this.type = ChipType.gold});

  @override
  Widget build(BuildContext context) {
    final colors = {
      ChipType.gold: (AppColors.goldDim, AppColors.gold),
      ChipType.green: (AppColors.greenDim, AppColors.green),
      ChipType.red: (AppColors.redDim, AppColors.red),
      ChipType.blue: (AppColors.blueDim, AppColors.blue),
      ChipType.gray: (AppColors.dark5, AppColors.textMuted),
      ChipType.orange: (AppColors.orangeDim, AppColors.orange),
    };
    final (bg, fg) = colors[type]!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 5, height: 5, decoration: BoxDecoration(color: fg, shape: BoxShape.circle)),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

enum ChipType { gold, green, red, blue, gray, orange }

// ── SECTION HEADER ────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  const SectionHeader({super.key, required this.title, this.subtitle, this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              if (subtitle != null) ...[
                const SizedBox(height: 3),
                Text(subtitle!, style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
              ],
            ],
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}

// ── GOLD BUTTON ───────────────────────────────────────────────
class GoldButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final String? icon;
  final bool isSmall;
  final bool isOutline;
  const GoldButton({super.key, required this.label, required this.onTap, this.icon, this.isSmall = false, this.isOutline = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isSmall ? 14 : 18, vertical: isSmall ? 8 : 13),
        decoration: BoxDecoration(
          color: isOutline ? Colors.transparent : AppColors.gold,
          borderRadius: BorderRadius.circular(10),
          border: isOutline ? Border.all(color: AppColors.border) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Text(icon!, style: TextStyle(fontSize: isSmall ? 13 : 15)), const SizedBox(width: 6)],
            Text(label,
                style: TextStyle(
                  color: isOutline ? AppColors.textMuted : AppColors.dark,
                  fontWeight: FontWeight.w700,
                  fontSize: isSmall ? 12 : 14,
                )),
          ],
        ),
      ),
    );
  }
}

// ── STAT CARD ─────────────────────────────────────────────────
class StatCard extends StatelessWidget {
  final String number;
  final String label;
  final String delta;
  final Color accentColor;
  final String emoji;
  const StatCard({super.key, required this.number, required this.label, required this.delta, required this.emoji, this.accentColor = AppColors.gold});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.dark3,
        borderRadius: BorderRadius.circular(12),
        border: const Border(top: BorderSide(color: AppColors.borderDim, width: 0)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 2, width: 36, decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 10),
              Text(number,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 3),
              Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
              const SizedBox(height: 6),
              Text(delta, style: const TextStyle(fontSize: 11, color: AppColors.green, fontWeight: FontWeight.w600)),
            ],
          ),
          Positioned(
            top: 0, right: 0,
            child: Text(emoji, style: const TextStyle(fontSize: 22)),
          ),
        ],
      ),
    );
  }
}

// ── INFO CARD ─────────────────────────────────────────────────
class InfoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? borderColor;
  const InfoCard({super.key, required this.child, this.padding, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.dark3,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor ?? AppColors.borderDim),
      ),
      child: child,
    );
  }
}

// ── SECTION LABEL ─────────────────────────────────────────────
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: AppColors.textDim),
    );
  }
}

// ── TAG CHIP ─────────────────────────────────────────────────
class TagChip extends StatelessWidget {
  final String label;
  const TagChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.dark5,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderDim),
      ),
      child: Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
    );
  }
}

// ── PAYMENT PROGRESS BAR ──────────────────────────────────────
class PaymentProgressBar extends StatelessWidget {
  final double percent;
  final String paid;
  final String remaining;
  const PaymentProgressBar({super.key, required this.percent, required this.paid, required this.remaining});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 8,
            backgroundColor: AppColors.dark5,
            valueColor: const AlwaysStoppedAnimation(AppColors.gold),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Paid: $paid', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
            Text('Remaining: $remaining', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
      ],
    );
  }
}

// ── GRADIENT DIVIDER ──────────────────────────────────────────
class GoldDivider extends StatelessWidget {
  const GoldDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, AppColors.borderDim, Colors.transparent],
        ),
      ),
    );
  }
}
