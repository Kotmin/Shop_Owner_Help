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
        ZStack{
            Color.green.ignoresSafeArea()
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
