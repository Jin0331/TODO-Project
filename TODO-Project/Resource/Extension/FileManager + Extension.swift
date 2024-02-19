//
//  FileManager + Extension.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/19/24.
//

import UIKit

extension UIViewController {
    func loadImageToDocument(filename : String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return nil
            
        }
    }
    
    func saveImageToDocument(image : UIImage, filename : String) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        guard let data = image.jpegData(compressionQuality: 0.6) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }
}
