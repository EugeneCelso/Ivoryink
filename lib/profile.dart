import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'about_page.dart';
import 'main.dart';

class ProfilePage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const ProfilePage({super.key, required this.isDark, required this.onToggleTheme});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final box = Hive.box("folio_db");
  final LocalAuthentication auth = LocalAuthentication();

  // Reading preferences state
  String _readingGoal = '12';
  bool _dailyReminder = false;
  bool _newArrivals = true;
  String _preferredFormat = 'Paperback';

  // ✅ Local state for biometrics — instant UI feedback
  late bool _biometricsEnabled;

  @override
  void initState() {
    super.initState();
    // ✅ Initialize from Hive once on load
    _biometricsEnabled = box.get("biometrics", defaultValue: false);
  }

  Color get _bg => widget.isDark ? Color(0xFF0D0D0D) : Color(0xFFF5F0E8);
  Color get _card => widget.isDark ? Color(0xFF1A1410) : Color(0xFFFFFFFF);
  Color get _text => widget.isDark ? Color(0xFFE8D5B7) : Color(0xFF2C1810);
  Color get _subtext => widget.isDark ? Color(0xFF8B7355) : Color(0xFF9B7B5A);
  Color get _border => widget.isDark ? Color(0xFF3A2820) : Color(0xFFE8D5B7);
  Color get _sectionBg => widget.isDark ? Color(0xFF0D0D0D) : Color(0xFFF5F0E8);

  String get username => box.get("username", defaultValue: "Guest");
  String get email => box.get("email", defaultValue: "guest@ivory&inkph");
  String get fullName => box.get("fullName", defaultValue: "Reader");

  // ✅ FIXED: async write + setState separately for instant switch response
  void _toggleBiometrics(bool value) async {
    setState(() => _biometricsEnabled = value); // instant UI update
    await box.put("biometrics", value);          // persist to Hive
    _showAlert(
      value ? 'Biometrics Enabled ✓' : 'Biometrics Disabled',
      value
          ? 'You can now use Face ID or fingerprint to sign in.'
          : 'Biometric sign-in has been disabled.',
    );
  }

  void _showAlert(String title, String content) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  void _logout() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out of IVORY & INK?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Sign Out'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  void _showReadingGoalPicker() {
    final goals = ['6', '12', '18', '24', '36', '52'];
    int selectedIndex = goals.indexOf(_readingGoal);
    if (selectedIndex < 0) selectedIndex = 1;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 320,
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(top: BorderSide(color: _border)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 8),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Annual Reading Goal',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _text,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Color(0xFF8B4513),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 44,
                  scrollController:
                  FixedExtentScrollController(initialItem: selectedIndex),
                  onSelectedItemChanged: (i) =>
                      setState(() => _readingGoal = goals[i]),
                  children: goals
                      .map((g) => Center(
                    child: Text(
                      '$g books per year',
                      style: TextStyle(fontSize: 17, color: _text),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFormatPicker() {
    final formats = ['Hardcover', 'Paperback', 'Audiobook'];

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 280,
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(top: BorderSide(color: _border)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 8),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Preferred Format',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _text,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Color(0xFF8B4513),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: formats.map((f) {
                    final isSelected = _preferredFormat == f;
                    String emoji = f == 'Hardcover'
                        ? '📕'
                        : f == 'Paperback'
                        ? '📗'
                        : '🎧';
                    return GestureDetector(
                      onTap: () => setState(() => _preferredFormat = f),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Color(0xFF8B4513).withOpacity(0.1)
                              : _sectionBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Color(0xFF8B4513)
                                : _border,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(emoji, style: TextStyle(fontSize: 22)),
                            SizedBox(width: 12),
                            Text(
                              f,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Color(0xFF8B4513)
                                    : _text,
                              ),
                            ),
                            Spacer(),
                            if (isSelected)
                              Icon(
                                CupertinoIcons.checkmark_circle_fill,
                                color: Color(0xFF8B4513),
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getAccountAge() {
    final created = box.get("accountCreated");
    if (created == null) return "New Member";
    final diff = DateTime.now().difference(DateTime.parse(created));
    if (diff.inDays > 365)
      return "Member for ${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? 'year' : 'years'}";
    if (diff.inDays > 30)
      return "Member for ${(diff.inDays / 30).floor()} months";
    if (diff.inDays > 0) return "Member for ${diff.inDays} days";
    return "Member since today";
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: _sectionBg,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(height: 10),

            // Profile card
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _border),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2C1810), Color(0xFF8B4513)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        fullName.isNotEmpty ? fullName[0].toUpperCase() : '?',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    fullName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _text,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text('@$username',
                      style: TextStyle(fontSize: 13, color: _subtext)),
                  SizedBox(height: 2),
                  Text(email,
                      style: TextStyle(fontSize: 13, color: _subtext)),
                  SizedBox(height: 12),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF8B4513).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getAccountAge(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8B4513),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Stats banner
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2C1810), Color(0xFF8B4513)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat('📚', 'Books\nOrdered', () {
                    final history = box.get("orderHistory");
                    if (history == null) return '0';
                    int total = 0;
                    for (final order in (history as List)) {
                      final items =
                          (order as Map)['items'] as List? ?? [];
                      for (final item in items) {
                        total +=
                            (item['quantity'] as num? ?? 1).toInt();
                      }
                    }
                    return '$total';
                  }()),
                  _buildStat('⭐', 'Wishlist', '0'),
                  Container(
                    width: 1,
                    height: 40,
                    color: Color(0xFFFFFFFF).withOpacity(0.2),
                  ),
                  _buildStat('🎯', 'Annual\nGoal', _readingGoal),
                ],
              ),
            ),

            SizedBox(height: 28),

            _buildSectionTitle('APPEARANCE'),
            SizedBox(height: 8),
            _buildGroup([
              _buildTile(
                CupertinoIcons.moon_fill,
                'Dark Mode',
                Color(0xFF5E5CE6),
                trailing: CupertinoSwitch(
                  value: widget.isDark,
                  onChanged: (_) => widget.onToggleTheme(),
                  activeColor: Color(0xFF8B4513),
                ),
              ),
            ]),

            SizedBox(height: 24),

            _buildSectionTitle('SECURITY'),
            SizedBox(height: 8),
            _buildGroup([
              _buildTile(
                CupertinoIcons.lock_shield_fill,
                'Biometric Login',
                Color(0xFF5856D6),
                trailing: CupertinoSwitch(
                  // ✅ FIXED: uses local state, not a Hive getter
                  value: _biometricsEnabled,
                  onChanged: _toggleBiometrics,
                  activeColor: Color(0xFF8B4513),
                ),
              ),
            ]),

            SizedBox(height: 24),

            _buildSectionTitle('READING PREFERENCES'),
            SizedBox(height: 8),
            _buildGroup([
              _buildTapTile(
                CupertinoIcons.scope,
                'Annual Reading Goal',
                Color(0xFF8B4513),
                _showReadingGoalPicker,
                trailingLabel: '$_readingGoal books',
              ),
              _buildDivider(),
              _buildTapTile(
                CupertinoIcons.book_fill,
                'Preferred Format',
                Color(0xFF2E7D32),
                _showFormatPicker,
                trailingLabel: _preferredFormat,
              ),
              _buildDivider(),
              _buildTile(
                CupertinoIcons.bell_fill,
                'Daily Reading Reminder',
                Color(0xFFFF9500),
                trailing: CupertinoSwitch(
                  value: _dailyReminder,
                  onChanged: (val) {
                    setState(() => _dailyReminder = val);
                    if (val)
                      _showAlert('Reminder Set 📚',
                          'We\'ll remind you to read every day at 8:00 PM.');
                  },
                  activeColor: Color(0xFF8B4513),
                ),
              ),
              _buildDivider(),
              _buildTile(
                CupertinoIcons.sparkles,
                'New Arrivals Alerts',
                Color(0xFF007AFF),
                trailing: CupertinoSwitch(
                  value: _newArrivals,
                  onChanged: (val) => setState(() => _newArrivals = val),
                  activeColor: Color(0xFF8B4513),
                ),
              ),
            ]),

            SizedBox(height: 24),

            _buildSectionTitle('STORE'),
            SizedBox(height: 8),
            _buildGroup([
              _buildTapTile(
                CupertinoIcons.info_circle_fill,
                'About BOOK IVORY & INK',
                Color(0xFF007AFF),
                    () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          AboutPage(isDark: widget.isDark),
                    ),
                  );
                },
              ),
              _buildDivider(),
              _buildTapTile(
                CupertinoIcons.location_fill,
                'Delivery Address',
                Color(0xFF34C759),
                    () {
                  _showAlert('Delivery Address',
                      'BGC, Taguig City, Metro Manila, PH\n+63 917 123 4567');
                },
              ),
              _buildDivider(),
              _buildTapTile(
                CupertinoIcons.creditcard_fill,
                'Payment Methods',
                Color(0xFF32ADE6),
                    () {
                  _showAlert('Payment Methods',
                      'Secure payments via Xendit\n\nAccepted: Credit Card, GCash, PayMaya, Bank Transfer');
                },
              ),
            ]),

            SizedBox(height: 24),

            _buildSectionTitle('SUPPORT'),
            SizedBox(height: 8),
            _buildGroup([
              _buildTapTile(
                CupertinoIcons.chat_bubble_fill,
                'Help & Support',
                Color(0xFF32ADE6),
                    () {
                  _showAlert('Help & Support',
                      'hello@ivory&ink.ph\n+63 917 123 4567\n\nMonday–Saturday, 9AM–6PM');
                },
              ),
              _buildDivider(),
              _buildTapTile(
                CupertinoIcons.star_fill,
                'Rate IVORY & INK',
                Color(0xFFFFAA00),
                    () {
                  _showAlert('Thank You!',
                      'Your feedback helps us serve readers better. Leave us a review on the App Store!');
                },
              ),
            ]),

            SizedBox(height: 24),

            _buildSectionTitle('ACCOUNT'),
            SizedBox(height: 8),
            _buildGroup([
              _buildTapTile(
                CupertinoIcons.square_arrow_right,
                'Sign Out',
                Color(0xFFFF3B30),
                _logout,
              ),
            ]),

            SizedBox(height: 28),

            Center(
              child: Column(
                children: [
                  Text(
                    '📚 IVORY & INK',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: _subtext,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'v1.0.0 · Made for Readers',
                    style: TextStyle(fontSize: 11, color: _border),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String emoji, String label, String value) {
    return Column(
      children: [
        Text(emoji, style: TextStyle(fontSize: 20)),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Color(0xFFFFFFFF).withOpacity(0.6),
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
        color: _subtext,
      ),
    );
  }

  Widget _buildGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDivider() =>
      Container(margin: EdgeInsets.only(left: 56), height: 1, color: _border);

  Widget _buildTile(IconData icon, String title, Color color,
      {required Widget trailing}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: Color(0xFFFFFFFF)),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text(title, style: TextStyle(fontSize: 15, color: _text)),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildTapTile(
      IconData icon,
      String title,
      Color color,
      VoidCallback onTap, {
        String? trailingLabel,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Color(0x00000000),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: Color(0xFFFFFFFF)),
            ),
            SizedBox(width: 14),
            Expanded(
              child:
              Text(title, style: TextStyle(fontSize: 15, color: _text)),
            ),
            if (trailingLabel != null) ...[
              Text(trailingLabel,
                  style: TextStyle(fontSize: 13, color: _subtext)),
              SizedBox(width: 4),
            ],
            Icon(CupertinoIcons.chevron_forward, color: _border, size: 16),
          ],
        ),
      ),
    );
  }
}