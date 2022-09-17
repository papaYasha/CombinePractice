import SwiftUI
import Combine


class MultipleCancellingViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var firstNameValidation: String = ""
    @Published var lastName: String = ""
    @Published var lastNameValidation: String = ""

    private var validationCancellables: Set<AnyCancellable> = []

    init() {

        $firstName
            .map { $0.isEmpty ? "❌" : "✅" }
            .sink { [unowned self] value in
                self.firstNameValidation = value
            }
            .store(in: &validationCancellables)

        $lastName
            .map { $0.isEmpty ? "❌" : "✅" }
            .sink { [unowned self] value in
                self.lastNameValidation = value
            }
            .store(in: &validationCancellables)
    }
}

struct MultipleCancelling: View {

    @StateObject var viewModel = MultipleCancellingViewModel()

    var body: some View {
        VStack {

            HStack(spacing: 20) {
                TextField("firstName", text: $viewModel.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(viewModel.firstNameValidation)
            }
            .padding(40)

            HStack(spacing: 20) {
                TextField("last name", text: $viewModel.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(viewModel.lastNameValidation)
            }
            .padding(40)
        }
        .padding()
    }
}

struct MultipleCancelling_Previews: PreviewProvider {
    static var previews: some View {
        MultipleCancelling()
    }
}
