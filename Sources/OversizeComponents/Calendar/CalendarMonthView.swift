//
// Copyright © 2022 Alexander Romanov
// CalendarMonthView.swift
//

import SwiftUI
import OversizeUI
import OversizeCore

public struct CalendarMonthView<DateView>: View where DateView: View {
    @Environment(\.sizeCategory) private var contentSize
    @Environment(\.calendar) private var calendar
    @Binding var selectedMonth: Date
    @State private var months: [Date] = []
    @State private var days: [Date: [Date]] = [:]
    
    private let interval: DateInterval
    private let showHeaders: Bool
    private let onHeaderAppear: (Date) -> Void
    private let content: (Date) -> DateView
    
    private var columns: [GridItem] {
        let spacing: CGFloat = contentSize.isAccessibilityCategory ? 2 : 8
        return Array(repeating: GridItem(spacing: spacing), count: 7)
    }
    
    public init(
        interval: DateInterval,
        showHeaders: Bool = false,
        selectedMonth: Binding<Date>,
        onHeaderAppear: @escaping (Date) -> Void,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self.showHeaders = showHeaders
        self._selectedMonth = selectedMonth
        self.onHeaderAppear = onHeaderAppear
        self.content = content
    }

    public var body: some View {
        TabView(selection: $selectedMonth) {
            ForEach(months, id: \.self) { month in

                LazyVGrid(columns: columns) {
                    Section(header: header(for: month)) {
                        ForEach(days[month, default: []], id: \.self) { date in
                            if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                content(date).id(date)
                            } else {
                                content(date)
                                    .disabled(true)
                                    .opacity(0.2)
                            }
                        }
                    }
                    .onAppear { onHeaderAppear(month) }
                }
                .tag(month)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        .onAppear {
            months = calendar.generateDates(
                inside: interval,
                matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
            )

            days = months.reduce(into: [:]) { current, month in
                guard
                    let monthInterval = calendar.dateInterval(of: .month, for: month),
                    let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
                    let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end),
                    let nextMonthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end.weekAfter)
                else { return }

                let daysInCalendar = Calendar.current.numberOfDaysBetween(monthFirstWeek.start, and: monthLastWeek.end)

                current[month] = calendar.generateDates(
                    inside: DateInterval(start: monthFirstWeek.start, end: daysInCalendar < 42 ? nextMonthFirstWeek.end : monthLastWeek.end),
                    matching: DateComponents(hour: 0, minute: 0, second: 0)
                )
            }
        }
    }

    private func header(for month: Date) -> some View {
        Group {
            if showHeaders {
                Text(DateFormatter.monthAndYear.string(from: month))
                    .font(.title)
                    .padding()
            }
        }
    }
}

