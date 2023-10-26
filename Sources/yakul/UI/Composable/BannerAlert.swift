import SwiftUI

/// Alert that styled as a banner.
public struct BannerAlert: View {
    
    // MARK: - Init
    
    @Binding var text: String?
    let style: BannerAlertStyle
    
    /// Initializes `BannerAlert`.
    ///
    /// - Parameters:
    ///   - text: The text that will populate this alert.
    ///   - style: The style which this alert will conform to.
    public init(
        _ text: Binding<String?>,
        style: BannerAlertStyle = .critical
    ) {
        _text = text
        self.style = style
    }
    
    // MARK: - Body
    
    public var body: some View {
        if let text {
            HStack(spacing: 16) {
                Image(systemName: systemImageName)
                    .font(.title3)
                Text(text)
                Spacer()
            }
            .multilineTextAlignment(.leading)
            .padding(24)
            .overlay(alignment: .topTrailing) {
                Button {
                    self.text = nil
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(.plain)
                .accessibilityLabel(
                    Text(
                        "Dismiss",
                        comment: "Button to dismiss a message"
                    )
                )
                .padding()
            }
            .font(.subheadline)
            .foregroundColor(.primary)
            .background(backgroundColor.opacity(0.3))
            .cornerRadius(8)
        }
    }
    
    // MARK: - Helpers
    
    /// A system image name corresponding to an `SF Symbols` asset.
    private var systemImageName: String {
        switch style {
        case .critical: return "exclamationmark.triangle"
        case .success: return "checkmark.circle"
        case .passive: return "info.circle"
        }
    }

    /// The background color for this view.
    private var backgroundColor: Color {
        switch style {
        case .critical: return .red
        case .success: return .green
        case .passive: return .gray
        }
    }
}


/// Defines various styles that banner alerts can have.
public enum BannerAlertStyle: CaseIterable {
    
    /// For time sensitive alerts, indicates something that the user should take immediate action on.
    case critical

    /// For positive alerts, and indicating a success.
    case success

    /// For alerts that the user should know about, but with a lower priority.
    case passive
}

#Preview {
    return BannerAlertPreview()
    
    /// Required to make preview interactive.
    struct BannerAlertPreview: View {
        @State var criticalAlertMessage: String?
        @State var successAlertMessage: String?
        @State var passiveAlertMessage: String?
        
        var body: some View {
            VStack {
                BannerAlert($criticalAlertMessage)
                
                Button("Critical Alert") {
                    criticalAlertMessage = "You have a critical alert!"
                }
                
                BannerAlert($successAlertMessage, style: .success)
                
                Button("Success Alert") {
                    successAlertMessage = "You have won your game!"
                }
                
                BannerAlert($passiveAlertMessage, style: .passive)
                
                Button("Critical Alert") {
                    passiveAlertMessage = "Your password will reset in 30 days."
                }
            }
            .padding()
        }
    }
}
