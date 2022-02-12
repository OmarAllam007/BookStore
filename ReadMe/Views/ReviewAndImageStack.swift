//
//  ReviewAndImageStack.swift
//  ReadMe
//
//  Created by Omar Khaled on 09/02/2022.
//

import SwiftUI
import class PhotosUI.PHPickerViewController

struct ReviewAndImageStack:View {
    @State var showingImagePicker = false
    @State var showingDeleteImage = false
    @ObservedObject var book:Book
    @Binding var image:UIImage?
    
    var body: some View {
        
        VStack {
            Divider().padding(.vertical)
            TextField("Review", text: $book.microReview)
            Divider().padding(.vertical)
            Book.Image(
                uiImage: image, title: book.title, cornerRadius: 12
            )
            
            
            
            let updatebutton =  Button(action: {
                showingImagePicker = true
            }) {
                Text("Update Image…")
            }.padding()
            
            if image != nil {
                HStack {
                    Spacer()
                    updatebutton
                    Spacer()
                    Button(action: {
                        showingDeleteImage = true
                    }) {
                        Text("Delete Image")
                    }.padding()
                    Spacer()
                }
            }else{
                updatebutton
            }
        }.sheet(isPresented: $showingImagePicker) {
            PHPickerViewController.View(image: $image)
        }.alert(isPresented: $showingDeleteImage){
            Alert(title: .init("Delete image for \(book.title)"), message: nil, primaryButton: .destructive(.init("Delete"),action: {
                image = nil
            }), secondaryButton: .cancel())
        }
        
    
    }
}

struct ReviewAndImageStack_Previews: PreviewProvider {
    static var previews: some View {
        ReviewAndImageStack(book: .init(), image: .constant(nil))
            .previewInAllThemes
    }
}
