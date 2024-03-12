//
//  OwnerPanel.swift
//  Shop_Owner_App
//
//  Created by Paweł Jan Tłusty on 11/03/2024.
//

import SwiftUI
import CoreData

struct OwnerPanel: View {
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.78
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            
      
        ZStack{
            Color.green.opacity(0.4).ignoresSafeArea()
            VStack{
                Text("Owner Panel").font(.headline).fontWeight(.semibold)
                    .padding(9)
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(10)
                
                
                ProductListView()
                Spacer()
            }
            CategoryControlView()

                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()){
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()){
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                }
                                else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        }
            )
            
        }.ignoresSafeArea(edges:.bottom)
        
        }
    }
}

#Preview {
    OwnerPanel()
}



struct ProductListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>
    
    @State private var showingAddProduct = false

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(products) { product in
                    ProductView(product: product)
                }
            }
        }
        .sheet(isPresented: $showingAddProduct) {
            AddProductView(isPresented: $showingAddProduct)
        }
        .navigationBarItems(trailing: Button(action: {
            showingAddProduct = true
        }) {
            Text("Add Product")
        })
    }
}


struct ProductView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading) {
            Image(product.image ?? "placeholder_image")
                .resizable()
                .scaledToFill()
                .frame(width: 175, height: 150)
                .clipped() // This will clip the overflow of the image
                .overlay(
                    HStack {
                        Text(product.categories?.categoryName ?? "Category")
                            .font(.caption)
                            .padding(5)
                            .background(Color.blue) // Set your desired background color
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                        Spacer()
                    }
                    .padding([.top, .leading]), alignment: .topLeading
                )

            Text(" \(product.name ?? "Unnamed Product")")
                .bold()
            Text("$\(product.price, specifier: "%.2f")")
                .foregroundColor(.secondary).padding(.leading)
        }
        .padding()
        .frame(width: 175, height: 200)
        .background(Color.white)
        .cornerRadius(15)
        // handle gestures for update and delete
    }
}


struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isPresented: Bool
    @FetchRequest(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryName, ascending: true)]) private var categories: FetchedResults<Category>
    @State private var selectedCategory: Category?
    @State private var productName: String = ""
    @State private var productPriceText: String = ""
    @State private var productImage: String = ""
    @State private var isPriceValid: Bool = true

    var body: some View {
        NavigationStack {
            Form {
                TextField("Product Name", text: $productName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                TextField("Product Price", text: $productPriceText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .background(isPriceValid ? Color.clear : Color.red.opacity(0.3))
                    .onChange(of: productPriceText) { newValue in
                        isPriceValid = Double(newValue) != nil
                    }

                if !isPriceValid {
                    Text("Please enter a valid price")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                TextField("Product Image", text: $productImage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)

                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories) { category in
                        Text(category.categoryName ?? "Unknown").tag(category as Category?)
                    }
                }

                Button("Save") {
                    guard let price = Double(productPriceText), price >= 0 else {
                        isPriceValid = false
                        return
                    }
                    
                    let newProduct = Product(context: viewContext)
                    newProduct.name = productName
                    newProduct.price = price
                    newProduct.image = productImage
                    newProduct.categories = selectedCategory

                    do {
                        try viewContext.save()
                        isPresented = false
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .navigationTitle("Add Product")
            .navigationBarItems(leading: Button("Dismiss") {
                isPresented = false
            })
        }
    }
}

extension NSManagedObjectContext {
    func fetchAllCategories() -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            return try fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
