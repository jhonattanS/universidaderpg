import 'dart:math';

class Classe {
  static String random() =>
      Classe.to.values.elementAt(Random().nextInt(Classe.to.length));

  static final to = {
    "mage": "Mage",
    "warlock": "Warlock",
    "paladin": "Paladin",
    "warrior": "Warrior"
  };
}
