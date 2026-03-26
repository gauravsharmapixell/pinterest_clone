import 'package:flutter/material.dart';

class CreateBoardScreen extends StatefulWidget {
  const CreateBoardScreen({super.key});

  @override
  State<CreateBoardScreen> createState() => _CreateBoardScreenState();
}

class _CreateBoardScreenState extends State<CreateBoardScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSecret = false;
  bool _isGroupBoard = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _createBoard() {
    if (_controller.text.trim().isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Board "${_controller.text.trim()}" created'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final canCreate = _controller.text.trim().isNotEmpty;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(18, 10, 18, 18 + bottomInset),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, size: 34),
                ),
                const Spacer(),
                const Text(
                  'Create board',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 28),
            Center(
              child: Container(
                width: 250,
                height: 140,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E5D9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  bottomLeft: Radius.circular(24),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(color: Colors.white),
                                        bottom: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            TextField(
              controller: _controller,
              autofocus: true,
              onChanged: (_) => setState(() {}),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Board name',
                hintText: 'Name your board',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(
                    color: Color(0xFFB7B7B7),
                    width: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Make this board secret',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Only you and collaborators will see this board',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _isSecret,
                  onChanged: (value) {
                    setState(() {
                      _isSecret = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 22),
            InkWell(
              onTap: () {
                setState(() {
                  _isGroupBoard = !_isGroupBoard;
                });
              },
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Group board',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Invite collaborators to join this board',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _isGroupBoard
                            ? const Color(0xFFE8F0FE)
                            : const Color(0xFFF0F0E8),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.person_add_alt_1_outlined,
                        size: 26,
                        color: _isGroupBoard ? Colors.black : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: canCreate ? _createBoard : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: canCreate
                      ? const Color(0xFFE60023)
                      : const Color(0xFFE9E7DE),
                  foregroundColor: canCreate
                      ? Colors.white
                      : const Color(0xFF9A9A9A),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Create board',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
