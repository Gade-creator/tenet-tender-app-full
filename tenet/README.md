# Tenet Tender Ecosystem — Flutter Showcase App

Premium investor showcase demonstrating the complete MVP workflow.

## Screens Included

### Auth
- `Login Screen` — Role selector (Contractor / Admin / Tender Owner), email + password
- `Register Screen` — 3-step form: Account details → Business profile → Review & submit

### Contractor Flow
- `Dashboard` — Stats, recent activity, recommended tenders
- `Tender Marketplace` — Browse with category filters, search bar, match scores
- `Tender Detail` — Full scope, required docs, match banner
- `Bid Form` — Technical proposal, price, timeline, document attachments, checklist
- `Project Workspace` — Kanban board (To Do / In Progress / Done), overdue highlighting
- `Chat` — Context-linked real-time messaging with send functionality
- `Payment Tracker` — Progress ring, payment history, log new payment
- `Invoice` — Branded PDF-style invoice preview with download
- `Workshops` — Training event listing with registration toggle

### Admin Flow
- `Admin Dashboard` — Platform stats, KYC alert, bid activity
- `KYC Queue` — Review documents, approve / reject contractors
- `Post Tender` — Form with smart matching preview (34 contractors notified)

---

## Quick Start

```bash
# 1. Open the project
cd tenet

# 2. Get dependencies
flutter pub get

# 3. Run on device / emulator
flutter run

# 4. For Android release APK
flutter build apk --release

# 5. For iOS
flutter build ios --release
```

## Requirements
- Flutter SDK 3.x (Dart 3.x)
- Android Studio (for Android emulator) OR Xcode (for iOS simulator)
- VS Code with Flutter + Dart extensions

## Tech Used
- **Navigation:** go_router 13.x
- **Fonts:** google_fonts (DM Sans)
- **Theme:** Custom dark theme with gold accent (`AppColors`)
- **State:** StatefulWidgets (ready to swap to Riverpod for production)

## Structure
```
lib/
├── main.dart              # Entry point
├── router.dart            # All GoRouter routes
├── theme/
│   └── app_theme.dart     # Colors, theme, input styles
├── data/
│   └── mock_data.dart     # All demo data (tenders, bids, tasks, etc.)
├── widgets/
│   └── shared_widgets.dart # StatusChip, StatCard, GoldButton, etc.
└── screens/
    ├── auth/
    │   ├── login_screen.dart
    │   └── register_screen.dart
    ├── contractor/
    │   ├── dashboard_screen.dart
    │   ├── tender_list_screen.dart
    │   ├── tender_detail_screen.dart  # Includes BidFormScreen
    │   ├── project_workspace_screen.dart
    │   ├── chat_screen.dart
    │   └── payment_screen.dart        # Includes InvoiceScreen + WorkshopsScreen
    └── admin/
        ├── admin_dashboard_screen.dart
        └── admin_screens.dart          # Includes KycReviewScreen + PostTenderScreen
```

## Investor Demo Flow
1. Open app → Login as Contractor
2. Dashboard → tap "Browse Tenders"
3. Tap first tender → Submit Bid
4. Fill bid form → Submit → auto-navigate to Kanban
5. See project board with overdue tasks
6. Navigate to Chat → send a message
7. Navigate to Payments → see progress ring
8. Navigate to Invoice → see branded PDF
9. Go back to Login → switch to Admin role
10. Admin Dashboard → KYC Queue → Post Tender

---
*Tenet Tender Ecosystem MVP Showcase — Afomiya Platform*
