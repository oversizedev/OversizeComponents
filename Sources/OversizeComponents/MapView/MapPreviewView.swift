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

    public init(location: CLLocationCoordinate2D, annotation: String? = nil) {
        self.location = location
        self.annotation = annotation
    }

    public var body: some View {
        Surface {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            let annotations = [MapPoint(name: annotation.valueOrEmpty, coordinate: location)]

            Map(coordinateRegion: .constant(region), annotationItems: annotations) {
                MapMarker(coordinate: $0.coordinate)
            }
            .onTapGesture {
                let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = annotation
                mapItem.openInMaps()
            }
        }
        .surfaceContentInsets(.zero)
    }
}
