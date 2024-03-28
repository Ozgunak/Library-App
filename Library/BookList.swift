//
//  BookList.swift
//  Library
//
//  Created by özgün aksoy on 2024-03-27.
//

import SwiftUI
import SwiftData

struct BookList: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Book.status) private var books: [Book]
    
    init(sortOrder: SortOrder, filterString: String) {
        let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
        case .status:
            [SortDescriptor(\Book.status), SortDescriptor(\.title)]
        case .title:
            [SortDescriptor(\.title)]
        case .author:
            [SortDescriptor(\.author)]
        }
        let predicate = #Predicate<Book> { book in
            book.title.localizedStandardContains(filterString) ||
            book.author.localizedStandardContains(filterString) ||
            filterString.isEmpty
        }
        _books = Query(filter: predicate, sort: sortDescriptors)
    }
    var body: some View {
        Group {
            if books.isEmpty {
                ContentUnavailableView("Add a Book To Library", systemImage: "book.fill")
            } else {
                List {
                    ForEach(books) { book in
                        NavigationLink {
                            EditBookView(book: book)
                        } label: {
                            HStack(spacing: 10) {
                                book.icon
                                VStack(alignment: .leading) {
                                    Text(book.title).font(.title2)
                                    Text(book.author).foregroundStyle(.secondary)
                                    if let rating = book.rating {
                                        HStack {
                                            ForEach(1..<rating, id: \.self) { _ in
                                                Image(systemName: "star.fill")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(.plain)
            }
        }

    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(books[index])
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return NavigationStack {
        BookList(sortOrder: .status, filterString: "")
            .modelContainer(preview.container)
    }
}
