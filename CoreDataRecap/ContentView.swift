//
//  ContentView.swift
//  CoreDataRecap
//
//  Created by Paweł Jan Tłusty on 06/03/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var selectedTab = "Home"
    


//    var body: some View {
////        OwnerPanel()
////        Home()
//    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
//            OwnerPanel()
//                .tabItem {
//                    Label("Settings", systemImage: "gear")
//                }
//                .tag("Settings")
            
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag("Home")
            
            MapsView() // Assuming this is a placeholder for your navigation view
                .tabItem {
                    Label("Navigation", systemImage: "map")
                }
                .tag("Navigation")
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        .cornerRadius(30)
        
    }
     
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}



