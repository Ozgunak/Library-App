//
//  NewBookView.swift
//  Library
//
//  Created by özgün aksoy on 2024-03-26.
//

import SwiftUI

struct NewBookView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var title: String = ""
    @State private var author: String = ""


    var body: some View {
        NavigationStack {
            List {
                TextField("Book Title", text: $title)
                TextField("Author", text: $author)
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    
                    Button {
                        let newBook = Book(title: title, author: author)
                        context.insert(newBook)
                        dismiss()
                    } label: {
                        Text("Create")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .buttonStyle(.borderedProminent)
                    .padding(.vertical)
                .disabled(title.isEmpty || author.isEmpty)
                }
            }
        }
    }
}

#Preview {
    NewBookView()
        .modelContainer(for: Book.self, inMemory: true)
}
