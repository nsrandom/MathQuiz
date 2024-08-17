import Foundation

struct QuizScore: Codable {
  var date: Date
  var numQuestions: Int
  var timeTaken: TimeInterval
  var numMistakes: Int
}

extension QuizScore {
  private static let PreviousScoreKey = "PreviousScore"

  func save() {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(self) {
      let defaults = UserDefaults.standard
      defaults.set(encoded, forKey: QuizScore.PreviousScoreKey)
    }
  }

  static func load() -> QuizScore? {
    if let data = UserDefaults.standard.object(forKey: QuizScore.PreviousScoreKey) as? Data {
      let decoder = JSONDecoder()
      if let previousScore = try? decoder.decode(QuizScore.self, from: data) {
        return previousScore
      }
    }

    return nil
  }
}
