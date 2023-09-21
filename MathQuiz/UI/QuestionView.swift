import SwiftUI

struct QuestionView: View {
  enum Status {
    case attempting
    case correct
    case incorrect

    func backgroundColor() -> Color {
      switch (self) {
        case .attempting: return Color.blue
        case .correct: return Color.green
        case .incorrect: return Color.red
      }
    }
  }

  let question: Question

  private let font = Font.system(size: 60)
  @State private var attemptText: String = ""
  @State private var status: Status = .attempting

  var body: some View {
    VStack(spacing: 40) {
      Text(question.text)
        .font(font)
        .padding(.top, 30)

      answerField()

      checkButton()

      Spacer()
    }
    .padding(20)
  }

  private func checkButton() -> some View {
    Button(buttonText(status)) {
      if let attempt = Int(attemptText) {
        withAnimation(.easeInOut) {
          check(attempt: attempt)
        }
      }
    }
    .padding()
    .padding([.leading, .trailing], 20)
    .font(.largeTitle)
    .foregroundColor(.white)
    .background(status.backgroundColor())
    .clipShape(Capsule())
  }

  private func buttonText(_ status: Status) -> String {
    switch(status) {
      case .attempting: return "Check"
      case .correct: return "✓"
      case .incorrect: return "Uh oh!"
    }
  }

  private func answerField() -> some View {
    TextField("", text: $attemptText)
      .onChange(of: attemptText) { text in
        withAnimation {
          self.status = .attempting
        }
      }
      .keyboardType(.numberPad)
      .multilineTextAlignment(.center)
      .font(font)
      .border(.gray)
      .padding([.leading, .trailing], 40)
      .textFieldStyle(RoundedBorderTextFieldStyle())
  }

  private func check(attempt: Int) {
    self.status = question.check(attempt: attempt) ? .correct : .incorrect
  }
}

struct QuestionView_Previews: PreviewProvider {
  static var previews: some View {
    QuestionView(question: Question.randomAddition())
  }
}
