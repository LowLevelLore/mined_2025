import 'package:flutter/material.dart';
import 'package:mined_2025/client/utils/widgets/podcast/person1.dart';
import 'package:mined_2025/client/utils/widgets/podcast/person2.dart';

class PodCastPart extends StatefulWidget {
  final List<String> extractedFiles;

  const PodCastPart({super.key, required this.extractedFiles});

  @override
  State<PodCastPart> createState() => _PodCastPartState();
}

class _PodCastPartState extends State<PodCastPart> {
  int index = 0;

  void _nextAudio() {

    // Check if there are more audio files to display
    if (index + 2 < widget.extractedFiles.length) {
      setState(() {
        index += 2; // Move to the next pair of Person1 and Person2
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure that there are enough files to display
    return SingleChildScrollView(
      child: widget.extractedFiles.isNotEmpty
          ? Column(
        children: [
          // Display Person1 and Person2 with the current audio files
          Person1(audioFile: widget.extractedFiles[index]),
          Person2(audioFile: widget.extractedFiles[index + 1]),
          SizedBox(height: 20),
          // "Next" button to go to the next audio
          ElevatedButton(
            onPressed: _nextAudio,
            child: Text('Next'),
          ),
        ],
      )
          : Container(),
    );
  }
}
