// ImagePicker.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Picker для галлереи
final class ImagePicker: NSObject {
    // MARK: - Public Properties

    var imagePickerController: UIImagePickerController?
    var returnImageHandler: ImageHandler?

    // MARK: - Public Methods

    func showImagePicker(in viewController: UIViewController, handler: ((UIImage) -> ())?) {
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        guard let imagePickerController = imagePickerController else { return }
        viewController.present(imagePickerController, animated: true)
        returnImageHandler = handler
    }
}

// MARK: - ImagePicker + UINavigationControllerDelegate

extension ImagePicker: UINavigationControllerDelegate {}

// MARK: - ImagePicker +  UIImagePickerControllerDelegate

extension ImagePicker: UIImagePickerControllerDelegate {
    /// Возаразение выбранной картинки
    /// -Parametr: UIImagePickerController
    /// -Parametr: какого типа картинка будет передаваться
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        // выбранная картинка .originalImage
        if let image = info[.originalImage] as? UIImage {
            // кложура с выбранной картинкой
            returnImageHandler?(image)
            // удаление пикера после выбора картинки
            picker.dismiss(animated: true)
        }
    }
}
