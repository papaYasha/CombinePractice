import SwiftUI
import Combine

class CurrentValueSubjectEx1ViewModel: ObservableObject {

    @Published var selection = "No name selected"
    var selectionSame = CurrentValueSubject<Bool, Never>(false)
    var cancellables: [AnyCancellable] = []

    init() {
        $selection
            .map { [unowned self] newValue -> Bool in
                if newValue == selection {
                    return true
                } else {
                    return false
                }
            }
            .sink { [unowned self] value in
                selectionSame.value = value
                objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}

struct CurrentValueSubjectEx1: View {

    @StateObject private var viewModel = CurrentValueSubjectEx1ViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Button("Select Lorenzo") {
                viewModel.selection = "Lorenzo"
            }

            Button("Sellect Ellen") {
                viewModel.selection = "Ellen"
            }

            Text(viewModel.selection)
                .foregroundColor(viewModel.selectionSame.value ? .red : .green)
        }
        .font(.title)
    }
}

struct CurrentValueSubjectEx1_Previews: PreviewProvider {
    static var previews: some View {
        CurrentValueSubjectEx1()
    }
}
