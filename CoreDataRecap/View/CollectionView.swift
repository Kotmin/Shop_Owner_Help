//
//  CollectionView.swift
//  ShopOwnerApp
//
//  Created by Paweł Jan Tłusty on 07/03/2024.
//

import SwiftUI

struct CollectionView: View {
    
    @Environment(\.presentationMode) var mode
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var appState: AppState
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>
    
    
    var body: some View {
        NavigationStack{
            
        
                VStack {
                    HStack{
                        Text("Zamów w najlepszej **kawiarni**").font(.system(size: 30)).padding(.trailing)
                        
                        Spacer()
                        
                        Button(action: {
                            dismiss() // Dismiss the current view
//                            appState.selectedTab = .home
                            
                        }){
                            Image(systemName: "arrow.left")
                        }
                        .imageScale(.large)
                        .padding()
                        .foregroundColor(.black)
                        .frame(width: 70,height: 90).overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                    }.padding(30)
                    
                    ScrollView{
                    VStack {
                        
                        
                        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                            ForEach(products){
                                item in SmallProductCard(product: item)
                            }
                        }
                        
                    }
                }
        }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CollectionView()
}



struct SmallProductCard: View {
    var product: Product

    var body: some View {
        ZStack{
            Image(product.image ?? "placeholder image")
                .resizable()
                .scaledToFit()
                .scaleEffect(2.5)
            ZStack{
                VStack(alignment: .leading) {
                    Text(" \(product.name ?? "Starring") ")
                        .font(.system(size:18,weight: .semibold))
                        .foregroundColor(.white)
                        .background(.black.opacity(0.8))
                        .clipShape(Capsule())
                    
                    
                    Text(product.categories?.categoryName ?? "Nasz wybór")
                        .font(.system(size: 8))
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.8))
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    HStack{
                        
                        Text(String(format: "%.2f PLN", product.price))
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 60, height: 69)
                            
                        
                        
                        Spacer()
                        
                        Button {} label: {
                            Image(systemName: "basket")
                                .imageScale(.large)
                                .frame(width: 45, height: 40)
                                .background(.black)
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(.white.opacity(0.75))
                    .clipShape(Capsule())
                }
            }
            .padding(20)
            .frame(width: 170,height: 215)
        }
        .frame(width: 170,height: 215)
        .clipShape(.rect(cornerRadius: 30))
        .padding(.leading,10)
        
    }
}
