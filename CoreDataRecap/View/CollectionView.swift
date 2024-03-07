//
//  CollectionView.swift
//  CoreDataRecap
//
//  Created by Paweł Jan Tłusty on 07/03/2024.
//

import SwiftUI

struct CollectionView: View {
    var body: some View {
        NavigationView{
            
        ScrollView{
            VStack {
                HStack{
                    Text("Zamów w najlepszej **kawiarni**").font(.system(size: 30)).padding(.trailing)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.left").imageScale(.large).padding().frame(width: 70,height: 90).overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                }.padding(30)
            }
        }
        }
    }
}

#Preview {
    CollectionView()
}
