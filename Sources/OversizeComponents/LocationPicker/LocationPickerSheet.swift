//
// Copyright © 2022 Alexander Romanov
// LocationPickerSheet.swift
//

import CoreLocation
import MapKit
import OversizeUI
import SwiftUI

#if os(iOS)
public struct LocationPickerSheet: View {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.dismiss) private var dismiss

    @Binding private var coordinates: CLLocationCoordinate2D
    @Binding private var positionName: String?
    private let label: String

    private let saveButtonText: String?
    @State private var offset = CGPoint(x: 0, y: 0)

    @State private var isClosing = false

    public init(label: String, coordinates: Binding<CLLocationCoordinate2D>, positionName: Binding<String?>, saveButtonText: String? = nil) {
        self.label = label
        self.saveButtonText = saveButtonText
        _coordinates = coordinates
        _positionName = positionName
    }

    public var body: some View {
        ZStack {
            if !isClosing {
                MapViewDeprecated(centerCoordinate: $coordinates)
                    .ignoresSafeArea()
            }

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
            BarButton(.closeAction {
                closeView()
            })
        } trailingBar: {
            BarButton(.secondary(saveButtonText ?? "Save", action: {
                closeView()
            }))
        }
        .onChange(of: coordinates) {
            updateLocationName(coordinate: $0)
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

    func closeView() {
        isClosing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            dismiss()
        }
    }
}
#endif
