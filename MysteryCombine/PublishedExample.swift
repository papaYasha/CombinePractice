import SwiftUI
import Combine


class PublishedViewModel: ObservableObject {
    @Published var state = "1. Beggin state"

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.state = "2. Second state"
        }
    }
}

struct PublishedExample: View {

    @StateObject var viewModel = PublishedViewModel()

    var body: some View {
        VStack(spacing: 50) {
            TextField("state", text: $viewModel.state)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text(viewModel.state)
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

struct PublishedExample_Previews: PreviewProvider {
    static var previews: some View {
        PublishedExample()
    }
}
