import 'dart:io';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

main() {
  Solution obj = new Solution();
  obj.analyzeFile();
  obj.calculateLineWithHighestFrequency();
  obj.printHighestWordFrequencyAcrossLines();
}

class Solution {

  List<String> contentList = new List();
  List<Map<String, int>> mapList = new List();
  List<FrequencyList> frequencyList = new List();
  int highestFrequency = 0;

  analyzeFile(){
    contentList = new File('file.txt').readAsLinesSync();
  }

  calculateLineWithHighestFrequency() {
    for (String content in contentList) {
      List<String> line = content.toLowerCase().split(' ');
      Map<String, int> map = new Map();
      for (String word in line) {
        map[word] = map.containsKey(word) ? map[word] + 1 : 1;
        if (map[word] > highestFrequency) {
          highestFrequency = map[word];
        }
      }
      mapList.add(map);
    }

    int lineNumber = 1;
    for (Map<String, int> map in mapList) {
      frequencyList.add(new FrequencyList(lineNumber, map.entries.where((e) => e.value == highestFrequency).map((e) => e.key).toList()));
      lineNumber++;
    }
  }

  printHighestWordFrequencyAcrossLines() {
    for (FrequencyList list in frequencyList) {
      list.printList();
    }
  }
}


class FrequencyList {
  int lineNumber;
  List<String> list = new List();

  FrequencyList(int lineNumber, List<String> list) {
    this.lineNumber = lineNumber;
    this.list = list;
  }

  printList() {
    if (!list.isEmpty) {
      print('$list (appears in line $lineNumber)');
    }
  }
}