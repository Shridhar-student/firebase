import 'package:flutter/material.dart';

class Delivery {
  final String id;
  final String customer;
  final String address;
  final String date;
  final String time;
  final String distance;
  final DeliveryStatus status;
  final String priority;

  Delivery({
    required this.id,
    required this.customer,
    required this.address,
    required this.date,
    required this.time,
    required this.distance,
    required this.status,
    required this.priority,
  });
}

enum DeliveryStatus { pending, assigned, delivered, cancelled }

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardScreen> {
  bool isModernView = true;

  final List<Delivery> deliveries = [
    Delivery(
      id: '30921434',
      customer: 'John Doe',
      address:
          '231, 2nd floor, Srinivasa Towers, Whitefield Road, Hyderabad-500084',
      date: '20-Jun-25',
      time: '01:50 PM',
      distance: '7 KM',
      status: DeliveryStatus.pending,
      priority: 'High',
    ),
    Delivery(
      id: '41239034',
      customer: 'Jack Smith',
      address:
          '231, 2nd floor, Srinivasa Towers, Whitefield Road, Hyderabad-500084',
      date: '20-Jun-25',
      time: '04:50 PM',
      distance: '9 KM',
      status: DeliveryStatus.assigned,
      priority: 'Medium',
    ),
    Delivery(
      id: '1245632',
      customer: 'Jack Smith',
      address:
          '231, 2nd floor, Srinivasa Towers, Whitefield Road, Hyderabad-500084',
      date: '19-Jun-25',
      time: '11:50 AM',
      distance: '2.5 KM',
      status: DeliveryStatus.delivered,
      priority: 'Low',
    ),
    Delivery(
      id: '2123456',
      customer: 'Sarah Johnson',
      address:
          '231, 2nd floor, Srinivasa Towers, Whitefield Road, Hyderabad-500084',
      date: '19-Jun-25',
      time: '09:30 AM',
      distance: '5.2 KM',
      status: DeliveryStatus.cancelled,
      priority: 'Normal',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8FAFC),
              Color(0xFFEBF4FF),
              Color(0xFFE0E7FF),
            ],
          ),
        ),
        child: Column(
          children: [
            // Your other widgets here

            // List of deliveries inside an Expanded widget
            Expanded(
              child: _buildDeliveryList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String number, String label, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryList() {
    return ListView.builder(
      shrinkWrap: true, // Allows ListView to take only as much space as needed
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: deliveries.length,
      itemBuilder: (context, index) {
        return ModernDeliveryCard(delivery: deliveries[index]);
      },
    );
  }
}

class ModernDeliveryCard extends StatelessWidget {
  final Delivery delivery;

  const ModernDeliveryCard({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(delivery.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildGradientHeader(config),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildGradientHeader(StatusConfig config) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: config.gradientColors,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      config.icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#${delivery.id}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          config.statusText,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.white.withOpacity(0.8),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    delivery.time,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    ' • ${delivery.date}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      delivery.distance,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Customer Info
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4F9CFE).withOpacity(0.7),
                      const Color(0xFF38A3FF).withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  delivery.customer,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Address info
          Row(
            children: [
              Expanded(
                child: Text(
                  delivery.address,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  StatusConfig _getStatusConfig(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.pending:
        return StatusConfig(
          statusText: 'Pending',
          icon: Icons.access_time,
          gradientColors: [Colors.orange, Colors.yellow],
        );
      case DeliveryStatus.assigned:
        return StatusConfig(
          statusText: 'Assigned',
          icon: Icons.assignment_turned_in,
          gradientColors: [Colors.blue, Colors.blueAccent],
        );
      case DeliveryStatus.delivered:
        return StatusConfig(
          statusText: 'Delivered',
          icon: Icons.check_circle,
          gradientColors: [Colors.green, Colors.greenAccent],
        );
      case DeliveryStatus.cancelled:
        return StatusConfig(
          statusText: 'Cancelled',
          icon: Icons.cancel,
          gradientColors: [Colors.red, Colors.redAccent],
        );
    }
  }
}

class StatusConfig {
  final String statusText;
  final IconData icon;
  final List<Color> gradientColors;

  StatusConfig({
    required this.statusText,
    required this.icon,
    required this.gradientColors,
  });
}
