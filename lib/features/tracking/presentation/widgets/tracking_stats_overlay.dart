import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/duration_ext.dart';
import '../../domain/entities/tracking_session_state.dart';

class TrackingStatsOverlay extends StatelessWidget {
  const TrackingStatsOverlay({super.key, required this.state});

  final TrackingSessionState state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s16,
          AppSpacing.s8,
          AppSpacing.s16,
          0,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s16,
            vertical: AppSpacing.s12,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                label: '時間',
                value: Duration(seconds: state.elapsedSeconds).toHHMMSS(),
              ),
              _Divider(),
              _StatItem(
                label: '距離',
                value: '${state.distanceKm.toStringAsFixed(2)} km',
              ),
              _Divider(),
              _StatItem(
                label: '爬升',
                value: '${state.elevationGainM.toStringAsFixed(0)} m',
              ),
              _Divider(),
              _StatItem(
                label: '速度',
                value: '${(state.currentSpeedMs * 3.6).toStringAsFixed(1)} km/h',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.65),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: Colors.white.withValues(alpha: 0.2),
    );
  }
}
