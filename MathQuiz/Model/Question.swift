import Foundation

struct Question: Hashable {
  var lhs: Int? = nil
  var rhs: Int? = nil
  var text: String
  var answer: Int

  func check(attempt: Int) -> Bool {
    answer == attempt
  }
}

extension Question {
  static func randomAddition(range: Range<Int> = 1..<10) -> Question {
    let lhs = Int.random(in: range)
    let rhs = Int.random(in: range)

    return Question(lhs: lhs, rhs: rhs, text: "\(lhs) + \(rhs)", answer: (lhs + rhs))
  }

  static func randomSubtraction(range: Range<Int> = 1..<10) -> Question {
    var lhs = Int.random(in: range)
    var rhs = Int.random(in: range)
    if (lhs < rhs) {
      swap(&lhs, &rhs)
    }

    return Question(lhs: lhs, rhs: rhs, text: "\(lhs) - \(rhs)", answer: (lhs - rhs))
  }

  static func randomMultiplication(range1: Range<Int> = 1..<10, range2: Range<Int> = 1..<10) -> Question {
    let lhs = Int.random(in: range1)
    let rhs = Int.random(in: range2)

    return Question(lhs: lhs, rhs: rhs, text: "\(lhs) x \(rhs)", answer: (lhs * rhs))
  }

  static func randomDivision(range: Range<Int> = 1..<10) -> Question {
    let rhs = Int.random(in: range)
    let lhs = Int.random(in: range) * rhs

    return Question(lhs: lhs, rhs: rhs, text: "\(lhs) ÷ \(rhs)", answer: (lhs/rhs))
  }
}

extension Question {
  static func questionBank() -> [Question] {
    return [
      (0..<3).map { _ in randomAddition(range: 40..<100) },
      (0..<3).map { _ in randomSubtraction(range: 40..<100) },
      (0..<6).map { _ in randomMultiplication(range1: 6..<10, range2: 6..<10) },
      (0..<4).map { _ in randomMultiplication(range1: 11..<30, range2: 2..<6) },
      (0..<6).map { _ in randomDivision(range: 4..<12) },
    ].flatMap { $0 }
  }
}
