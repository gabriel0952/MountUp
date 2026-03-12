import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../activity/presentation/providers/activity_provider.dart';
import '../../domain/share_card_composer.dart';
import '../../domain/share_card_format.dart';

class ShareCardPage extends ConsumerStatefulWidget {
  const ShareCardPage({super.key, required this.activityId});

  final String activityId;

  @override
  ConsumerState<ShareCardPage> createState() => _ShareCardPageState();
}

class _ShareCardPageState extends ConsumerState<ShareCardPage> {
  ShareCardFormat _format = ShareCardFormat.square;
  ui.Image? _preview;
  bool _composing = false;
  bool _exporting = false;

  Activity? _activity;

  @override
  void initState() {
    super.initState();
    // 待 provider 資料可用後觸發合成
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryCompose());
  }

  Future<void> _tryCompose() async {
    final activities = ref.read(activityListProvider).value;
    if (activities == null) return;
    final activity =
        activities.where((a) => a.id == widget.activityId).firstOrNull;
    if (activity == null) return;
    _activity = activity;
    await _compose();
  }

  Future<void> _compose() async {
    if (_activity == null || _composing) return;
    setState(() => _composing = true);
    try {
      final img = await ShareCardComposer.compose(_activity!, _format);
      if (mounted) setState(() => _preview = img);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('合成失敗：$e')),
        );
      }
    } finally {
      if (mounted) setState(() => _composing = false);
    }
  }

  Future<Uint8List?> _getPngBytes() async {
    if (_preview == null) return null;
    final byteData =
        await _preview!.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<void> _saveToGallery() async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final bytes = await _getPngBytes();
      if (bytes == null) return;
      await Gal.putImageBytes(bytes, name: 'mountup_share.png');
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('已存至相簿')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('儲存失敗：$e')));
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _share() async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final bytes = await _getPngBytes();
      if (bytes == null) return;
      final tmp =
          File('${Directory.systemTemp.path}/mountup_share_${DateTime.now().millisecondsSinceEpoch}.png');
      await tmp.writeAsBytes(bytes);
      await Share.shareXFiles(
        [XFile(tmp.path, mimeType: 'image/png')],
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('分享失敗：$e')));
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 當 activityListProvider 完成時觸發合成
    ref.listen(activityListProvider, (_, next) {
      if (_activity == null && next.hasValue) _tryCompose();
    });

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('分享卡片'),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          // ── 格式切換 ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s16,
              vertical: AppSpacing.s12,
            ),
            child: SegmentedButton<ShareCardFormat>(
              segments: const [
                ButtonSegment(
                    value: ShareCardFormat.square,
                    label: Text('1:1 正方形'),
                    icon: Icon(Icons.crop_square_rounded)),
                ButtonSegment(
                    value: ShareCardFormat.story,
                    label: Text('9:16 限動'),
                    icon: Icon(Icons.crop_portrait_rounded)),
              ],
              selected: {_format},
              onSelectionChanged: (sel) {
                setState(() => _format = sel.first);
                _compose();
              },
            ),
          ),

          // ── 預覽區 ──────────────────────────────────────────
          Expanded(
            child: Center(
              child: _composing || _preview == null
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16),
                      child: AspectRatio(
                        aspectRatio: _format.canvasWidth /
                            _format.canvasHeight.toDouble(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: RawImage(image: _preview, fit: BoxFit.contain),
                        ),
                      ),
                    ),
            ),
          ),

          // ── 操作按鈕 ────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed:
                          (_composing || _exporting) ? null : _saveToGallery,
                      icon: _exporting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.download_rounded),
                      label: const Text('存至相簿'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: (_composing || _exporting) ? null : _share,
                      icon: _exporting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Icon(Icons.ios_share_rounded),
                      label: const Text('分享'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
