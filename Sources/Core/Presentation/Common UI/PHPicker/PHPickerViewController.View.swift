//
//  PHPickerViewController.View.swift
//  Recipedia
//
//  Created by Abhijana Agung Ramanda on 04/01/21.
//

import SwiftUI
import PhotosUI
#if canImport(UIKit)
import UIKit
#endif

extension PHPickerViewController {
  public struct View {
    @Binding var image: UIImage?
    
    public init(image: Binding<UIImage?>) {
      _image = image
    }
  }
}

// MARK: - UIViewControllerRepresentable
extension PHPickerViewController.View: UIViewControllerRepresentable {
  public func makeCoordinator() -> some PHPickerViewControllerDelegate {
    PHPickerViewController.Delegate(image: $image)
  }

  public func makeUIViewController(context: Context) -> PHPickerViewController {
    let picker = PHPickerViewController( configuration: .init() )
    picker.delegate = context.coordinator
    return picker
  }

  public func updateUIViewController(_: UIViewControllerType, context _: Context) { }
}

// MARK: - PHPickerViewControllerDelegate
extension PHPickerViewController.Delegate: PHPickerViewControllerDelegate {
  func picker(
    _ picker: PHPickerViewController,
    didFinishPicking results: [PHPickerResult]
  ) {
    if let pickedPhoto = results.first {
      pickedPhoto.itemProvider.loadObject(ofClass: UIImage.self) {[unowned self] image, _ in
        DispatchQueue.main.async {
          self.image = image as? UIImage
          picker.dismiss(animated: true)
        }
      }
    } else {
      picker.dismiss(animated: true)
    }
  }
}

// MARK: - private
private extension PHPickerViewController {
  final class Delegate {
    init(image: Binding<UIImage?>) {
      _image = image
    }

    @Binding var image: UIImage?
  }
}
