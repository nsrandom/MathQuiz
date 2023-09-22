import SwiftUI

enum QuizState {
  case notstarted
  case started
  case finished
}

struct QuizView: View {
  let questions: [Question]

  @State private var index = 0

  @Binding var quizState: QuizState
  @Binding var attempts: [Int]

  var body: some View {
    VStack(alignment: .center, spacing: 20) {
      Text("\(index + 1) of \(questions.count)")
        .font(.headline)
        .padding(.top, 20)

      QuestionView(question: questions[index]) { _, numAttempts in
        attempts[index] = numAttempts
        if (index < questions.count - 1) {
          withAnimation(.easeInOut) {
            index += 1
          }
        } else {
          quizState = .finished
        }
      }
      .id(index)

      Spacer()
    }
  }
}

struct QuizView_Previews: PreviewProvider {

  static var previews: some View {
    @State var attempts: [Int] = []
    @State var quizState: QuizState = .started
    @State var endTime: DispatchTime = .now()

    QuizView(questions: Question.questionBank(),
             quizState: $quizState,
             attempts: $attempts)
  }
}
