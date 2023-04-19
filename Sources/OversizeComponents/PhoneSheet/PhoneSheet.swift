//
// Copyright © 2023 Alexander Romanov
// PhoneSheet.swift
//

import OversizeUI
import SwiftUI

public struct PhoneSheetNumber: Hashable {
    public let name: String?
    public let phone: String

    public init(name: String?, phone: String) {
        self.name = name
        self.phone = phone
    }
}

public struct PhoneSheet: View {
    private let numbers: [PhoneSheetNumber]
    private let title: String

    public init(_ title: String, numbers: [PhoneSheetNumber]) {
        self.numbers = numbers
        self.title = title
    }

    public var body: some View {
        PageView(title) {
            SectionView {
                VStack(spacing: .zero) {
                    ForEach(numbers, id: \.self) { number in
                        if let numberURL = URL(string: "tel:\(number.phone)") {
                            Link(destination: numberURL) {
                                Row(number.phone, subtitle: number.name)
                                    .multilineTextAlignment(.leading)
                            }
                            .buttonStyle(.row)
                        }
                    }
                }
            }
            .surfaceContentRowInsets()
        }
        .backgroundSecondary()
        .leadingBar {
            BarButton(.close)
        }
    }
}

struct PhoneSheet_Previews: PreviewProvider {
    static var previews: some View {
        PhoneSheet("Phones", numbers: [
            PhoneSheetNumber(name: "Mobile", phone: "+1 (342) 345 45 42"),
            PhoneSheetNumber(name: "Home", phone: "+1 (435) 234 34 23"),
        ])
    }
}
