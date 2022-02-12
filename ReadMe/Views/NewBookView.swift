//
//  NewBookView.swift
//  ReadMe
//
//  Created by Omar Khaled on 09/02/2022.
//

import SwiftUI

struct NewBookView: View {
    @ObservedObject var book = Book(title: "", author: "")
    @State var image:UIImage? = nil
    @EnvironmentObject var library:Library
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 24){
                TextField("Title", text: $book.title)
                TextField("Author", text: $book.author)
                ReviewAndImageStack(book: book, image: $image)
                Spacer()
            }
            .padding()
            .navigationTitle("Add new Book")
            .toolbar{
                ToolbarItem(placement:.status){
                    Button("Add to library"){
                        library.addNewBook(book,image: image)
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(.borderless).disabled([book.title, book.author].contains(where: {$0.isEmpty}) )
                }
            }
        }
    }
}

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView()
            .environmentObject(Library())
    }
}
