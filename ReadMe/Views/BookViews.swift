//
//  SwiftUIView.swift
//  ReadMe
//
//  Created by Omar Khaled on 05/02/2022.
//

import SwiftUI

struct BookmarkButton: View{
    @ObservedObject var book:Book
    
    var body: some View {
        let bookmark = "bookmark"
        Button{
            book.readMe.toggle()
        } label: {
            Image(systemName: book.readMe ? "\(bookmark).fill" : bookmark).scaledToFill()
            
        }.font(.largeTitle)
    }
}

struct BookTitleAndAuthor: View {
    let book:Book
    let titleFont:Font
    let authorFont:Font
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(titleFont)
            
            Text(book.author)
                .font(authorFont)
                .foregroundColor(.secondary)
        }
    }
}

extension Book{
    struct Image: View {
        let uiImage:UIImage?
        let title:String
        var size:CGFloat?
        var cornerRadius:CGFloat
        
        var body: some View {
            
            if let image = uiImage.map(SwiftUI.Image.init) {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .cornerRadius(cornerRadius)
            }
            else{
                let symbol = SwiftUI.Image(title: title) ??     .init(systemName: "book")
                
                
                symbol
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .font(Font.title.weight(.light))
                    .foregroundColor(.secondary)
            }
            
        }
    }
}


struct Book_Review:PreviewProvider {
    static var previews: some View {
        VStack{
            HStack{
                BookmarkButton(book: .init())
                BookmarkButton(book: .init(readMe:false))
                BookTitleAndAuthor(
                    book: .init(), titleFont: .title, authorFont: .title2
                )
            }
            Book.Image(title: Book().title)
            Book.Image(title: "")
            Book.Image(title: "📕")
        }
        .previewInAllThemes
    }
}

extension Book.Image {
    init(title:String){
        self.init(uiImage: nil, title: title, cornerRadius: .init())
    }
}

extension Image{
    init?(title:String) {
        guard let char = title.first,
              case let symbolName = "\(char.lowercased()).square",
              UIImage(systemName: symbolName) != nil
        else {
            return nil
        }
        
        self.init(systemName:symbolName)
    }
}


extension View{
    var previewInAllThemes:some View {
        ForEach(ColorScheme.allCases, id: \.self, content: preferredColorScheme)
    }
}
