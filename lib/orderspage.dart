import 'package:flutter/cupertino.dart';

class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final bool isDark;

  const OrdersPage({super.key, required this.orders, required this.isDark});

  Color get _bg => isDark ? Color(0xFF0D0D0D) : Color(0xFFF5F0E8);
  Color get _card => isDark ? Color(0xFF1A1410) : Color(0xFFFFFFFF);
  Color get _text => isDark ? Color(0xFFE8D5B7) : Color(0xFF2C1810);
  Color get _subtext => isDark ? Color(0xFF8B7355) : Color(0xFF9B7B5A);
  Color get _border => isDark ? Color(0xFF3A2820) : Color(0xFFE8D5B7);

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '${months[date.month - 1]} ${date.day}, ${date.year} · ${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
  }

  String _formatDateShort(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // Derive a meaningful status based on order date
  String _deriveStatus(Map<String, dynamic> order) {
    final raw = order['status'] as String? ?? '';
    if (raw == 'Delivered') return 'Delivered';
    if (raw == 'Shipped') return 'Shipped';
    // Replace "Processing" with "Confirmed"
    return 'Confirmed';
  }

  String _getStatusEmoji(String status) {
    switch (status) {
      case 'Confirmed': return '✅';
      case 'Shipped':   return '🚚';
      case 'Delivered': return '📬';
      default:          return '📦';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed': return Color(0xFF34C759);
      case 'Shipped':   return Color(0xFF007AFF);
      case 'Delivered': return Color(0xFF8B4513);
      default:          return Color(0xFF8B7355);
    }
  }

  String _getStatusDescription(String status) {
    switch (status) {
      case 'Confirmed': return 'Order received & being packed';
      case 'Shipped':   return 'On its way to you';
      case 'Delivered': return 'Delivered successfully';
      default:          return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: _bg,
      child: SafeArea(
        child: orders.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('📦', style: TextStyle(fontSize: 72)),
              SizedBox(height: 20),
              Text('No orders yet', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: _text)),
              SizedBox(height: 8),
              Text('Your order history will appear here', style: TextStyle(fontSize: 13, color: _subtext)),
            ],
          ),
        )
            : CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MY ORDERS',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 3, color: _text),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${orders.length} ${orders.length == 1 ? 'order' : 'orders'} placed',
                      style: TextStyle(fontSize: 13, color: _subtext),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 14),
                  child: _buildOrderCard(context, orders[index]),
                ),
                childCount: orders.length,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Map<String, dynamic> order) {
    final status = _deriveStatus(order);

    return GestureDetector(
      onTap: () => _showOrderDetails(context, order),
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF8B4513).withOpacity(isDark ? 0.1 : 0.06),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['orderId'],
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _text),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3),
                      Text(_formatDate(order['date']), style: TextStyle(fontSize: 11, color: _subtext)),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _getStatusColor(status).withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_getStatusEmoji(status), style: TextStyle(fontSize: 12)),
                      SizedBox(width: 4),
                      Text(
                        status,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _getStatusColor(status)),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 14),
            Container(height: 1, color: _border),
            SizedBox(height: 14),

            Text('${order['items'].length} ${order['items'].length == 1 ? 'book' : 'books'}',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _subtext)),
            SizedBox(height: 10),

            ...order['items'].take(2).map<Widget>((item) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [BoxShadow(color: Color(0xFF000000).withOpacity(0.15), blurRadius: 4, offset: Offset(1, 1))],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        item['image'],
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          color: Color(0xFF8B4513).withOpacity(0.2),
                          child: Center(child: Text('📖', style: TextStyle(fontSize: 16))),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _text), maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text('${item['selectedFormat'] ?? item['selectedColor']} · Qty ${item['quantity']}',
                            style: TextStyle(fontSize: 11, color: _subtext)),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),

            if (order['items'].length > 2)
              Padding(
                padding: EdgeInsets.only(top: 4, bottom: 8),
                child: Text('+${order['items'].length - 2} more books', style: TextStyle(fontSize: 12, color: _subtext)),
              ),

            SizedBox(height: 4),
            Container(height: 1, color: _border),
            SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ORDER TOTAL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1, color: _subtext)),
                    SizedBox(height: 3),
                    Text('₱${order['total']}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: _text)),
                  ],
                ),
                Row(
                  children: [
                    Text('Details', style: TextStyle(fontSize: 13, color: Color(0xFF8B4513), fontWeight: FontWeight.w600)),
                    SizedBox(width: 4),
                    Icon(CupertinoIcons.chevron_forward, color: Color(0xFF8B4513), size: 14),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Map<String, dynamic> order) {
    final status = _deriveStatus(order);

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.90,
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 20),
                width: 36,
                height: 4,
                decoration: BoxDecoration(color: _border, borderRadius: BorderRadius.circular(2)),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order Details', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: _text)),
                              SizedBox(height: 4),
                              Text(order['orderId'], style: TextStyle(fontSize: 13, color: _subtext)),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: _getStatusColor(status).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: _getStatusColor(status).withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(_getStatusEmoji(status), style: TextStyle(fontSize: 12)),
                              SizedBox(width: 4),
                              Text(status, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _getStatusColor(status))),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Status timeline
                    _buildStatusTimeline(status),

                    SizedBox(height: 20),

                    // Tracking & delivery
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xFF0D0D0D) : Color(0xFFF5F0E8),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('DELIVERY INFO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5, color: _subtext)),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF007AFF).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(CupertinoIcons.cube_box_fill, color: Color(0xFF007AFF), size: 16),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tracking Number', style: TextStyle(fontSize: 11, color: _subtext)),
                                    Text(order['trackingNumber'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _text)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Container(height: 1, color: _border),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF34C759).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(CupertinoIcons.location_fill, color: Color(0xFF34C759), size: 16),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Delivery Address', style: TextStyle(fontSize: 11, color: _subtext)),
                                    Text(order['shippingAddress'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _text)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Container(height: 1, color: _border),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF9500).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(CupertinoIcons.calendar, color: Color(0xFFFF9500), size: 16),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Estimated Delivery', style: TextStyle(fontSize: 11, color: _subtext)),
                                    Text(_formatDateShort(order['estimatedDelivery']),
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _text)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Text('BOOKS ORDERED (${order['items'].length})',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5, color: _subtext)),
                    SizedBox(height: 10),

                    ...order['items'].map<Widget>((item) => Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xFF0D0D0D) : Color(0xFFF5F0E8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 68,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [BoxShadow(color: Color(0xFF000000).withOpacity(0.2), blurRadius: 6, offset: Offset(2, 2))],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item['image'],
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(
                                  color: Color(0xFF8B4513).withOpacity(0.2),
                                  child: Center(child: Text('📖', style: TextStyle(fontSize: 20))),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['name'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _text)),
                                SizedBox(height: 3),
                                Text(item['author'] ?? '', style: TextStyle(fontSize: 11, color: _subtext)),
                                SizedBox(height: 3),
                                Text('${item['selectedFormat'] ?? item['selectedColor']}',
                                    style: TextStyle(fontSize: 11, color: Color(0xFF8B4513), fontWeight: FontWeight.w600)),
                                SizedBox(height: 5),
                                Text('₱${item['price']} × ${item['quantity']}',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _text)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )).toList(),

                    SizedBox(height: 16),

                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xFF0D0D0D) : Color(0xFFF5F0E8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ORDER TOTAL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1, color: _subtext)),
                          Text('₱${order['total']}', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: _text)),
                        ],
                      ),
                    ),

                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(String currentStatus) {
    final steps = ['Confirmed', 'Shipped', 'Delivered'];
    final currentIndex = steps.indexOf(currentStatus);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF0D0D0D) : Color(0xFFF5F0E8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            // Connector line
            final stepIndex = i ~/ 2;
            final isDone = stepIndex < currentIndex;
            return Expanded(
              child: Container(
                height: 2,
                color: isDone ? Color(0xFF8B4513) : _border,
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final isDone = stepIndex <= currentIndex;
          final isCurrent = stepIndex == currentIndex;
          final step = steps[stepIndex];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isDone ? Color(0xFF8B4513) : _border,
                  shape: BoxShape.circle,
                  border: isCurrent ? Border.all(color: Color(0xFFD2691E), width: 2) : null,
                ),
                child: Center(
                  child: Icon(
                    stepIndex == 0 ? CupertinoIcons.checkmark : stepIndex == 1 ? CupertinoIcons.cube_box : CupertinoIcons.house,
                    size: 14,
                    color: isDone ? Color(0xFFFFFFFF) : (isDark ? Color(0xFF3A2820) : Color(0xFFD4C4B0)),
                  ),
                ),
              ),
              SizedBox(height: 6),
              Text(
                step,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w500,
                  color: isCurrent ? Color(0xFF8B4513) : _subtext,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}