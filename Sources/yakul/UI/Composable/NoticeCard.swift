//
//  NoticeCard.swift
//  yakul
//
//  Created by Galen Quinn on 2/7/25.
//

import SwiftUI

public struct NoticeCard: View {
    
    private let header: String
    private let headline: String
    private let subheadline: String
    private let footnote: String?
    
    public init(
        header: String = "Example Header",
        headline: String = "Example Headline",
        subheadline: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        footnote: String? = "Note: This is a sample notice card.",
        canHide: Bool = true
    ) {
        self.header = header
        self.headline = headline
        self.subheadline = subheadline
        self.footnote = footnote
        self.canHide = canHide
    }
    
    var canHide = false
    
    @State private var isHidden = false
    
    public var body: some View {
        if !isHidden {
            VStack(alignment: .leading, spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Text("Check-In Completed")
                        
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
                    VStack(spacing: 16) {
                        Image(systemName: "heart.circle.fill")
                            .font(.title)
                            .foregroundColor(.pink)
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
