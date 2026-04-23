// ── MODELS ──────────────────────────────────────────────────

class TenderModel {
  final String id;
  final String title;
  final String organization;
  final String location;
  final String category;
  final String budgetMin;
  final String budgetMax;
  final String deadline;
  final String status;
  final int bidCount;
  final int matchPercent;

  const TenderModel({
    required this.id,
    required this.title,
    required this.organization,
    required this.location,
    required this.category,
    required this.budgetMin,
    required this.budgetMax,
    required this.deadline,
    required this.status,
    required this.bidCount,
    required this.matchPercent,
  });
}

class BidModel {
  final String id;
  final String contractorName;
  final String amount;
  final int timelineDays;
  final String status;
  final String submittedDate;

  const BidModel({
    required this.id,
    required this.contractorName,
    required this.amount,
    required this.timelineDays,
    required this.status,
    required this.submittedDate,
  });
}

class TaskModel {
  final String id;
  final String title;
  final String dueDate;
  final String status; // todo | in_progress | done
  final bool isOverdue;
  final bool isMilestone;
  final List<String> tags;

  const TaskModel({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.status,
    this.isOverdue = false,
    this.isMilestone = false,
    this.tags = const [],
  });
}

class MessageModel {
  final String sender;
  final String text;
  final String time;
  final bool isMe;

  const MessageModel({
    required this.sender,
    required this.text,
    required this.time,
    required this.isMe,
  });
}

class PaymentModel {
  final String date;
  final String amount;
  final String method;
  final String reference;

  const PaymentModel({
    required this.date,
    required this.amount,
    required this.method,
    required this.reference,
  });
}

class WorkshopModel {
  final String title;
  final String description;
  final String day;
  final String month;
  final String time;
  final String location;
  final int registeredCount;
  final bool isRegistered;

  const WorkshopModel({
    required this.title,
    required this.description,
    required this.day,
    required this.month,
    required this.time,
    required this.location,
    required this.registeredCount,
    this.isRegistered = false,
  });
}

// ── MOCK DATA ────────────────────────────────────────────────

class MockData {
  static const tenders = [
    TenderModel(
      id: '1',
      title: 'Road Rehabilitation — Bole Sub-City Phase II',
      organization: 'Addis Ababa City Roads Authority',
      location: 'Addis Ababa',
      category: 'Construction',
      budgetMin: '600,000',
      budgetMax: '1,200,000',
      deadline: 'Jan 30, 2026',
      status: 'open',
      bidCount: 14,
      matchPercent: 98,
    ),
    TenderModel(
      id: '2',
      title: 'IT Infrastructure & Network Setup',
      organization: 'Commercial Bank of Ethiopia',
      location: 'Hawassa',
      category: 'IT',
      budgetMin: '120,000',
      budgetMax: '220,000',
      deadline: 'Feb 10, 2026',
      status: 'open',
      bidCount: 7,
      matchPercent: 85,
    ),
    TenderModel(
      id: '3',
      title: 'School Furniture & Equipment Supply',
      organization: 'Ministry of Education',
      location: 'Nationwide',
      category: 'Supply',
      budgetMin: '450,000',
      budgetMax: '650,000',
      deadline: 'Feb 5, 2026',
      status: 'open',
      bidCount: 22,
      matchPercent: 92,
    ),
    TenderModel(
      id: '4',
      title: 'Supply of Medical Equipment — Black Lion Hospital',
      organization: 'Black Lion Hospital',
      location: 'Addis Ababa',
      category: 'Medical Supply',
      budgetMin: '2,500,000',
      budgetMax: '4,000,000',
      deadline: 'Feb 28, 2026',
      status: 'open',
      bidCount: 5,
      matchPercent: 75,
    ),
    TenderModel(
      id: '5',
      title: 'Hospital Catering & Food Supply — Q1 2026',
      organization: 'ALERT Hospital',
      location: 'Addis Ababa',
      category: 'Catering',
      budgetMin: '80,000',
      budgetMax: '150,000',
      deadline: 'Dec 15, 2025',
      status: 'closed',
      bidCount: 31,
      matchPercent: 40,
    ),
  ];

