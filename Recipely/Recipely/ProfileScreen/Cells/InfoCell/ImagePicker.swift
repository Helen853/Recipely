// ImagePicker.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Picker для галлереи
final class ImagePicker: NSObject {
    var imagePickerController: UIImagePickerController?
    var returnImageHandler: ((UIImage) -> ())?

    func showImagePicker(in viewController: UIViewController, handler: ((UIImage) -> ())?) {
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        guard let imagePickerController = imagePickerController else { return }
        viewController.present(imagePickerController, animated: true)
        returnImageHandler = handler
    }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let image = info[.originalImage] as? UIImage {
            returnImageHandler?(image)

            picker.dismiss(animated: true)
        }
    }
}
