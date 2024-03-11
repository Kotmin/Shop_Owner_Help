//
//  Home.swift
//  CoreDataRecap
//
//  Created by Paweł Jan Tłusty on 07/03/2024.
//

import SwiftUI
import CoreData

struct Home: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryName, ascending: true)], animation: .default) private var categories: FetchedResults<Category>
    @State var selectedCategory = ""
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>
    
    
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
                .padding(.horizontal,30)
                .padding(.vertical,15)
                
                ScrollView(.horizontal, showsIndicators:false){
                    HStack{
                        ForEach(products) {
                            item in ProductCardView(product: item)
                        }
                    }
                }
                
                
            }
        }
    }
    
    
    
}
    
    
    #Preview {
        Home()
    }



struct ProductCardView: View {
    var product: Product 
    var body: some View {
        ZStack{
            Image(product.image ?? "placeholder image")
                .resizable()
//                .scaledToFill()
                .scaledToFit()
                .padding(.trailing,-200)
            VStack(alignment: .leading, content: {
                Text(product.name ?? "Starring")
                    .font(.system(size:36,weight: .semibold))
//                    .frame(width: 150) //reconsider this to wrap names
                
                Text(product.categories?.categoryName ?? "Nasz wybór")
                    .font(.callout)
                    .padding()
                    .background(.white.opacity(0.5))
                    .clipShape(Capsule())
                
                Spacer()
                
                HStack{
                    
                    Text("\(product.price) PLN")
                        .font(.system(size: 24,weight: .semibold))
                    
                    Spacer()
                    
                    Button{
                        
                    } label: {
                        Image(Image(systemName: "basket")
                            .imageScale(.large)
                            .frame(width: 90, height: 69)
                            .background(.black)
                            .clipShape(Capsule())
                            .foregroundColor(.white) as! ImageResource
                    )}
                    
                }
                .padding(.leading)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white.opacity(0.5))
                .clipShape(Capsule())
                
                
            })
        }
        .padding(30)
        .frame(width: 336,height: 422)
        .background(Color.pink.opacity(0.2))
        .clipShape(.rect(cornerRadius:57))
        .padding(.leading, 20)
    }
}
