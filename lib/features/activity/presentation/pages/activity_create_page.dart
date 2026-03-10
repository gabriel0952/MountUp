import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../../../core/database/app_database.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/datetime_ext.dart';
import '../providers/activity_provider.dart';

class ActivityCreatePage extends ConsumerStatefulWidget {
  const ActivityCreatePage({super.key});

  @override
  ConsumerState<ActivityCreatePage> createState() =>
      _ActivityCreatePageState();
}

class _ActivityCreatePageState extends ConsumerState<ActivityCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _distanceController = TextEditingController();
  final _elevationController = TextEditingController();
  final _durationHController = TextEditingController();
  final _durationMController = TextEditingController();

  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _distanceController.dispose();
    _elevationController.dispose();
    _durationHController.dispose();
    _durationMController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final distanceKm = double.tryParse(_distanceController.text.trim());
    final elevationM = int.tryParse(_elevationController.text.trim());
    final durationH = int.tryParse(_durationHController.text.trim()) ?? 0;
    final durationM = int.tryParse(_durationMController.text.trim()) ?? 0;
    final durationS =
        (durationH > 0 || durationM > 0) ? durationH * 3600 + durationM * 60 : null;

    await ref.read(activityRepositoryProvider).save(
          ActivitiesCompanion.insert(
            title: _titleController.text.trim(),
            date: _date,
            distanceKm: Value(distanceKm),
            elevationM: Value(elevationM),
            durationS: Value(durationS),
          ),
        );

    ref.invalidate(activityListProvider);

    if (mounted) context.go('/activities');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('手動新增活動', style: theme.textTheme.titleLarge),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: AppSpacing.pagePadding
              .copyWith(top: AppSpacing.s20, bottom: AppSpacing.s32),
          children: [
            // ── 活動名稱 ──────────────────────────────────────
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '活動名稱 *',
                border: OutlineInputBorder(borderRadius: AppRadius.mdBorder),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16, vertical: AppSpacing.s12),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? '請輸入活動名稱' : null,
            ),
            const SizedBox(height: AppSpacing.s16),

            // ── 日期 ──────────────────────────────────────────
            InkWell(
              onTap: _pickDate,
              borderRadius: AppRadius.mdBorder,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: '日期',
                  border:
                      OutlineInputBorder(borderRadius: AppRadius.mdBorder),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s16, vertical: AppSpacing.s12),
                  suffixIcon: const Icon(Icons.calendar_today_rounded),
                ),
                child: Text(_date.toDisplayDate()),
              ),
            ),
            const SizedBox(height: AppSpacing.s24),

            Text('選填資訊', style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: AppSpacing.s12),

            // ── 距離 & 爬升 ──────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _distanceController,
                    decoration: InputDecoration(
                      labelText: '距離 (km)',
                      border: OutlineInputBorder(
                          borderRadius: AppRadius.mdBorder),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16,
                          vertical: AppSpacing.s12),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'))
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: TextFormField(
                    controller: _elevationController,
                    decoration: InputDecoration(
                      labelText: '爬升 (m)',
                      border: OutlineInputBorder(
                          borderRadius: AppRadius.mdBorder),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16,
                          vertical: AppSpacing.s12),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s16),

            // ── 時間 ──────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _durationHController,
                    decoration: InputDecoration(
                      labelText: '小時',
                      border: OutlineInputBorder(
                          borderRadius: AppRadius.mdBorder),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16,
                          vertical: AppSpacing.s12),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: TextFormField(
                    controller: _durationMController,
                    decoration: InputDecoration(
                      labelText: '分鐘',
                      border: OutlineInputBorder(
                          borderRadius: AppRadius.mdBorder),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16,
                          vertical: AppSpacing.s12),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s32),

            // ── 儲存按鈕 ──────────────────────────────────────
            FilledButton(
              onPressed: _saving ? null : _save,
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.mdBorder),
              ),
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('儲存活動'),
            ),
          ],
        ),
      ),
    );
  }
}
