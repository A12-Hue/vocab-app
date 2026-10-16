import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models.dart';
import '../default_options.dart';
import 'dart:math' as math;

class QuizScreen extends StatefulWidget {
  final List<Word> words;
  final String title;

  const QuizScreen({
    super.key,
    required this.words,
    this.title = '刷题模式',
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  late List<Word> _shuffledWords;
  int _currentIndex = 0;
  int _correctCount = 0;
  int _wrongCount = 0;
  List<String> _options = [];
  String? _selectedAnswer;
  bool _isAnswered = false;
  late AnimationController _cardController;
  late AnimationController _optionController;
  late Animation<double> _cardAnimation;
  late Animation<double> _optionAnimation;

  @override
  void initState() {
    super.initState();
    _shuffledWords = List.from(widget.words)..shuffle();
    _generateOptions();
    
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _optionController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _cardAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOutBack,
    );
    _optionAnimation = CurvedAnimation(
      parent: _optionController,
      curve: Curves.easeOut,
    );
    
    _cardController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _optionController.forward();
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    _optionController.dispose();
    super.dispose();
  }

  void _generateOptions() {
    final currentWord = _shuffledWords[_currentIndex];

    // 收集所有可用的用户单词选项（排除当前单词）
    final allUserWords = widget.words
        .where((w) => w.id != currentWord.id)
        .map((w) => w.chineseMeaning)
        .toList();

    // 打乱用户单词选项
    allUserWords.shuffle();

    // 初始化选项列表，首先添加正确答案
    _options = [currentWord.chineseMeaning];

    // 添加来自用户单词的干扰选项（最多3个）
    int userOptionsCount = math.min(3, allUserWords.length);
    _options.addAll(allUserWords.take(userOptionsCount));

    // 如果用户选项不够4个，从默认选项中补充
    if (_options.length < 4) {
      // 创建已使用选项的集合，避免重复
      final usedOptions = Set<String>.from(_options);

      // 从默认选项中筛选出未使用的选项
      final availableDefaults = defaultChineseOptions
          .where((opt) => !usedOptions.contains(opt))
          .toList();

      // 打乱默认选项
      availableDefaults.shuffle();

      // 补充所需数量的选项
      int neededCount = 4 - _options.length;
      _options.addAll(availableDefaults.take(neededCount));
    }

    // 最终打乱所有选项
    _options.shuffle();
  }

  void _checkAnswer(String answer) {
    if (_isAnswered) return;

    setState(() {
      _selectedAnswer = answer;
      _isAnswered = true;

      final currentWord = _shuffledWords[_currentIndex];
      if (answer == currentWord.chineseMeaning) {
        _correctCount++;
      } else {
        _wrongCount++;
        
        final errorBox = Hive.box<ErrorRecord>('error_records');
        errorBox.add(ErrorRecord(
          wordId: currentWord.id,
          groupId: '',
          english: currentWord.english,
          correctAnswer: currentWord.chineseMeaning,
          userAnswer: answer,
          wrongAt: DateTime.now(),
        ));

        currentWord.wrongCount++;
        currentWord.save();
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _shuffledWords.length - 1) {
      _cardController.reset();
      _optionController.reset();
      
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _isAnswered = false;
        _generateOptions();
      });
      
      _cardController.forward();
      Future.delayed(const Duration(milliseconds: 200), () {
        _optionController.forward();
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161D2B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6EE7B7), Color(0xFF38BDF8)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              '测验完成！',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildResultItem(
                  '正确',
                  _correctCount.toString(),
                  const Color(0xFF6EE7B7),
                  Icons.check_circle_rounded,
                ),
                _buildResultItem(
                  '错误',
                  _wrongCount.toString(),
                  Colors.red,
                  Icons.cancel_rounded,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              '准确率: ${((_correctCount / _shuffledWords.length) * 100).toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF38BDF8),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('完成'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _correctCount = 0;
                _wrongCount = 0;
                _selectedAnswer = null;
                _isAnswered = false;
                _shuffledWords.shuffle();
                _generateOptions();
              });
              _cardController.forward();
              Future.delayed(const Duration(milliseconds: 200), () {
                _optionController.forward();
              });
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF38BDF8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            child: const Text('再来一次'),
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 40),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentWord = _shuffledWords[_currentIndex];
    final progress = (_currentIndex + 1) / _shuffledWords.length;

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
          child: Column(
            children: [
              _buildHeader(progress),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildQuestionCard(currentWord),
                      const SizedBox(height: 32),
                      _buildOptions(),
                      if (_isAnswered) ...[
                        const SizedBox(height: 32),
                        _buildNextButton(),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double progress) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0F131C).withOpacity(0.9),
            const Color(0xFF161D2B).withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded, size: 28),
                color: Colors.white,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '第 ${_currentIndex + 1} / ${_shuffledWords.length} 题',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6EE7B7), Color(0xFF38BDF8)],
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '$_correctCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.cancel_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '$_wrongCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFF0F131C),
              valueColor: AlwaysStoppedAnimation<Color>(
                progress < 0.5
                    ? const Color(0xFF38BDF8)
                    : const Color(0xFF6EE7B7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Word word) {
    return ScaleTransition(
      scale: _cardAnimation,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF161D2B),
              Color(0xFF1E2636),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF38BDF8).withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0F131C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                word.partOfSpeech.join('、'),
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF6EE7B7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              word.english,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 3,
              width: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF38BDF8), Color(0xFF6EE7B7)],
                ),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return FadeTransition(
      opacity: _optionAnimation,
      child: Column(
        children: _options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = _selectedAnswer == option;
          final currentWord = _shuffledWords[_currentIndex];
          final isCorrect = option == currentWord.chineseMeaning;

          Color getColor() {
            if (!_isAnswered) return const Color(0xFF161D2B);
            if (isCorrect) return const Color(0xFF6EE7B7).withOpacity(0.3);
            if (isSelected) return Colors.red.withOpacity(0.3);
            return const Color(0xFF161D2B);
          }

          Color getBorderColor() {
            if (!_isAnswered && isSelected) return const Color(0xFF38BDF8);
            if (!_isAnswered) return const Color(0xFF1E2636);
            if (isCorrect) return const Color(0xFF6EE7B7);
            if (isSelected) return Colors.red;
            return const Color(0xFF1E2636);
          }

          return TweenAnimationBuilder(
            duration: Duration(milliseconds: 300 + (index * 100)),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: getColor(),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: getBorderColor(), width: 2),
                boxShadow: [
                  if (isSelected || (_isAnswered && isCorrect))
                    BoxShadow(
                      color: getBorderColor().withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _checkAnswer(option),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: getBorderColor().withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + index),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: getBorderColor(),
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
                                option,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              if (_isAnswered && isCorrect && isSelected)
                                const Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    '✓ 回答正确',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF6EE7B7),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              else if (_isAnswered && isSelected && !isCorrect)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    '✗ 正确答案: ${currentWord.chineseMeaning}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (_isAnswered && isCorrect)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF6EE7B7),
                            size: 28,
                          )
                        else if (_isAnswered && isSelected)
                          const Icon(
                            Icons.cancel_rounded,
                            color: Colors.red,
                            size: 28,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNextButton() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF38BDF8), Color(0xFF3B6DFF)],
          ),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF38BDF8).withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _nextQuestion,
            borderRadius: BorderRadius.circular(999),
            child: Center(
              child: Text(
                _currentIndex < _shuffledWords.length - 1 ? '下一题' : '查看结果',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

