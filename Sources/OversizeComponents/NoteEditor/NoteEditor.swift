//
// Copyright © 2024 Alexander Romanov
// NoteEditor.swift, created on 03.03.2024
//

import OversizeUI
import SwiftUI

#if os(iOS) || os(macOS)
    @available(iOS 16.0, *)
    public struct NoteEditor: View {
        @Environment(\.dismiss) private var dismiss
        @Binding private var text: String
        @FocusState var isFocus: Bool
        private let title: String?

        public init(_ title: String? = nil, text: Binding<String>) {
            self.title = title
            _text = text
        }

        public var body: some View {
            TextEditor(text: $text)
                .focused($isFocus)
                .padding(.leading, .xSmall)
                .padding(.bottom, .xSmall)
                .background(Color.backgroundPrimary)
                .toolbar {
                    if let title {
                        ToolbarItem(placement: .principal) {
                            Text(title)
                                .font(.headline)
                        }
                    }

                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Image.Base.close.icon()
                        }
                    }
                }
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
                .onAppear {
                    isFocus = true
                }
        }
    }
#endif
