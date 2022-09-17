import SwiftUI
import Combine


class PublishedValidationViewModel: ObservableObject {

    @Published var name = ""
}

struct PublishedValidation: View {

    @StateObject private var viewModel = PublishedValidationViewModel()
    @State private var message = ""

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                TextField("name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: viewModel.name) { newValue in
                        message = newValue.isEmpty ? "❌" : "✅"
                    }
                Text(message)
                    .font(.title)
            }
        }
    }
}

struct PublishedValidation_Previews: PreviewProvider {
    static var previews: some View {
        PublishedValidation()
    }
}
