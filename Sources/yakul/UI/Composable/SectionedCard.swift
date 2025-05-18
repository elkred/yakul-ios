import SwiftUI

public struct SectionedCard<CardContent: View>: View {
    
    // MARK: - Init

    private let header: String
    private let headerSystemIconName: String?
    private let canHide: Bool
    private let content: CardContent
    
    public init(
        header: String = "Example Header",
        headerSystemIconName: String? = nil,
        canHide: Bool = true,
        @ViewBuilder content: () -> CardContent
    ) {
        self.header = header
        self.headerSystemIconName = headerSystemIconName
        self.canHide = canHide
        self.content = content()
    }
    
    // MARK: - Private State
    
    @State private var isHidden = false
    
    public var body: some View {
        if !isHidden {
            VStack(alignment: .leading, spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        if let headerSystemIconName = headerSystemIconName {
                            Image(systemName: headerSystemIconName)
                        }
                        
                        Text(header)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        if canHide {
                            Button("Close", systemImage: "xmark") {
                                withAnimation { isHidden = true }
                            }
                            .labelStyle(.iconOnly)
                        }
                    }
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                    .textCase(.uppercase)
                    .padding()
                    
                    Divider()
                }

                content
            }
            .background(.thinMaterial)
            .cornerRadius(16)
        }
    }
}

#Preview {
    SectionedCard(
        header: "Sectioned Card",
        headerSystemIconName: "circle.fill"
    ) {
        VStack(alignment: .leading) {
            Text("Lorem ipsum dolor sit amet")
            Text("Consectetur adipiscing elit")
            Text("Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
        }
        .padding()
    }
}
