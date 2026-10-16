import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models.dart';
import 'quiz_screen.dart';

class QuizAllScreen extends StatelessWidget {
  const QuizAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF05070C),
              Color(0xFF0F131C),
              Color(0xFF161D2B),
            ],
          ),
        ),
        child: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: Hive.box<VocabGroup>('vocab_groups').listenable(),
            builder: (context, Box<VocabGroup> box, _) {
              final groups = box.values.toList();
              
              if (groups.isEmpty) {
                return _buildEmptyState(context);
              }

              final allWords = <Word>[];
              for (var group in groups) {
                allWords.addAll(group.words);
              }

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 160,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text(
                        '刷题模式',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF38BDF8).withOpacity(0.2),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.quiz_rounded,
                            size: 80,
                            color: const Color(0xFF38BDF8).withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        if (allWords.isNotEmpty)
                          _buildQuizCard(
                            context,
                            '全部单词',
                            '${allWords.length} 个单词',
                            Icons.all_inclusive_rounded,
                            const Color(0xFF38BDF8),
                            () => _startQuiz(context, allWords, '全部单词'),
                          ),
                        const SizedBox(height: 24),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                            '按词元刷题',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        ...groups.map((group) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildQuizCard(
                                context,
                                group.name,
                                '${group.words.length} 个单词',
                                Icons.folder_rounded,
                                const Color(0xFF6EE7B7),
                                group.words.isEmpty
                                    ? null
                                    : () => _startQuiz(
                                          context,
                                          group.words,
                                          group.name,
                                        ),
                              ),
                            )),
                      ]),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.quiz_outlined,
            size: 120,
            color: Colors.white.withOpacity(0.1),
          ),
          const SizedBox(height: 24),
          Text(
            '还没有单词',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '先去添加一些单词吧',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback? onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF161D2B),
            const Color(0xFF1E2636),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.6)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: color,
                    size: 20,
                  )
                else
                  Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.white.withOpacity(0.3),
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startQuiz(BuildContext context, List<Word> words, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(words: words, title: title),
      ),
    );
  }
}
