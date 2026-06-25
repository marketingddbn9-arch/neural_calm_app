import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final List<DeviceItem> _devices = [
    DeviceItem(
      id: '1',
      name: 'iPhone 13 Pro',
      type: 'Mobile',
      model: 'iOS 16.2',
      isConnected: true,
      lastSync: DateTime.now().subtract(const Duration(minutes: 5)),
      batteryLevel: 87,
    ),
    DeviceItem(
      id: '2',
      name: 'Apple Watch Series 7',
      type: 'Wearable',
      model: 'watchOS 9.1',
      isConnected: true,
      lastSync: DateTime.now().subtract(const Duration(minutes: 2)),
      batteryLevel: 65,
    ),
    DeviceItem(
      id: '3',
      name: 'iPad Air',
      type: 'Tablet',
      model: 'iPadOS 16',
      isConnected: false,
      lastSync: DateTime.now().subtract(const Duration(days: 2)),
      batteryLevel: 45,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Connected Devices',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Card
            Container(
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.info.withOpacity(0.3)),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.info,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You have ${_devices.length} devices connected to your account.',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Active Devices Section
            _buildSectionTitle('Active Devices'),
            const SizedBox(height: 12),
            Column(
              children: _devices
                  .where((d) => d.isConnected)
                  .map((device) => _buildDeviceCard(device))
                  .toList(),
            ),
            const SizedBox(height: 24),

            // Inactive Devices Section
            if (_devices.any((d) => !d.isConnected)) ...[
              _buildSectionTitle('Inactive Devices'),
              const SizedBox(height: 12),
              Column(
                children: _devices
                    .where((d) => !d.isConnected)
                    .map((device) => _buildDeviceCard(device))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildDeviceCard(DeviceItem device) {
    final icon = _getDeviceIcon(device.type);
    final statusColor = device.isConnected ? AppColors.success : AppColors.textSecondary;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: statusColor,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          device.isConnected ? 'Connected' : 'Disconnected',
                          style: TextStyle(
                            fontSize: 11,
                            color: statusColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Remove Device'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Remove Device?'),
                          content: Text(
                            'Are you sure you want to remove ${device.name}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  _devices.removeWhere((d) => d.id == device.id);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${device.name} removed',
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Remove',
                                style: TextStyle(color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: AppColors.border),
          const SizedBox(height: 12),

          // Details
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  label: 'Model',
                  value: device.model,
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  label: 'Battery',
                  value: '${device.batteryLevel}%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailItem(
            label: 'Last Synced',
            value: _formatTime(device.lastSync),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  IconData _getDeviceIcon(String type) {
    switch (type.toLowerCase()) {
      case 'mobile':
        return Icons.smartphone_outlined;
      case 'wearable':
        return Icons.watch_outlined;
      case 'tablet':
        return Icons.tablet_outlined;
      default:
        return Icons.devices_outlined;
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

class DeviceItem {
  final String id;
  final String name;
  final String type;
  final String model;
  final bool isConnected;
  final DateTime lastSync;
  final int batteryLevel;

  DeviceItem({
    required this.id,
    required this.name,
    required this.type,
    required this.model,
    required this.isConnected,
    required this.lastSync,
    required this.batteryLevel,
  });
}
