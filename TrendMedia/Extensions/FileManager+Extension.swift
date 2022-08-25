//
//  FileManager+Extension.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/08/24.
//

import UIKit

extension UIViewController {
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let folderName = "images"
        let folderURL = documentDirectory.appendingPathComponent(folderName)
        let fileURL = folderURL.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "apple.logo")
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func fetchDocumentZipFile() -> [String]? {
        
        do {
            guard let path = documentDirectoryPath() else {
                showAlertMessage(title: "Zip 파일 불러오는데 실패하였습니다.")
                return nil
            }
            
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("docs: \(docs)")
            
            let zip = docs.filter { $0.pathExtension == "zip" }
            print("Zip: \(zip)")
            
            let result = zip.map { $0.lastPathComponent }
            print("Result: \(result)")
            
            return result
            
        } catch {
            print("Error")
            return nil
        }
        
    }
    
    func saveDataToNewFolder(fileName: String, image: UIImage) {
        
        let folderName = "images"
        let fileManager = FileManager.default
        let documentsFolder = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let folderURL = documentsFolder.appendingPathComponent(folderName)
        let folderExists = (try? folderURL.checkResourceIsReachable()) ?? false
        
        do {
            if !folderExists {
                try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: false)
            }
            let fileURL = folderURL.appendingPathComponent(fileName)
            guard let data = image.jpegData(compressionQuality: 0.8) else { return }
            
            do {
                try data.write(to: fileURL)
            } catch {
                print(error)
            }

        } catch { print(error) }
        
    }
    
}
