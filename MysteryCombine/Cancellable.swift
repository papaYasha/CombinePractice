import SwiftUI
import Combine

struct Cancellable: View {

    @StateObject var viewModel = CancellableViewModel()

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                TextField("name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(viewModel.validation)
            }.padding(50)
            Button("Cancel sub") {
                viewModel.cancellable?.cancel()
            }
        }
    }
}


class CancellableViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var validation: String = ""
    var cancellable: AnyCancellable?

    init() {
        _ = $name
            .map { $0.isEmpty ? "❌" : "✅" }
            .sink { [unowned self ] value in
                self.validation = value
            }
    }
}

struct Cancellable_Previews: PreviewProvider {
    static var previews: some View {
        Cancellable()
    }
}
