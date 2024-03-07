//
//  ContentView.swift
//  CoreDataRecap
//
//  Created by Paweł Jan Tłusty on 06/03/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryName, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>

    
    var body: some View {
            NavigationView {
                List {
                    ForEach(categories, id: \.self) { category in
                        Text(category.categoryName ?? "Unknown Category")
                    }.onDelete(perform: deleteCategories)
                }
                .toolbar {
                    Button("Add Categories") {
                        addCategory(name: "Electronics")
                        addCategory(name: "Drinks")
                        addCategory(name: "Dessert")
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
