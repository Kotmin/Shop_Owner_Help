//
//  ContentView.swift
//  ShopOwnerApp
//
//  Created by Paweł Jan Tłusty on 06/03/2024.
//

import SwiftUI
import CoreData

class AppState: ObservableObject {
    @Published var selectedTab: Tab = .home
}

enum Tab {
    case home, maps, settings
}

struct ContentView: View {
    
    @State private var selectedTab = "Home"
    @EnvironmentObject var appState: AppState
    



    
    var body: some View {
        NavigationStack{
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
                    .tag(Tab.home)
                
                MapsView()
                    .tabItem {
                        Label("Navigation", systemImage: "map")
                    }
                    .tag(Tab.maps)
                
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .cornerRadius(30)
        }
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



