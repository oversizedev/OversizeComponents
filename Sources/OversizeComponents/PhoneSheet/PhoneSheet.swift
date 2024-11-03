//
// Copyright © 2023 Alexander Romanov
// PhoneSheet.swift, created on 05.03.2023
//

import OversizeUI
import SwiftUI

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
public struct PhoneSheetNumber: Hashable {
    public let name: String?
    public let phone: String

    public init(name: String?, phone: String) {
        self.name = name
        self.phone = phone
    }
}

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
public struct PhoneCallSheet: View {
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
                        if let numberURL = URL(string: "tel:\(number.phone.filter("0123456789.+".contains))") {
                            Link(destination: numberURL) {
                                Row(number.phone, subtitle: number.name)
                                    .multilineTextAlignment(.leading)
                            }
                            .buttonStyle(.row)
                        }
                    }
                }
            }
            .surfaceContentRowMargins()
        }
        .backgroundSecondary()
        .leadingBar {
            BarButton(.close)
        }
    }
}

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
struct PhoneCallSheet_Previews: PreviewProvider {
    static var previews: some View {
        PhoneCallSheet("Phones", numbers: [
            PhoneSheetNumber(name: "Mobile", phone: "+1 (342) 345 45 42"),
            PhoneSheetNumber(name: "Home", phone: "+1 (435) 234 34 23"),
        ])
    }
}
