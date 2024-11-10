//
// Copyright © 2023 Alexander Romanov
// RatingPickerView.swift
//

import OversizeCore
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

                            Image.Base.Star.fill
                                .renderingMode(.template)
                                .foregroundColor(rating ?? 0 >= Double(score) ? .warning : .onSurfaceTertiary)

                            Spacer()
                        }
                    }
                    .buttonStyle(.scale)
                }
            }
        }
        .surfaceBackgroundColor(.surfaceSecondary)
        .surfaceContentMargins(.medium)
    }
}

// struct RatingPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingPickerView()
//    }
// }
