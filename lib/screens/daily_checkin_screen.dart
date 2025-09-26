import 'package:flutter/material.dart';

class DailyCheckInScreen extends StatefulWidget {
  const DailyCheckInScreen({super.key});

  @override
  State<DailyCheckInScreen> createState() => _DailyCheckInScreenState();
}

class _DailyCheckInScreenState extends State<DailyCheckInScreen> {
  double _moodValue = 5; // slider default
  String? _note; // text note
  int? _selectedEmojiIndex; // optional emoji selection

  final List<String> _emojis = ["😞", "😐", "😊", "😁", "🤩"];

  void _saveCheckIn() {
    // Local state only (no backend yet)
    debugPrint("Mood: $_moodValue");
    debugPrint("Emoji: ${_selectedEmojiIndex != null ? _emojis[_selectedEmojiIndex!] : "Not selected"}");
    debugPrint("Note: $_note");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Daily check-in saved locally!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Check-In"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How are you feeling today?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Mood slider
            Text("Mood: ${_moodValue.toInt()}/10"),
            Slider(
              value: _moodValue,
              min: 1,
              max: 10,
              divisions: 9,
              label: _moodValue.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _moodValue = value;
                  _selectedEmojiIndex = null; // reset emoji if slider used
                });
              },
            ),

            const SizedBox(height: 16),

            // Emoji selection
            const Text("Or choose an emoji:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_emojis.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedEmojiIndex = index;
                      _moodValue = (index + 1) * 2.5; // map emoji to slider
                    });
                  },
                  child: Text(
                    _emojis[index],
                    style: TextStyle(
                      fontSize: 32,
                      color: _selectedEmojiIndex == index
                          ? Colors.teal
                          : Colors.black,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Text note
            TextField(
              decoration: const InputDecoration(
                labelText: "Add a note (optional)",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) {
                _note = value;
              },
            ),

            const Spacer(),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveCheckIn,
                child: const Text("Save Check-In"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
