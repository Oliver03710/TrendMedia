//
//  FileManager+Extension.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/08/24.
//

import UIKit

import RealmSwift
import Zip

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
    
    func fetchDocumentZipFile() -> ([URL]?, [String]?) {
        
        do {
            guard let path = documentDirectoryPath() else {
                showAlertMessage(title: "Zip 파일 불러오는데 실패하였습니다.")
                return (nil, nil)
            }
            
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("docs: \(docs)")
            
            let zip = docs.filter { $0.pathExtension == "zip" }
            print("Zip: \(zip)")
            
            let result = zip.map { $0.lastPathComponent }
            print("Result: \(result)")
            
            return (zip, result)
            
        } catch {
            print("Error")
            return (nil, nil)
        }
        
    }
    
    func restoreFromCell(urls: URL?) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        guard let selectedFileURL = urls else {
            showAlertMessage(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            guard let fileName = fetchDocumentZipFile().1?.last else {
                showAlertMessage(title: "파일 이름 불러오는데 실패했습니다.")
                return
            }
            let fileURL = path.appendingPathComponent(fileName)
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("\(unzippedFile)")
                    self.showRestoreAlertMessage(title: "복구가 완료되었습니다.")
                })
                
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
            
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
