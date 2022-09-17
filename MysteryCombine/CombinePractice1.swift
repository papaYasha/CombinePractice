import SwiftUI
import Combine


class CombinePractice1ViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var validation: String = ""

    init() {
        $name
            .map { $0.isEmpty ? "❌" : "✅" }
            .assign(to: &$validation)
    }
}

struct CombinePractice1: View {

    @StateObject private var viewModel = CombinePractice1ViewModel()

    var body: some View {
        VStack {
            HStack(spacing: 40) {
                TextField("name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(viewModel.validation)
            }
            .padding()
        }
    }
}

struct CombinePractice1_Previews: PreviewProvider {
    static var previews: some View {
        CombinePractice1()
    }
}
