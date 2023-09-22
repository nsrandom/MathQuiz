import SwiftUI

struct ResultsView: View {
  let questions: [Question]
  let attempts: [Int]
  let timeTaken: TimeInterval

  let formattedTime: String
  let multiAttempts: [(Question, Int)]

  init(questions: [Question], attempts: [Int], timeTaken: TimeInterval) {
    assert(questions.count == attempts.count)

    self.questions = questions
    self.attempts = attempts
    self.timeTaken = timeTaken

    let duration: Duration = .seconds(timeTaken)
    self.formattedTime = duration.formatted(.time(pattern: .minuteSecond))

    var multiAttempts: [(Question, Int)] = []
    for i in 0..<attempts.count {
      if (attempts[i] > 1) {
        multiAttempts.append((questions[i], attempts[i]))
      }
    }
    self.multiAttempts = multiAttempts
  }

  var body: some View {
    VStack(spacing: 20) {
      Text("Time taken: \(formattedTime)")
        .font(.title)
        .padding(.bottom, 20)

      if (multiAttempts.count == 0) {
        Image("woohoo")
          .resizable()
          .scaledToFit()
      } else {
        List {
          ForEach(multiAttempts, id: \.0) { question, attempts in
            if (attempts > 1) {
              HStack {
                Text(question.text)
                Spacer()
                Text("\(attempts) attempts")
                  .foregroundColor(.red)
              }
            }
          }
        }
      }

      Spacer()

    }
    .padding(.top, 40)
  }
}

struct ResultsView_Previews: PreviewProvider {
  static var previews: some View {
    ResultsView(questions: Question.questionBank(),
                attempts: [1, 1, 1, 1],
                timeTaken: 34.2)
  }
}
