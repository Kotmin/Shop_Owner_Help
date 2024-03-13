//
//  MapsView.swift
//  Shop_Owner_App
//
//  Created by Paweł Jan Tłusty on 12/03/2024.
//

import SwiftUI
import MapKit

struct MapsView: View {
    
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    var body: some View {
        Map(position: $cameraPosition){
            Marker("My location",systemImage: "paperplane", coordinate: .userLocation)
        }
        .mapControls {
                    MapPitchToggle()
                    MapCompass()
                    MapUserLocationButton()
                }
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 51.235388, longitude: 22.553094)
    }
}
//51.235388,22.553094 Pentagon lat lon

// 51.247020,22.553271 Cafe Heca lat lon

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation,
        latitudinalMeters: 1000,
        longitudinalMeters: 1000
        )
    }
}



#Preview {
    MapsView()
}
