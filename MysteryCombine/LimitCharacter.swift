import SwiftUI
import Combine

class LimitCharacterViewModel: ObservableObject {

    var characterLimit = 30
    @Published var data: String = ""
    @Published var characterCount = 0
    @Published var countColor = Color.gray

    init() {

        $data
            .map { data -> Int in
                return data.count
            }
            .assign(to: &$characterCount)

        $characterCount
            .map { [unowned self] count -> Color in
                let eightyPercent = Int(Double(characterLimit) * 0.8)
                if (eightyPercent...characterLimit).contains(count) {
                    return Color.yellow
                } else if count > characterLimit {
                    return Color.red
                }
                return Color.gray
            }
            .assign(to: &$countColor)
    }

}

struct LimitCharacter: View {

    @StateObject var viewModel = LimitCharacterViewModel()

    var body: some View {
        VStack {
            TextEditor(text: $viewModel.data)
                .border(Color.gray, width: 1)
                .frame(height: 200)
                .padding()

            Text("\(viewModel.characterCount)/\(viewModel.characterLimit)")
                .foregroundColor(viewModel.countColor)
                .font(.title)
        }
    }
}

struct LimitCharacter_Previews: PreviewProvider {
    static var previews: some View {
        LimitCharacter()
    }
}
