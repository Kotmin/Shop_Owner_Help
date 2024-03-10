//
//  CategoryControlView.swift
//  CoreDataRecap
//
//  Created by Paweł Jan Tłusty on 10/03/2024.
//

import SwiftUI

struct CategoryControlView: View {
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
    
    
    var showEditButton: Bool = true

       var body: some View {
           VStack(spacing: 25) {
               Image(systemName: "chevron.up").padding(.top)
               Text("Categories").font(.headline).fontWeight(.semibold)
               NavigationStack {
                  HStack{
                      Button("Add Categories") {
                          self.showingAddCategoryView = true
                      }
                      if showEditButton{
                          NavigationLink(destination: FullScreenCategoryView()){Text("Edit")}
                      }

                  }
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
//                   .toolbar {
//                       VStack{
//                           Button("Add Categories") {
//                               self.showingAddCategoryView = true
//                           }
//                           NavigationLink(destination: FullScreenCategoryView()){Text("Edit")}
//                           
//                       }
//                   }
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

#Preview {
    CategoryControlView(showEditButton: true)
}
