import 'package:flutter/material.dart';
import 'package:jewelry_nafisa/src/ui/screens/profile/profile_screen.dart';

class BoardCard extends StatelessWidget {
  final Board board;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const BoardCard({
    super.key,
    required this.board,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBoardImages(context),
            _buildBoardInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBoardImages(BuildContext context) {
    final images = board.coverUrls;
    final theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        color: theme.colorScheme.surface.withAlpha((255 * 0.5).round()),
        child: images.isEmpty
            ? _buildPlaceholder(context)
            : images.length < 3
                ? _buildSingleImage(images.first)
                : _buildCollage(images),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Icon(
      Icons.photo_library_outlined,
      size: 48,
      color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.3).round()),
    );
  }

  Widget _buildSingleImage(String url) {
    return Image.network(url, fit: BoxFit.cover);
  }

  Widget _buildCollage(List<String> images) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Image.network(images[0], fit: BoxFit.cover, height: double.infinity),
        ),
        const SizedBox(width: 2),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(child: Image.network(images[1], fit: BoxFit.cover, width: double.infinity)),
              const SizedBox(height: 2),
              Expanded(child: Image.network(images[2], fit: BoxFit.cover, width: double.infinity)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBoardInfo(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              board.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Board?'),
                  content: Text(
                    'Are you sure you want to delete the "${board.name}" board and all its images?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                onDelete();
              }
            },
          ),
        ],
      ),
    );
  }
}