class Member {
  final int id;
  final String name;
  final String nickName;
  final String code;

  Member({
    this.id,
    this.name,
    this.nickName,
    this.code,
  });

  String get getShortName {
    final splits = name.split(' ');
    if (splits.length > 1) {
      return '${splits[0]} ${splits[splits.length - 1]}';
    }
    return name;
  }
}
