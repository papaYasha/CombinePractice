import SwiftUI
import Combine

class LongRunningProcessViewModel: ObservableObject {
    @Published var data = "Start data"
    @Published var status = ""
    private var cancellable: AnyCancellable?

    init() {
        cancellable = $data
            .map { [unowned self] value -> String in
                status = "Processing..."
                return value
            }
            .delay(for: 5, scheduler: RunLoop.main)
            .sink { [unowned self] value in
                status = "Finished"
            }
    }

    func refreshData() {
        data = "Refresh data"
    }

    func cancel() {
        status = "Cancelled"
        cancellable?.cancel()

    }
}


struct LongRunningProcess: View {

    @StateObject var viewModel = LongRunningProcessViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.data)
                .font(.title)
                .padding(30)
            Button("Refresh data") {
                viewModel.refreshData()
            }
            Button("Cancel Sub") {
                viewModel.cancel()
            }
            .opacity(viewModel.status == "Processing..." ? 1 : 0)
            Text(viewModel.status)
        }
    }
}

struct LongRunningProcess_Previews: PreviewProvider {
    static var previews: some View {
        LongRunningProcess()
    }
}
