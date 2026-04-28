import 'package:flutter/cupertino.dart';
import 'bookpage.dart';

class BookReadingPage extends StatefulWidget {
  final Map<String, dynamic> book;
  final bool isDark;
  final Function(Map<String, dynamic>)? onAddToCart;

  const BookReadingPage({
    super.key,
    required this.book,
    required this.isDark,
    this.onAddToCart,
  });

  @override
  State<BookReadingPage> createState() => _BookReadingPageState();
}

class _BookReadingPageState extends State<BookReadingPage> {
  double _fontSize = 16;
  bool _isBookmarked = false;
  int _currentPage = 1;

  Color get _bg => widget.isDark ? Color(0xFF0D0D0D) : Color(0xFFFAF5ED);
  Color get _card => widget.isDark ? Color(0xFF1A1410) : Color(0xFFFFFFFF);
  Color get _text => widget.isDark ? Color(0xFFE8D5B7) : Color(0xFF2C1810);
  Color get _subtext => widget.isDark ? Color(0xFF8B7355) : Color(0xFF9B7B5A);
  Color get _border => widget.isDark ? Color(0xFF3A2820) : Color(0xFFE8D5B7);
  Color get _pageText => widget.isDark ? Color(0xFFD4B896) : Color(0xFF3A2510);

  // Extended excerpt content — simulated multi-page preview
  List<String> get _pages {
    final excerpt = widget.book['excerpt'] as String? ?? '';
    final name = widget.book['name'] as String;
    final author = widget.book['author'] as String;

    return [
      // Page 1 — Opening
      excerpt.isNotEmpty
          ? excerpt
          : 'The story of $name begins in a world unlike any other — one that $author crafted with extraordinary care and imagination. Every sentence carries weight; every word was chosen deliberately.\n\nStep into these pages and you will find yourself transported somewhere entirely new.',

      // Page 2 — Continuation
      'As the narrative unfolds, the themes of ${(widget.book['genres'] as List).take(2).join(" and ")} begin to emerge with clarity. The characters are rendered with remarkable depth — their motivations layered, their flaws visible, their victories earned.\n\n"${name}" is not merely a story. It is an experience that lingers long after the final page is turned.',

      // Page 3 — Preview end
      'This is a preview of the first few pages of "${name}" by ${author}.\n\nThe complete ${widget.book['pages']}-page edition is available in ${(widget.book['formats'] as List).join(", ")} format${(widget.book['formats'] as List).length > 1 ? "s" : ""}.\n\nPublished by ${widget.book['publisher']}.\nISBN: ${widget.book['isbn']}',
    ];
  }

  void _showFontSizeSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: 220,
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(top: BorderSide(color: _border)),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text('TEXT SIZE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 2, color: _subtext)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text('A', style: TextStyle(fontSize: 13, color: _subtext, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: CupertinoSlider(
                          value: _fontSize,
                          min: 12,
                          max: 24,
                          divisions: 6,
                          activeColor: Color(0xFF8B4513),
                          onChanged: (val) {
                            setModalState(() {});
                            setState(() => _fontSize = val);
                          },
                        ),
                      ),
                      Text('A', style: TextStyle(fontSize: 22, color: _subtext, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Font size: ${_fontSize.round()}pt',
                  style: TextStyle(fontSize: 12, color: _subtext),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final pages = _pages;
    final totalPages = pages.length;

    return CupertinoPageScaffold(
      backgroundColor: _bg,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: _bg.withOpacity(0.95),
        border: Border(bottom: BorderSide(color: _border, width: 0.5)),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back, color: _text),
          onPressed: () => Navigator.pop(context),
        ),
        middle: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              book['name'],
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: _text),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Preview · Page $_currentPage of $totalPages',
              style: TextStyle(fontSize: 10, color: _subtext),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(
                _isBookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                color: _isBookmarked ? Color(0xFF8B4513) : _subtext,
                size: 20,
              ),
              onPressed: () => setState(() => _isBookmarked = !_isBookmarked),
            ),
            CupertinoButton(
              padding: EdgeInsets.only(left: 4),
              child: Icon(CupertinoIcons.textformat_size, color: _subtext, size: 20),
              onPressed: _showFontSizeSheet,
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Book info strip
            Container(
              margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(color: Color(0xFF000000).withOpacity(0.2), blurRadius: 6, offset: Offset(2, 2)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        book['image'],
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
                        Text(
                          book['name'],
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _text),
                          maxLines: 2,
                        ),
                        SizedBox(height: 2),
                        Text('by ${book['author']}', style: TextStyle(fontSize: 12, color: Color(0xFF8B4513), fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Color(0xFF8B4513).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'FREE PREVIEW',
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF8B4513), letterSpacing: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('₱${book['price']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: _text)),
                ],
              ),
            ),

            // Reading content
            Expanded(
              child: PageView.builder(
                itemCount: totalPages,
                onPageChanged: (i) => setState(() => _currentPage = i + 1),
                itemBuilder: (context, index) {
                  final isLastPage = index == totalPages - 1;
                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(28, 28, 28, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Chapter header
                        if (index == 0) ...[
                          Text(
                            'CHAPTER ONE',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 3, color: Color(0xFF8B4513)),
                          ),
                          SizedBox(height: 8),
                          Container(width: 40, height: 2, color: Color(0xFF8B4513)),
                          SizedBox(height: 24),
                        ] else if (index == 1) ...[
                          Text(
                            'CONTINUED',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 3, color: _subtext),
                          ),
                          SizedBox(height: 20),
                        ] else ...[
                          Text(
                            'END OF PREVIEW',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 3, color: _subtext),
                          ),
                          SizedBox(height: 20),
                        ],

                        // Content
                        Text(
                          pages[index],
                          style: TextStyle(
                            fontSize: _fontSize,
                            color: _pageText,
                            height: 1.85,
                            fontFamily: 'Georgia',
                          ),
                        ),

                        // Decorative divider at paragraph ends
                        if (!isLastPage) ...[
                          SizedBox(height: 40),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(width: 20, height: 1, color: _border),
                                SizedBox(width: 8),
                                Text('✦', style: TextStyle(fontSize: 10, color: _subtext)),
                                SizedBox(width: 8),
                                Container(width: 20, height: 1, color: _border),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          Center(
                            child: Text(
                              'Swipe to continue →',
                              style: TextStyle(fontSize: 11, color: _subtext),
                            ),
                          ),
                        ],

                        // Last page CTA
                        if (isLastPage) ...[
                          SizedBox(height: 40),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 1,
                                  color: _border,
                                ),
                                SizedBox(height: 24),
                                Text(
                                  'Enjoying the preview?',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: _text),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Get the full ${book['pages']}-page edition',
                                  style: TextStyle(fontSize: 13, color: _subtext),
                                ),
                                SizedBox(height: 24),
                                if (widget.onAddToCart != null)
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => BookDetailPage(
                                            book: book,
                                            onAddToCart: widget.onAddToCart!,
                                            isDark: widget.isDark,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [Color(0xFF8B4513), Color(0xFFD2691E)]),
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(color: Color(0xFF8B4513).withOpacity(0.4), blurRadius: 12, offset: Offset(0, 4)),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(CupertinoIcons.cart_fill, color: Color(0xFFFFFFFF), size: 16),
                                          SizedBox(width: 8),
                                          Text(
                                            'GET FULL BOOK  ₱${book['price']}',
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFFFFFFFF), letterSpacing: 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom page indicator
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: _border, width: 0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalPages, (i) {
                  final active = i + 1 == _currentPage;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    width: active ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: active ? Color(0xFF8B4513) : _border,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}