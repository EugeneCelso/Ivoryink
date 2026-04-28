import 'package:flutter/cupertino.dart';

class BookDetailPage extends StatefulWidget {
  final Map<String, dynamic> book;
  final Function(Map<String, dynamic>) onAddToCart;
  final bool isDark;

  const BookDetailPage({
    super.key,
    required this.book,
    required this.onAddToCart,
    required this.isDark,
  });

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  Color get _bg => widget.isDark ? Color(0xFF0D0D0D) : Color(0xFFF5F0E8);
  Color get _card => widget.isDark ? Color(0xFF1A1410) : Color(0xFFFFFFFF);
  Color get _text => widget.isDark ? Color(0xFFE8D5B7) : Color(0xFF2C1810);
  Color get _subtext => widget.isDark ? Color(0xFF8B7355) : Color(0xFF9B7B5A);
  Color get _border => widget.isDark ? Color(0xFF3A2820) : Color(0xFFE8D5B7);

  void _showFormatSelector() {
    String? selectedFormat;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext modalContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
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
                      decoration: BoxDecoration(
                        color: _border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Book info
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF000000).withOpacity(0.25),
                                        blurRadius: 10,
                                        offset: Offset(2, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      widget.book['image'],
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) => Container(
                                        color: Color(0xFF8B4513).withOpacity(0.2),
                                        child: Center(child: Text('📖', style: TextStyle(fontSize: 32))),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.book['name'],
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          color: _text,
                                        ),
                                        maxLines: 2,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        widget.book['author'],
                                        style: TextStyle(fontSize: 13, color: _subtext),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '₱${widget.book['price']}',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF8B4513),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 28),

                            Text(
                              'SELECT FORMAT',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2,
                                color: _subtext,
                              ),
                            ),
                            SizedBox(height: 14),

                            ...widget.book['formats'].map<Widget>((format) {
                              final isSelected = selectedFormat == format;
                              String emoji = '📕';
                              String desc = '';
                              if (format == 'Paperback') { emoji = '📗'; desc = 'Lightweight & affordable'; }
                              if (format == 'E-Book') { emoji = '📱'; desc = 'Instant digital download'; }
                              if (format == 'Audiobook') { emoji = '🎧'; desc = 'Listen anywhere'; }
                              if (format == 'Hardcover') { emoji = '📕'; desc = 'Premium quality binding'; }

                              return GestureDetector(
                                onTap: () => setModalState(() => selectedFormat = format),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Color(0xFF8B4513).withOpacity(0.1)
                                        : widget.isDark ? Color(0xFF0D0D0D) : Color(0xFFF5F0E8),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: isSelected ? Color(0xFF8B4513) : _border,
                                      width: isSelected ? 1.5 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(emoji, style: TextStyle(fontSize: 24)),
                                      SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              format,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: isSelected ? Color(0xFF8B4513) : _text,
                                              ),
                                            ),
                                            if (desc.isNotEmpty)
                                              Text(
                                                desc,
                                                style: TextStyle(fontSize: 12, color: _subtext),
                                              ),
                                          ],
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(CupertinoIcons.checkmark_circle_fill, color: Color(0xFF8B4513), size: 20),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),

                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _card,
                        border: Border(top: BorderSide(color: _border)),
                      ),
                      child: SafeArea(
                        top: false,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (selectedFormat == null) {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: Text('Select Format'),
                                  content: Text('Please choose a format to continue.'),
                                  actions: [
                                    CupertinoDialogAction(child: Text('OK'), onPressed: () => Navigator.pop(context)),
                                  ],
                                ),
                              );
                              return;
                            }

                            widget.onAddToCart({
                              ...widget.book,
                              'selectedFormat': selectedFormat,
                              'selectedColor': selectedFormat,
                            });

                            Navigator.pop(modalContext);
                            Navigator.pop(this.context);

                            showCupertinoDialog(
                              context: this.context,
                              builder: (context) => CupertinoAlertDialog(
                                title: Text('Added to Cart 📚'),
                                content: Text('${widget.book['name']} ($selectedFormat) added to your cart!'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('Keep Browsing'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 54,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF8B4513), Color(0xFFD2691E)],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF8B4513).withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.cart_fill, color: Color(0xFFFFFFFF), size: 18),
                                  SizedBox(width: 10),
                                  Text(
                                    'ADD TO CART',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return CupertinoPageScaffold(
      backgroundColor: _bg,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Cover image header
              SliverToBoxAdapter(
                child: Container(
                  height: 380,
                  color: widget.isDark ? Color(0xFF1A1410) : Color(0xFFEDE0CC),
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40, bottom: 20),
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF000000).withOpacity(0.35),
                                  blurRadius: 24,
                                  offset: Offset(6, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                book['image'],
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(
                                  height: 240,
                                  color: Color(0xFF8B4513).withOpacity(0.2),
                                  child: Center(child: Text('📖', style: TextStyle(fontSize: 64))),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => Navigator.pop(context),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: widget.isDark
                                    ? Color(0xFF2A1F18).withOpacity(0.9)
                                    : Color(0xFFFFFFFF).withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _border),
                              ),
                              child: Icon(CupertinoIcons.back, color: _text, size: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: _bg,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Genre tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (book['genres'] as List).map<Widget>((genre) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFF8B4513).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              genre,
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF8B4513),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )).toList(),
                        ),
                        SizedBox(height: 14),

                        Text(
                          book['name'],
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: _text,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 6),

                        Text(
                          'by ${book['author']}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF8B4513),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),

                        Row(
                          children: [
                            ...List.generate(5, (i) => Icon(
                              i < book['rating'].floor()
                                  ? CupertinoIcons.star_fill
                                  : CupertinoIcons.star,
                              size: 16,
                              color: Color(0xFFFFAA00),
                            )),
                            SizedBox(width: 8),
                            Text(
                              '${book['rating']} · ${book['reviews'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} reviews',
                              style: TextStyle(fontSize: 13, color: _subtext),
                            ),
                          ],
                        ),
                        SizedBox(height: 14),

                        Text(
                          '₱${book['price']}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: _text,
                          ),
                        ),

                        SizedBox(height: 20),

                        // Divider
                        Container(height: 1, color: _border),
                        SizedBox(height: 20),

                        Text(
                          'ABOUT THIS BOOK',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                            color: _subtext,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          book['description'],
                          style: TextStyle(
                            fontSize: 15,
                            color: widget.isDark ? Color(0xFFB8967A) : Color(0xFF4A3728),
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 24),

                        // Book details grid
                        Text(
                          'BOOK DETAILS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                            color: _subtext,
                          ),
                        ),
                        SizedBox(height: 12),

                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _card,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: _border),
                          ),
                          child: Column(
                            children: [
                              _buildDetailRow('Publisher', book['publisher']),
                              _buildDivider(),
                              _buildDetailRow('Pages', book['pages']),
                              _buildDivider(),
                              _buildDetailRow('Language', book['language']),
                              _buildDivider(),
                              _buildDetailRow('ISBN', book['isbn']),
                            ],
                          ),
                        ),

                        SizedBox(height: 24),

                        // Available formats
                        Text(
                          'AVAILABLE FORMATS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                            color: _subtext,
                          ),
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (book['formats'] as List).map<Widget>((f) {
                            String emoji = '📕';
                            if (f == 'Paperback') emoji = '📗';
                            if (f == 'E-Book') emoji = '📱';
                            if (f == 'Audiobook') emoji = '🎧';
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: _card,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: _border),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(emoji, style: TextStyle(fontSize: 14)),
                                  SizedBox(width: 6),
                                  Text(
                                    f,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: _text,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),

                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Fixed Add to Cart Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _card.withOpacity(0.97),
                border: Border(top: BorderSide(color: _border, width: 1)),
              ),
              child: SafeArea(
                top: false,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _showFormatSelector,
                  child: Container(
                    width: double.infinity,
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF8B4513), Color(0xFFD2691E)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF8B4513).withOpacity(0.4),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.cart_fill, color: Color(0xFFFFFFFF), size: 18),
                          SizedBox(width: 10),
                          Text(
                            'ADD TO CART',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: _subtext)),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _text),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: _border);
  }
}