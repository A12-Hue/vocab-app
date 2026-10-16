import 'package:flutter/material.dart';
import '../models.dart';

class GroupDetailScreen extends StatefulWidget {
  final VocabGroup group;

  const GroupDetailScreen({super.key, required this.group});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  final TextEditingController _englishController = TextEditingController();
  final TextEditingController _chineseController = TextEditingController();
  List<String> _selectedPosList = [];

  final List<String> _posOptions = [
    '名词', '动词', '形容词', '副词', '短语', '介词', '连词', '代词', '感叹词'
  ];

  void _addWord() {
    if (_englishController.text.trim().isEmpty ||
        _chineseController.text.trim().isEmpty ||
        _selectedPosList.isEmpty) {
      return;
    }

    // 检查单词数量限制（每个词元最多 100 个单词）
    if (widget.group.words.length >= 100) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('该词元已达到最大单词数量限制（100个）'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    final word = Word(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      english: _englishController.text.trim(),
      partOfSpeech: List.from(_selectedPosList),
      chineseMeaning: _chineseController.text.trim(),
      createdAt: DateTime.now(),
    );

    setState(() {
      widget.group.words.add(word);
      widget.group.save();
    });

    _englishController.clear();
    _chineseController.clear();
    _selectedPosList.clear();
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('单词添加成功'),
        backgroundColor: const Color(0xFF6EE7B7),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showAddWordDialog() {
    _selectedPosList = [];
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF161D2B),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('添加单词'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: widget.group.words.length >= 100
                      ? Colors.red.withOpacity(0.2)
                      : const Color(0xFF6EE7B7).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.group.words.length >= 100
                        ? Colors.red
                        : const Color(0xFF6EE7B7),
                  ),
                ),
                child: Text(
                  '${widget.group.words.length}/100',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: widget.group.words.length >= 100
                        ? Colors.red
                        : const Color(0xFF6EE7B7),
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _englishController,
                  decoration: const InputDecoration(
                    labelText: '英文单词',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '词性（可多选）',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _posOptions.map((pos) {
                          final isSelected = _selectedPosList.contains(pos);
                          return FilterChip(
                            label: Text(pos),
                            selected: isSelected,
                            onSelected: (selected) {
                              setDialogState(() {
                                if (selected) {
                                  _selectedPosList.add(pos);
                                } else {
                                  _selectedPosList.remove(pos);
                                }
                              });
                            },
                            selectedColor: const Color(0xFF38BDF8),
                            checkmarkColor: Colors.white,
                            backgroundColor: const Color(0xFF0F131C),
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.white70,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _chineseController,
                  decoration: const InputDecoration(
                    labelText: '中文释义',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _selectedPosList.clear();
                Navigator.pop(context);
              },
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: _addWord,
              child: const Text('添加'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteWord(int index) {
    setState(() {
      widget.group.words.removeAt(index);
      widget.group.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
        backgroundColor: const Color(0xFF0F131C),
      ),
      body: widget.group.words.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_outlined, size: 80, color: Colors.grey[700]),
                  const SizedBox(height: 16),
                  Text(
                    '还没有单词',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '点击右下角按钮添加单词',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.group.words.length,
              itemBuilder: (context, index) {
                final word = widget.group.words[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      word.english,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('词性：${word.partOfSpeech.join('、')}'),
                        Text('释义：${word.chineseMeaning}'),
                        if (word.wrongCount > 0)
                          Text(
                            '错误次数：${word.wrongCount}',
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _deleteWord(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddWordDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _englishController.dispose();
    _chineseController.dispose();
    super.dispose();
  }
}
