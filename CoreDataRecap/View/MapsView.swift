//
//  MapsView.swift
//  Shop_Owner_App
//
//  Created by Paweł Jan Tłusty on 12/03/2024.
//

import SwiftUI
import MapKit

struct MapsView: View {
    // Map
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var mapSelection: MKMapItem?
    // 16:15
    @State private var viewingRegion: MKCoordinateRegion?
    
    // Searching
    @State private var searchResults: [MKMapItem] = []
    
    // Route navigation
    
    @State private var routeDisplaying: Bool = false
    @State private var route: MKRoute?
    
    var body: some View {
        Map(position: $cameraPosition,selection: $mapSelection){
//            Marker("My location",systemImage: "paperplane", coordinate: .userLocation)
            
            Annotation("Pentagon Pollub", coordinate: .userLocation){
                
                ZStack{
                    Image(systemName: "cat")
                        .font(.title3)
                        .foregroundColor(Color.brown)
                    
                    Image(systemName: "square")
                        .font(.largeTitle)
                }
                
//                ForEach(searchResults, id: \.self){
//                    mapItem in let placemark = mapItem.placemark
//                    Marker(placemark.name ?? "Place",coordinate: placemark.coordinate).tint(.blue)
//                }
                
                
            }
        }
        .mapControls {
                    MapPitchToggle()
                    MapCompass()
                    MapUserLocationButton()
                }
    }
    
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Cafe Heca Lublin"
        request.region = .userRegion // viewingRegion ?? .userRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        searchResults = results?.mapItems ?? []
    }
    
    func fetchRoute() {
        if let mapSelection {
            let request = MKDirections.Request()
            request.source = .init(placemark: .init(coordinate: .userLocation))
            request.destination = mapSelection
            
            Task {
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                
                withAnimation(.snappy) {
                    routeDisplaying = true
                }
            }
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
