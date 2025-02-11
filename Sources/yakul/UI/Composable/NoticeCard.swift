//
//  NoticeCard.swift
//  yakul
//
//  Created by Galen Quinn on 2/7/25.
//

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
    
    // MARK: - Private State
    
    @State private var isHidden = false
    
    // MARK: - Body
    
    public var body: some View {
        if !isHidden {
            VStack(alignment: .leading, spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Text(header)
                        
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
                    .bold()
                    .textCase(.uppercase)
                    .padding()
                    
                    Divider()
                }
                
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
            .background(.thinMaterial)
            .cornerRadius(16)
            .padding()
        }
    }
}

#Preview {
    NoticeCard()
    NoticeCard()
    NoticeCard()
}
