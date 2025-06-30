//
// Copyright © 2022 Alexander Romanov
// MapViewDeprecated.swift
//

import CoreLocation
import Foundation
import MapKit
import SwiftUI

#if os(iOS)
@available(*, deprecated, renamed: "MapViewDeprecated")
public typealias MapViewDepecated = MapViewDeprecated

public struct MapViewDeprecated: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D

    let mapView: MKMapView = .init()

    public init(centerCoordinate: Binding<CLLocationCoordinate2D>) {
        _centerCoordinate = centerCoordinate
    }

    public func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator

        // mapView.centerCoordinate = centerCoordinate
        let center: CLLocationCoordinate2D = .init(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)

        let span: MKCoordinateSpan = .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region: MKCoordinateRegion = .init(center: center, span: span)
        mapView.setRegion(region, animated: true)

        return mapView
    }

    public func updateUIView(_: MKMapView, context _: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
        var parent: MapViewDeprecated

        var gRecognizer = UITapGestureRecognizer()

        init(_ parent: MapViewDeprecated) {
            self.parent = parent
            super.init()
            gRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
            gRecognizer.delegate = self
            self.parent.mapView.addGestureRecognizer(gRecognizer)
        }

        @objc func tapHandler(_: UITapGestureRecognizer) {
            let location = gRecognizer.location(in: parent.mapView)

            let coordinate = parent.mapView.convert(location, toCoordinateFrom: parent.mapView)

            withAnimation {
                let clObject: CLLocationCoordinate2D = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                parent.centerCoordinate = clObject

                let annotation: MKPointAnnotation = .init()
                annotation.coordinate = clObject

                withAnimation {
                    parent.mapView.removeAnnotations(parent.mapView.annotations)
                    parent.mapView.addAnnotation(annotation)
                }
            }
        }
    }
}
#endif
