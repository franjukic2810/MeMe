//
//  ContentView.swift
//  MeMe
//
//  Created by Fran Jukic on 17/07/2020.
//  Copyright © 2020 Fran Jukic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var showImagePicker: Bool = false
  @State var pickedImage: UIImage? = nil
  
  var body: some View {
    VStack(alignment: .leading) {
        Image(uiImage: pickedImage ?? UIImage())
          .resizable()
          .scaledToFill()
          .overlay(
            Rectangle()
              .strokeBorder(style: StrokeStyle(lineWidth: 1))
              .foregroundColor(Color.black))
          .clipped()
      Button(action: {
        self.showImagePicker.toggle()
      }, label: {
        HStack {
          Spacer()
          Text("Pick Image")
          Spacer()
        }
      })
    }
    .sheet(isPresented: $showImagePicker, onDismiss: {
      self.showImagePicker = false
    }, content: {
        Text("Image picker goes here")
    })
  }
}

struct ImagePicker: UIViewControllerRepresentable {
  
  @Binding var image: UIImage?
  @Binding var isShown: Bool
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image)
  }
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<ImagePicker>) {
    
  }
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    
    init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
      _isShown = isShown
      _image = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      isShown.toggle()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      isShown.toggle()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
