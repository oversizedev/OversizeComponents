//
// Copyright © 2023 Alexander Romanov
// MapPreviewView.swift
//

import MapKit
import OversizeCore
import OversizeUI
import SwiftUI

public struct MapPreviewView: View {
    let location: CLLocationCoordinate2D
    let annotation: String?
    private let action: (() -> Void)?

    public init(location: CLLocationCoordinate2D, annotation: String? = nil, action: (() -> Void)? = nil) {
        self.location = location
        self.annotation = annotation
        self.action = action
    }

    public var body: some View {
        Surface {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            let annotations = [MapPreviewPoint(name: annotation.valueOrEmpty, coordinate: location)]

            Map(coordinateRegion: .constant(region), interactionModes: .zoom, annotationItems: annotations) {
                MapMarker(coordinate: $0.coordinate)
            }

            .onTapGesture {
                if action == nil {
                    #if !os(tvOS)
                        let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
                        let mapItem = MKMapItem(placemark: placemark)
                        mapItem.name = annotation
                        mapItem.openInMaps()
                    #endif
                } else {
                    action?()
                }
            }
        }
        .surfaceContentMargins(.zero)
    }
}

public struct MapPreviewPoint: Identifiable {
    public let id: UUID
    public let name: String
    public let coordinate: CLLocationCoordinate2D

    public init(id: UUID = UUID(), name: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
    }
}
