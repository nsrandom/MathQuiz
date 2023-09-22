import SwiftUI

struct QuizView: View {
  let questions: [Question]

  @State private var index = 0

  var body: some View {
    VStack(alignment: .center, spacing: 20) {
      Text("\(index + 1) of \(questions.count)")
        .font(.headline)
        .padding(.top, 20)

      QuestionView(question: questions[index]) { _, _ in
        if (index < questions.count - 1) {
          withAnimation(.easeInOut) {
            index += 1
          }
        }
      }
      .id(index)

      Spacer()
    }
  }
}

struct QuizView_Previews: PreviewProvider {
  static var previews: some View {
    QuizView(questions: Question.questionBank())
  }
}
