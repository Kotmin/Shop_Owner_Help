//
//  ContentView.swift
//  CoreDataRecap
//
//  Created by Paweł Jan Tłusty on 06/03/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.83
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0

    var body: some View {
        NavigationView{
            
      
        ZStack{
            Color.green.ignoresSafeArea()
            VStack{
                Text("Owner Panel").font(.headline).fontWeight(.semibold)
                    .padding(9)
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(10)
                
                
                ProductListView()
                Spacer()
            }
            CategoriesControlView()
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

struct CategoriesControlView: View {
    @Environment(\.managedObjectContext) private var viewContext
       @FetchRequest(
           entity: Category.entity(),
           sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryName, ascending: true)],
           animation: .default
       ) private var categories: FetchedResults<Category>

       @State private var showingAddCategoryView = false
       @State private var newCategoryName = ""
       @State private var showingUpdateSheet = false
       @State private var newName = ""
       @State private var categoryToEdit: Category?

       var body: some View {
           VStack(spacing: 20) {
               Image(systemName: "chevron.up").padding(.top)
               Text("Categories").font(.headline).fontWeight(.semibold)
               NavigationView {
                   List {
                       ForEach(categories, id: \.self) { category in
                           Text(category.categoryName ?? "Unknown Category")
                               .onTapGesture {
                                   self.categoryToEdit = category
                                   self.newName = category.categoryName ?? ""
                                   self.showingUpdateSheet = true
                               }
                       }
                       .onDelete(perform: deleteCategories)
                   }
                   .toolbar {
                       Button("Add Categories") {
                           self.showingAddCategoryView = true
                       }
                   }
               }
               Spacer()
           }
           .frame(maxWidth: .infinity)
           .background(Color.white)
           .cornerRadius(30)
           .sheet(isPresented: $showingAddCategoryView) {
               addCategoryView
           }
           .sheet(isPresented: $showingUpdateSheet) {
               updateCategoryView
           }
       }

       private var addCategoryView: some View {
           NavigationView {
               VStack {
                   TextField("New Category Name", text: $newCategoryName)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding()
                   Button("Save") {
                       addCategory(name: newCategoryName)
                       newCategoryName = ""
                       showingAddCategoryView = false
                   }
                   .padding()
               }
               .navigationTitle("Add New Category")
               .toolbar {
                   ToolbarItem(placement: .navigationBarLeading) {
                       Button("Dismiss") {
                           showingAddCategoryView = false
                       }
                   }
               }
           }
       }

       private var updateCategoryView: some View {
           NavigationView {
               VStack {
                   TextField("Update Category Name", text: $newName)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding()
                   Button("Update") {
                       if let category = self.categoryToEdit {
                           updateCategory(category: category, newName: newName)
                       }
                       newName = ""
                       showingUpdateSheet = false
                   }
                   .padding()
               }
               .navigationTitle("Update Category")
               .toolbar {
                   ToolbarItem(placement: .navigationBarLeading) {
                       Button("Cancel") {
                           showingUpdateSheet = false
                       }
                   }
               }
           }
       }
    
    private func addCategory(name: String) {
        withAnimation {
            let newCategory = Category(context: viewContext)
            newCategory.categoryName = name

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

func updateCategory(category: Category, newName: String) {
    category.categoryName = newName // Update the attribute
    do {
        try viewContext.save() // Save the context
    } catch {
        // Handle error
    }
}

private func deleteCategories(offsets: IndexSet) {
    withAnimation {
        offsets.forEach { index in
            let category = categories[index]
            viewContext.delete(category)
        }
        do {
            try viewContext.save()
        } catch {
            // Handle the error appropriately
        }
    }
}
    
    
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
            Image(product.image ?? "placeholder_image") // Replace with your placeholder image name
                .resizable()
                .scaledToFill()
                .frame(width: 175, height: 150) // Set your desired fixed frame size
                .clipped() // This will clip the overflow of the image
//                .cornerRadius(15)
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

            Text(product.name ?? "Unnamed Product")
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

//struct AddProductView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @Binding var isPresented: Bool
//    @FetchRequest(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryName, ascending: true)]) private var categories: FetchedResults<Category>
//    @State private var selectedCategory: Category?
//    @State private var productName: String = ""
//    @State private var productPrice: Double = 0.0
//    @State private var productImage: String = ""
//
//    var body: some View {
//        NavigationView {
//            Form {
//                TextField("Product Name", text: $productName)
//                TextField("Product Price", value: $productPrice, formatter: NumberFormatter())
//                TextField("Product Image", text: $productImage)
//                
//                Picker("Category", selection: $selectedCategory) {
//                    ForEach(categories) { category in
//                        Text(category.categoryName ?? "Unknown").tag(category as Category?)
//                    }
//                }
//                
//                Button("Save") {
//                    let newProduct = Product(context: viewContext)
//                    newProduct.name = productName
//                    newProduct.price = productPrice
//                    newProduct.image = productImage
//                    selectedCategory?.addToProducts(newProduct)
//
//                    newProduct.categories = selectedCategory
//
//                    do {
//                        try viewContext.save()
//                        isPresented = false
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//            .navigationTitle("Add Product")
//            .navigationBarItems(leading: Button("Dismiss") {
//                isPresented = false
//            })
//        }
//    }
//}

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
        NavigationView {
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
