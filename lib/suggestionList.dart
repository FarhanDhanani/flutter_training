import 'package:flutter/material.dart';
import 'suggestion.dart';

class SuggestionsList extends StatelessWidget {
  final List<Suggestion> suggestions;
  final updateSuggestion;
  const SuggestionsList({Key key, this.suggestions, this.updateSuggestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(suggestions[1]);
    return Container(
        child: ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(suggestions[index].name ?? ""),
            trailing: IconButton(
              icon: Icon(
                Icons.favorite,
                color:
                suggestions[index].isFavourite == 1 ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                int currentStatus = suggestions[index].isFavourite;

                updateSuggestion(Suggestion(
                    id: suggestions[index].id,
                    name: suggestions[index].name,
                    isFavourite: currentStatus == 1 ? 0 : 1));
              },
            ),
          ),
        ));
  }
}