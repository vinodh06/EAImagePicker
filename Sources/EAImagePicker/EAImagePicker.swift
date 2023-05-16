//
//  ImagePicker.swift
//  BarCodeDetection
//
//  Created by vinodh kumar on 17/05/23.
//
import SwiftUI
import UIKit

public struct EAImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage

    public init(
        sourceType: UIImagePickerController.SourceType,
        selectedImage: Binding<UIImage>
    ) {
        self.sourceType = sourceType
        self._selectedImage = selectedImage
    }

    public func makeUIViewController(
        context: UIViewControllerRepresentableContext<EAImagePicker>
    ) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    public func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: UIViewControllerRepresentableContext<EAImagePicker>
    ) {
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: EAImagePicker

        public init(_ parent: EAImagePicker) {
            self.parent = parent
        }

        public func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
