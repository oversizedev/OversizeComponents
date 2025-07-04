//
// Copyright © 2022 Alexander Romanov
// LocationPicker.swift
//

import CoreLocation
import MapKit
import OversizeUI
import SwiftUI

#if os(iOS)
public struct LocationPicker: View {
    @Environment(\.theme) private var theme: ThemeSettings

    @Binding private var coordinates: CLLocationCoordinate2D
    @Binding private var positionName: String?
    private let label: String

    private let saveButtonText: String?
    @State private var offset = CGPoint(x: 0, y: 0)
    @State private var showModal = false
    @State private var isSelected = false

    public init(label: String, coordinates: Binding<CLLocationCoordinate2D>, positionName: Binding<String?>, saveButtonText: String? = nil) {
        self.label = label
        self.saveButtonText = saveButtonText
        _coordinates = coordinates
        _positionName = positionName
    }

    public var body: some View {
        Button {
            showModal.toggle()
        } label: {
            HStack(spacing: .xxSmall) {
                Text(label)
                    .bold()
                    .headline()
                    .foregroundColor(.onSurfacePrimary)
            }
            Spacer()

            if let positionName {
                Text(positionName)
                    .subheadline()
                    .foregroundColor(.onPrimarySecondary)
            }

            IconDeprecated(.chevronDown, color: .onSurfacePrimary)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(
                cornerRadius: Radius.medium,
                style: .continuous,
            )
            .fill(Color.surfaceSecondary)
            .overlay(
                RoundedRectangle(
                    cornerRadius: Radius.medium,
                    style: .continuous,
                )
                .stroke(
                    theme.borderTextFields
                        ? Color.border
                        : Color.surfaceSecondary,
                    lineWidth: CGFloat(theme.borderSize),
                ),
            ),
        )
        .sheet(isPresented: $showModal) {
            modal
        }
        .onChange(of: coordinates) {
            updateLocationName(coordinate: $0)
        }
    }

    public var modal: some View {
        ZStack {
            MapViewDeprecated(centerCoordinate: $coordinates)
                .ignoresSafeArea()

            VStack {
                Spacer()

                MaterialSurface {
                    VStack(alignment: .center, spacing: .xxSmall) {
                        if let positionName {
                            Text(positionName)
                                .title3()
                                .foregroundColor(.onSurfacePrimary)
                        }
                        Text("\(coordinates.latitude), \(coordinates.longitude)")
                            .subheadline()
                            .foregroundColor(.onSurfaceSecondary)
                    }
                }
                .surfaceContentMargins(.small)
                .controlRadius(.large)
                .multilineTextAlignment(.center)

            }.padding()
        }
        .navigationBar(label, style: .fixed($offset)) {
            BarButton(.close)
        } trailingBar: {
            BarButton(.secondary(saveButtonText ?? "Save", action: {
                isSelected = true
                showModal.toggle()
            }))
        }
    }

    private func updateLocationName(coordinate: CLLocationCoordinate2D) {
        let loc = CLLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
        )

        let geocoder: CLGeocoder = .init()

        geocoder.reverseGeocodeLocation(loc) { placemarks, error in
            if error != nil { return }
            if let firstLocation = placemarks?.first as? CLPlacemark {
                Task { @MainActor in
                    if let locality = firstLocation.locality {
                        positionName = locality
                    } else if let subLocality = firstLocation.subLocality {
                        positionName = subLocality
                    } else {
                        positionName = firstLocation.name
                    }
                }
            }
        }
    }
    
    // MARK: - Deprecated method wrapper
    
    @available(*, deprecated, renamed: "updateLocationName")
    private func updateCityName(coordinate: CLLocationCoordinate2D) {
        updateLocationName(coordinate: coordinate)
    }
}

extension CLLocationCoordinate2D: @retroactive Equatable {}

public func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}
#endif
