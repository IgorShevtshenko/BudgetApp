import SwiftUI

extension View {
    
    func primaryBackground(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.clear)
                    .stroke(
                        Color(
                            red: 0.89,
                            green: 0.89,
                            blue: 0.9
                        ),
                        style: .init(lineWidth: 1)
                    )
            }
    }
}

#Preview {
    Text("Placeholder")
        .primaryBackground()
}
