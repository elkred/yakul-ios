import SwiftUI

public struct NoticeCard: View {
    
    // MARK: - Init

    private let header: String
    private let systemIconName: String?
    private let headline: String
    private let subheadline: String
    private let footnote: String?
    private let canHide: Bool
    
    public init(
        header: String = "Example Header",
        systemIconName: String? = nil,
        headline: String = "Example Headline",
        subheadline: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        footnote: String? = "Note: This is a sample notice card.",
        canHide: Bool = true
    ) {
        self.header = header
        self.systemIconName = systemIconName
        self.headline = headline
        self.subheadline = subheadline
        self.footnote = footnote
        self.canHide = canHide
    }

    // MARK: - Body
    
    public var body: some View {
        SectionedCard(header: header, canHide: canHide) {
            HStack(alignment: .top) {
                if let systemIconName {
                    VStack(spacing: 16) {
                        Image(systemName: systemIconName)
                            .font(.title)
                            .foregroundColor(.pink)
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(headline)
                        .font(.headline)
                    
                    Text(subheadline)
                        .font(.subheadline)
                    
                    if let footnote {
                        Text(footnote)
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    NoticeCard()
    NoticeCard()
    NoticeCard()
}
