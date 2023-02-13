//
// Copyright © 2023 Alexander Romanov
// RatingPickerView.swift
//

import OversizeCore
import OversizeResources
import OversizeUI
import SwiftUI

public struct RatingPickerView: View {
    @Binding private var rating: Double?

    private var maxScore: Int

    public init(rating: Binding<Double?>, maxScore: Int) {
        _rating = rating
        self.maxScore = maxScore
    }

    public var body: some View {
        Surface {
            HStack {
                ForEach(1 ... maxScore, id: \.self) { score in
                    Button {
                        rating = Double(score)
                    } label: {
                        HStack {
                            Spacer()

                            Icon.Solid.UserInterface.star
                                .renderingMode(.template)
                                .foregroundColor(rating ?? 0 >= Double(score) ? .warning : .onSurfaceDisabled)

                            Spacer()
                        }
                    }
                    .buttonStyle(.scale)
                }
            }
        }
        .surfaceBackgroundColor(.surfaceSecondary)
        .surfaceContentInsets(.medium)
    }
}

// struct RatingPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingPickerView()
//    }
// }
