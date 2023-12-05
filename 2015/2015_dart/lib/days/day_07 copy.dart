import 'package:dart_2015/days/abstract_day.dart';
import 'package:dart_2015/days/util/string_util.dart';

class Day07 extends AbstractDay {
  @override
  int day = 7;

  @override
  String title = "Some Assembly Required";

  @override
  int solvePart1() {
    // TODO
    return 0;
  }

  @override
  int solvePart2() {
    // TODO
    return 0;
  }
}

class Circuit {
  Map<String, Binary> wires;

  Circuit(this.wires);

  apply(List<Instruction> instrs) {
    for (Instruction instr in instrs) {}
  }
}

class Binary {
  String val;

  Binary(this.val);

  void calc(Instruction instr) {
    switch (instr.gate) {
      case Gate.and:
        and(instr.arg1 as Binary, instr.arg2 as Binary);
        break;
      case Gate.or:
        or(instr.arg1 as Binary, instr.arg2 as Binary);
        break;
      case Gate.lshift:
        lshift(instr.arg1 as Binary, instr.val as int);
        break;
      case Gate.rshift:
        rshift(instr.arg1 as Binary, instr.val as int);
        break;
      case Gate.not:
        not(instr.arg1 as Binary);
        break;
      case null:
        val = instr.val as String;
        break;
    }
  }

  void and(Binary b1, Binary b2) {
    if (b1.val.length != b2.val.length) {
      throw Exception(
          "The binaries ${b1.val} and ${b2.val} should have the same length!");
    }

    val = "";
    for (int i = 0; i < b1.val.length; i++) {
      val += (b1.val[i] == "1" && b2.val[i] == "1") ? "1" : "0";
    }
  }

  void or(Binary b1, Binary b2) {
    if (b1.val.length != b2.val.length) {
      throw Exception(
          "The binaries ${b1.val} and ${b2.val} should have the same length!");
    }

    val = "";
    for (int i = 0; i < b1.val.length; i++) {
      val += (b1.val[i] == "0" && b2.val[i] == "0") ? "0" : "1";
    }
  }

  void lshift(Binary b, int amount) {
    if (amount >= b.val.length) {
      val = "0" * b.val.length;
    }

    val = b.val.substring(amount) + ("0" * amount);
  }

  void rshift(Binary b, int amount) {
    if (amount >= b.val.length) {
      val = "0" * b.val.length;
    }

    val = ("0" * amount) + b.val.substring(amount, b.val.length);
  }

  void not(Binary b) {
    val = "";
    for (int i = 0; i < b.val.length; i++) {
      val += b.val[i] == "0" ? "1" : "0";
    }
  }

  static Binary get(int number, int size) {
    String binStr = number.toRadixString(2);
    if (size < binStr.length) {
      throw Exception("The size $size is to smaall for the binary: '$binStr'.");
    }
    String zeros = "0" * (size - binStr.length);

    return Binary(zeros + binStr);
  }
}

class Instruction {
  String? arg1;
  String? arg2;
  Gate? gate;
  Binary? val;
  String dest;

  Instruction(this.arg1, this.arg2, this.gate, this.val, this.dest);

  static List<Instruction> extract(String data, int size) {
    List<Instruction> instrs = [];
    for (String raw in StringUtil.getLines(data)) {
      String? arg1 = StringUtil.regex("([a-z]*)(?= .* ->)", raw, 0);
      String? arg2 = StringUtil.regex("([a-z]*)(?= ->)", raw, 0);
      Gate? gate = Gate.extract(StringUtil.regex("([A-Z]{0,6})", raw, 0));
      String? numStr = StringUtil.regex("([0-9]*)", raw, 0);
      Binary? val = numStr != null ? Binary.get(int.parse(numStr), size) : null;
      String dest = StringUtil.regex("(?<=-> )([a-z]*)", raw, 1) as String;
      instrs.add(Instruction(arg1, arg2, gate, val, dest));
    }

    return instrs;
  }
}

enum Gate implements Comparable<Gate> {
  and(verbose: "AND"),
  or(verbose: "OR"),
  lshift(verbose: "LSHIFT"),
  rshift(verbose: "RSHIFT"),
  not(verbose: "NOT");

  final String verbose;

  const Gate({required this.verbose});

  static Gate? extract(String? data) {
    return Gate.values.firstWhere((g) => g.verbose == data);
  }

  @override
  int compareTo(Gate other) =>
      verbose.codeUnitAt(0) - other.verbose.codeUnitAt(0);
}
