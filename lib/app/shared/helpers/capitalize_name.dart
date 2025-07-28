String capitalizeName(String? name) {
  if (name == null || name.isEmpty) return '';
  return name
      .split(' ')
      .map((word) {
        if (word.length > 3) {
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        }
        return word;
      })
      .join(' ');
}
