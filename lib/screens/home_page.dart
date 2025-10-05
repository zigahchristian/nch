// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:nch/providers/hymnal_model.dart';
import 'package:nch/screens/hymnal_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:nch/screens/contact_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HymnalModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('The New Catholic Hymnal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.contact_page_sharp),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => const ContactScreen(),
            ),
            tooltip: 'Settings',
          ),
          IconButton(
            icon: Icon(
              model.showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () =>
                model.setShowFavoritesOnly(!model.showFavoritesOnly),
            tooltip: 'Toggle favorites',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (v) => model.setQuery(v),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by title, first line, text or number',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Consumer<HymnalModel>(
              builder: (context, m, _) {
                final list = m.filtered;
                if (list.isEmpty) {
                  return const Center(child: Text('No hymns found'));
                }
                return _AnimatedHymnList(hymns: list);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedHymnList extends StatefulWidget {
  final List<dynamic> hymns;

  const _AnimatedHymnList({required this.hymns});

  @override
  State<_AnimatedHymnList> createState() => _AnimatedHymnListState();
}

class _AnimatedHymnListState extends State<_AnimatedHymnList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300), // Same duration for all
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Start animation immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HymnalModel>(context);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView.builder(
          itemCount: widget.hymns.length,
          itemBuilder: (context, idx) {
            final h = widget.hymns[idx];
            final fav = model.favoriteSet.contains(h.number);
            return _HymnTile(
              hymn: h,
              isFavorite: fav,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => HymnDetailPage(hymn: h)),
              ),
              onToggleFavorite: () => model.toggleFavorite(h.number),
            );
          },
        ),
      ),
    );
  }
}

class _HymnTile extends StatelessWidget {
  final dynamic hymn;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  const _HymnTile({
    required this.hymn,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${hymn.number}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hymn.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        key: ValueKey(isFavorite),
                        color: isFavorite ? Colors.red : null,
                        size: 24,
                      ),
                    ),
                    onPressed: onToggleFavorite,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