  static const bids = [
    BidModel(id: 'b1', contractorName: 'Mikael Taye General Contractors', amount: '875,000', timelineDays: 75, status: 'awarded', submittedDate: 'Dec 20, 2025'),
    BidModel(id: 'b2', contractorName: 'Abebe Construction PLC', amount: '920,000', timelineDays: 90, status: 'shortlisted', submittedDate: 'Dec 21, 2025'),
    BidModel(id: 'b3', contractorName: 'Selam Civil Works', amount: '1,100,000', timelineDays: 60, status: 'rejected', submittedDate: 'Dec 22, 2025'),
    BidModel(id: 'b4', contractorName: 'Haile & Sons Builders', amount: '780,000', timelineDays: 85, status: 'pending', submittedDate: 'Dec 23, 2025'),
  ];

  static const tasks = [
    TaskModel(id: 't1', title: 'Site survey & clearance', dueDate: 'Completed Dec 20', status: 'done', tags: ['Survey']),
    TaskModel(id: 't2', title: 'Existing pavement milling', dueDate: 'Completed Jan 3', status: 'done', tags: ['Construction']),
    TaskModel(id: 't3', title: 'Base course repair — Section A', dueDate: 'Completed Jan 8', status: 'done', isMilestone: true),
    TaskModel(id: 't4', title: 'Asphalt overlay — Section B', dueDate: 'Overdue: Jan 10', status: 'in_progress', isOverdue: true, tags: ['Construction']),
    TaskModel(id: 't5', title: 'Drainage channel repair', dueDate: 'Jan 22, 2026', status: 'in_progress', tags: ['Construction']),
    TaskModel(id: 't6', title: 'Road markings — Section A', dueDate: 'Jan 25, 2026', status: 'in_progress', tags: ['Marking']),
    TaskModel(id: 't7', title: 'Traffic management signage', dueDate: 'Feb 14, 2026', status: 'todo', tags: ['Safety']),
    TaskModel(id: 't8', title: 'Final inspection & handover', dueDate: 'Feb 20, 2026', status: 'todo', isMilestone: true),
  ];

  static const messages = [
    MessageModel(sender: 'Admin', text: 'Good morning! We\'ve reviewed your bid for the road rehabilitation project and it\'s looking very strong.', time: 'Jan 12, 09:14', isMe: false),
    MessageModel(sender: 'You', text: 'Thank you! We\'re very confident in our methodology. Our team has completed 3 similar AACRA-grade projects in the last 2 years.', time: 'Jan 12, 09:22', isMe: true),
    MessageModel(sender: 'Admin', text: 'Could you submit the equipment list as a PDF? The evaluators need it for shortlisting.', time: 'Jan 12, 10:05', isMe: false),
    MessageModel(sender: 'You', text: 'Absolutely, I\'ll upload it within the hour. We have 2 Wirtgen W200s and a Volvo P7820C paver on standby.', time: 'Jan 12, 10:18', isMe: true),
    MessageModel(sender: 'Admin', text: 'Perfect. We\'ll notify you on the shortlisting decision by end of day Friday. 🎯', time: 'Jan 12, 11:00', isMe: false),
  ];

  static const payments = [
    PaymentModel(date: 'Jan 5, 2026', amount: '262,500', method: 'CBE Transfer', reference: 'CBE2026-00145'),
    PaymentModel(date: 'Jan 12, 2026', amount: '175,000', method: 'CBE Transfer', reference: 'CBE2026-00289'),
    PaymentModel(date: 'Jan 18, 2026', amount: '131,250', method: 'Awash Bank', reference: 'AWB-2026-0881'),
  ];

  static const workshops = [
    WorkshopModel(
      title: 'How to Write Winning Bid Proposals',
      description: 'Learn how top contractors structure their technical and financial proposals. Real examples from awarded bids. Q&A with AACRA procurement officers.',
      day: '24', month: 'JAN', time: '2:00 PM EAT',
      location: 'Online (Zoom)', registeredCount: 47, isRegistered: true,
    ),
    WorkshopModel(
      title: 'Ethiopian Tax & TIN Requirements for Contractors',
      description: 'Understanding tax obligations, VAT registration, and keeping compliant documents for government tenders. Hosted by ERCA officials.',
      day: '08', month: 'FEB', time: '9:00 AM EAT',
      location: 'Sheraton Addis', registeredCount: 23,
    ),
    WorkshopModel(
      title: 'Understanding Procurement Law in Ethiopia 2025',
      description: 'New PPPAA guidelines and what they mean for private contractors bidding on public tenders. Legal experts panel discussion.',
      day: '15', month: 'FEB', time: '10:00 AM EAT',
      location: 'Hybrid', registeredCount: 12,
    ),
  ];
}
