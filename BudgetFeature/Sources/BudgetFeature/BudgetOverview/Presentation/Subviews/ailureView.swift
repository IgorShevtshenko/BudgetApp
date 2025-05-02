import SwiftUI

struct FailureView: View {
    
    private let error: String
    private let tryAgain: () -> Void
    
    init(error: String, tryAgain: @escaping () -> Void) {
        self.error = error
        self.tryAgain = tryAgain
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(error)
                .font(.title)
            
            Button("Please try again", action: tryAgain)
                .buttonStyle(.borderedProminent)
        }
        
    }
}

#Preview {
    FailureView(error: "Something went wrong") {}
}
