//
//  BookListView.swift
//  Library
//
//  Created by özgün aksoy on 2024-03-26.
//

import SwiftUI
import SwiftData

enum SortOrder: String, Identifiable, CaseIterable {
    case status, title, author
    
    var id: Self { self }
    
}

struct BookListView: View {
    @State private var isNewBookPresented: Bool = false
    @State private var sortOrder = SortOrder.status
    @State private var filterString: String = ""

    
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { order in
                    Text("Sort by \(order.rawValue.capitalized)").tag(order)
                }
                
            }
            .buttonStyle(.bordered)
            BookList(sortOrder: sortOrder, filterString: filterString)
                .searchable(text: $filterString, prompt: "Filter on title or author")
            .toolbar {
                ToolbarItem {
                    Button {
                        isNewBookPresented.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus.circle.fill")
                    }
                                            
                }
            }
            .navigationTitle("My Books")
            .sheet(isPresented: $isNewBookPresented) {
                NewBookView()
                    .presentationDetents([.medium])
            }
            
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return BookListView()
        .modelContainer(preview.container)
}
