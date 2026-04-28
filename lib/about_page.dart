import 'package:flutter/cupertino.dart';

class AboutPage extends StatelessWidget {
  final bool isDark;

  const AboutPage({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: isDark ? Color(0xFF0D0D0D) : Color(0xFFF5F0E8),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDark
            ? Color(0xFF1A1A1A).withOpacity(0.95)
            : Color(0xFFF5F0E8).withOpacity(0.95),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? Color(0xFFE8D5B7) : Color(0xFF2C1810),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          'ABOUT',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            fontSize: 14,
            color: isDark ? Color(0xFFE8D5B7) : Color(0xFF2C1810),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            SizedBox(height: 20),

            // Book icon
            Center(
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [Color(0xFF8B4513), Color(0xFFD2691E)]
                        : [Color(0xFF2C1810), Color(0xFF8B4513)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF8B4513).withOpacity(0.4),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Text('📚', style: TextStyle(fontSize: 42)),
                ),
              ),
            ),

            SizedBox(height: 24),

            Center(
              child: Text(
                'Ivory & Ink',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 6,
                  color: isDark ? Color(0xFFE8D5B7) : Color(0xFF2C1810),
                ),
              ),
            ),

            SizedBox(height: 6),

            Center(
              child: Text(
                'Premium Bookstore & Literary Collection',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Color(0xFF8B7355) : Color(0xFF6B4C2A),
                  letterSpacing: 1,
                ),
              ),
            ),

            SizedBox(height: 6),

            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF8B4513).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8B4513),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            _buildSection(
              'OUR STORY',
              'IVORY & INK was born from a simple belief: every great story deserves to find its reader. We curate the finest literary works — from timeless classics to contemporary bestsellers — bringing them directly to your hands.',
              null,
            ),

            SizedBox(height: 16),

            _buildSection(
              'OUR MISSION',
              'We are dedicated to fostering a love of reading by providing access to authentic, high-quality books with an exceptional shopping experience and seamless delivery across the Philippines.',
              null,
            ),

            SizedBox(height: 16),

            // Features
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('WHAT WE OFFER'),
                  SizedBox(height: 16),
                  _buildFeature('📖', 'Curated Selection of 10,000+ Titles'),
                  _buildFeature('🔍', 'Smart Book Discovery & Recommendations'),
                  _buildFeature('🚚', 'Fast & Secure Nationwide Delivery'),
                  _buildFeature('📦', 'Real-time Order Tracking'),
                  _buildFeature('💳', 'Secure Checkout via Multiple Channels'),
                  _buildFeature('🆓', 'Free Shipping on Orders Over ₱599'),
                  _buildFeature('↩️', '30-Day Return Policy'),
                  _buildFeature('🎧', '24/7 Reader Support'),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Contact
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('GET IN TOUCH'),
                  SizedBox(height: 16),
                  _buildContactInfo(CupertinoIcons.mail_solid, 'Email', 'hello@booksanctuary.ph', Color(0xFF007AFF)),
                  SizedBox(height: 12),
                  _buildContactInfo(CupertinoIcons.phone_fill, 'Phone', '+63 917 123 4567', Color(0xFF34C759)),
                  SizedBox(height: 12),
                  _buildContactInfo(CupertinoIcons.location_fill, 'Location', 'BGC, Taguig City, Metro Manila, PH', Color(0xFFFF9500)),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Social
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('FOLLOW US'),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialButton('📘', 'Facebook'),
                      _buildSocialButton('📷', 'Instagram'),
                      _buildSocialButton('🐦', 'Twitter'),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Center(
              child: Text(
                '© 2026 IVORY & INK. All rights reserved.',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Color(0xFF4A3728) : Color(0xFFB8967A),
                ),
              ),
            ),

            SizedBox(height: 6),

            Center(
              child: Text(
                'Made with ❤️ for readers in the Philippines',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Color(0xFF4A3728) : Color(0xFFB8967A),
                ),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String label, String text, Widget? extra) {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionLabel(label),
          SizedBox(height: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              height: 1.7,
              color: isDark ? Color(0xFFB8967A) : Color(0xFF4A3728),
            ),
          ),
          if (extra != null) ...[SizedBox(height: 12), extra],
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF1A1410) : Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Color(0xFF3A2820) : Color(0xFFE8D5B7),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.4)
                : Color(0xFF8B4513).withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 2,
        color: Color(0xFF8B4513),
      ),
    );
  }

  Widget _buildFeature(String emoji, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Color(0xFF8B4513).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(emoji, style: TextStyle(fontSize: 16)),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Color(0xFFD4B896) : Color(0xFF2C1810),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? Color(0xFF8B7355) : Color(0xFF9B7B5A),
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Color(0xFFE8D5B7) : Color(0xFF2C1810),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(String emoji, String platform) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: isDark ? Color(0xFF2A1F18) : Color(0xFFF5EDE0),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? Color(0xFF3A2820) : Color(0xFFE8D5B7),
            ),
          ),
          child: Center(child: Text(emoji, style: TextStyle(fontSize: 28))),
        ),
        SizedBox(height: 8),
        Text(
          platform,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Color(0xFF8B7355) : Color(0xFF9B7B5A),
          ),
        ),
      ],
    );
  }
}

// Needed for Colors reference
class Colors {
  static Color black = Color(0xFF000000);
}