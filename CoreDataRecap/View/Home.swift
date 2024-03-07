//
//  Home.swift
//  CoreDataRecap
//
//  Created by Paweł Jan Tłusty on 07/03/2024.
//

import SwiftUI

struct Home: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryName, ascending: true)], animation: .default) private var categories: FetchedResults<Category>
    @State var selectedCategory = ""
    
    var body: some View {
        ScrollView{
            VStack {
                HStack{
                    Text("Zamów w najlepszej **kawiarni**").font(.system(size: 30)).padding(.trailing)
                    
                    Spacer()
                    
                    Image(systemName: "line.3.horizontal").imageScale(.large).padding().frame(width: 70,height: 90).overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                }.padding(30)
                
                //  QuickPurchase
                
                HStack{
                    Text("Szybkie **zamówienie**").font(.system(size: 24))
                    
                    
                    Spacer()
                    
                    Image(systemName:"arrow.right").imageScale(.large)
                }
                
                
            }
        }
    }
    
    
    
}
    
    
    #Preview {
        Home()
    }

