class DeviceModel {
  final String id;
  final String userId;
  final String name;
  final String type;        // 'smartwatch', 'fitbit', 'oura', 'garmin'
  final String? model;
  final bool isConnected;
  final DateTime connectedAt;
  final DateTime? lastSyncTime;
  final String? batteryLevel;

  DeviceModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    this.model,
    required this.isConnected,
    required this.connectedAt,
    this.lastSyncTime,
    this.batteryLevel,
  });

  DeviceModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? type,
    String? model,
    bool? isConnected,
    DateTime? connectedAt,
    DateTime? lastSyncTime,
    String? batteryLevel,
  }) {
    return DeviceModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      model: model ?? this.model,
      isConnected: isConnected ?? this.isConnected,
      connectedAt: connectedAt ?? this.connectedAt,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      batteryLevel: batteryLevel ?? this.batteryLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'type': type,
      'model': model,
      'isConnected': isConnected,
      'connectedAt': connectedAt.toIso8601String(),
      'lastSyncTime': lastSyncTime?.toIso8601String(),
      'batteryLevel': batteryLevel,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? 'smartwatch',
      model: map['model'],
      isConnected: map['isConnected'] ?? false,
      connectedAt: DateTime.parse(
        map['connectedAt'] ?? DateTime.now().toIso8601String(),
      ),
      lastSyncTime: map['lastSyncTime'] != null
          ? DateTime.parse(map['lastSyncTime'])
          : null,
      batteryLevel: map['batteryLevel'],
    );
  }

  @override
  String toString() {
    return 'DeviceModel(id: $id, name: $name, type: $type, isConnected: $isConnected)';
  }
}
