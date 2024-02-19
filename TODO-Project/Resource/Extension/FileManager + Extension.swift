//
//  FileManager + Extension.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/19/24.
//

import UIKit

extension UIViewController {
    func loadImageToDocument(pk : String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(pk)/\(pk)_image.jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return nil
            
        }
    }
    
    func saveImageToDocument(image : UIImage, pk : String) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    
        let pkDirURL = documentDirectory.appendingPathComponent(pk)
        
        //폴더 생성, overwrite test 해봐야됨. 옵션은 따로 없는듯?
        do {
            try FileManager.default.createDirectory(at: pkDirURL, withIntermediateDirectories: false)
        } catch let error {
            print("Create file error: \(error.localizedDescription)")
        }
        
        let fileURL = documentDirectory.appendingPathComponent("\(pk)/\(pk)_image.jpg")
        guard let data = image.jpegData(compressionQuality: 0.6) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }
}
