//
//  SectionedCard.swift
//  yakul
//
//  Created by Galen Quinn on 2/11/25.
//

import SwiftUI

public struct SectionedCard<CardContent: View>: View {
    
    // MARK: - Init

    private let header: String
    private let canHide: Bool
    private let content: CardContent
    
    public init(
        header: String = "Example Header",
        canHide: Bool = true,
        @ViewBuilder content: () -> CardContent
    ) {
        self.header = header
        self.content = content()
        self.canHide = canHide
    }
    
    // MARK: - Private State
    
    @State private var isHidden = false
    
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
                
                content
            }
            .background(.thinMaterial)
            .cornerRadius(16)
        }
    }
}

#Preview {
    SectionedCard(header: "Sectioned Card") {
        VStack(alignment: .leading) {
            Text("Lorem ipsum dolor sit amet")
            Text("Consectetur adipiscing elit")
            Text("Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
        }
        .padding()
    }
}
