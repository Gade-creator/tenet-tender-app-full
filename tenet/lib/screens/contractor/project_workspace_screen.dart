import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../data/mock_data.dart';

class ProjectWorkspaceScreen extends StatelessWidget {
  const ProjectWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todo = MockData.tasks.where((t) => t.status == 'todo').toList();
    final inProgress = MockData.tasks.where((t) => t.status == 'in_progress').toList();
    final done = MockData.tasks.where((t) => t.status == 'done').toList();

    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: const Text('Project Workspace'),
        subtitle: const Text('Road Rehabilitation — Bole Sub-City', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_outlined, color: AppColors.textMuted),
            onPressed: () => context.go('/contractor/chat'),
          ),
          IconButton(
            icon: const Icon(Icons.payments_outlined, color: AppColors.textMuted),
            onPressed: () => context.go('/contractor/payments'),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── STATS ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.dark2,
            child: Row(
              children: [
                _Stat('8', 'Total', AppColors.textMuted),
                _divider(),
                _Stat('3', 'In Progress', AppColors.blue),
                _divider(),
                _Stat('3', 'Done', AppColors.green),
                _divider(),
                _Stat('1', 'Overdue', AppColors.red),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderDim),

          // ── KANBAN ──
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _KanbanColumn(title: 'TO DO', color: AppColors.textMuted, icon: '📋', tasks: todo),
                  const SizedBox(width: 12),
                  _KanbanColumn(title: 'IN PROGRESS', color: AppColors.blue, icon: '🔄', tasks: inProgress),
                  const SizedBox(width: 12),
                  _KanbanColumn(title: 'DONE', color: AppColors.green, icon: '✅', tasks: done),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Container(width: 1, height: 28, color: AppColors.borderDim, margin: const EdgeInsets.symmetric(horizontal: 12));

  Widget _Stat(String num, String label, Color color) => Expanded(
    child: Column(
      children: [
        Text(num, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: color)),
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
      ],
    ),
  );
}

class _KanbanColumn extends StatelessWidget {
  final String title, icon;
  final Color color;
  final List<TaskModel> tasks;
  const _KanbanColumn({required this.title, required this.color, required this.icon, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.dark3,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              border: Border.all(color: AppColors.borderDim),
            ),
            child: Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 7),
                Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color, letterSpacing: 0.5)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.dark5, borderRadius: BorderRadius.circular(8)),
                  child: Text('${tasks.length}', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ),
              ],
            ),
          ),
          // Cards
          Container(
            decoration: const BoxDecoration(
              color: AppColors.dark2,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              border: Border(left: BorderSide(color: AppColors.borderDim), right: BorderSide(color: AppColors.borderDim), bottom: BorderSide(color: AppColors.borderDim)),
            ),
            child: Column(
              children: tasks.map((task) => _TaskCard(task: task)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final TaskModel task;
  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.dark4,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: task.isOverdue ? AppColors.red : task.isMilestone ? AppColors.gold : Colors.transparent,
            width: 3,
          ),
          top: const BorderSide(color: AppColors.borderDim),
          right: const BorderSide(color: AppColors.borderDim),
          bottom: const BorderSide(color: AppColors.borderDim),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.title, style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500,
              color: task.status == 'done' ? AppColors.textMuted : AppColors.textPrimary,
              decoration: task.status == 'done' ? TextDecoration.lineThrough : null,
          )),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 11,
                  color: task.isOverdue ? AppColors.red : AppColors.textDim),
              const SizedBox(width: 4),
              Text(task.dueDate,
                  style: TextStyle(fontSize: 11,
                      color: task.isOverdue ? AppColors.red : task.status == 'done' ? AppColors.green : AppColors.textDim)),
            ],
          ),
          if (task.tags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 5, runSpacing: 4,
              children: task.tags.map((t) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(color: AppColors.dark5, borderRadius: BorderRadius.circular(4)),
                child: Text(t, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              )).toList(),
            ),
          ],
          if (task.isMilestone) ...[
            const SizedBox(height: 6),
            const Row(children: [
              Icon(Icons.star, size: 11, color: AppColors.gold),
              SizedBox(width: 3),
              Text('Milestone', style: TextStyle(fontSize: 10, color: AppColors.gold, fontWeight: FontWeight.w600)),
            ]),
          ],
        ],
      ),
    );
  }
}
