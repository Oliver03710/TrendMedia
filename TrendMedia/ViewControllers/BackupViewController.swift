//
//  BackupViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/08/25.
//

import UIKit

import RealmSwift
import SnapKit
import Zip

class BackupViewController: UIViewController {

    // MARK: - Properties
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(BackupTableViewCell.self, forCellReuseIdentifier: BackupTableViewCell.reuseIdentifier)
        return tv
    }()
    
    var fileString: String?
    var index: Int?
    var task: Results<ShoppingList>!
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Selectors
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func backupButtonClicked() {
        
        var urlPaths = [URL]()
        
        // 도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm")
        let imageFolder = path.appendingPathComponent("images")
        
        guard FileManager.default.fileExists(atPath: realmFile.path), FileManager.default.fileExists(atPath: imageFolder.path) else {
            showAlertMessage(title: "백업할 파일이 없습니다.")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!)
        urlPaths.append(URL(string: imageFolder.path)!)
        
        // 백업 파일을 압축: URL
        
        do {
            let fileName = Date().toString()
            fileString = fileName
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "ShoppingList_\(fileName)")
            print("Archive Location: \(zipFilePath)")
            
            // Activity View Controller
            showActivityViewController(fileName: fileString)
            
        } catch {
            showAlertMessage(title: "압축에 실패했습니다.")
        }
        
    }
    
    @objc func restoreButtonClicked() {

        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)

    }
    
    
    // MARK: - Helper Functions
    
    func configureUI() {
        setNaviBarButtons()
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
    }
    
    func setNaviBarButtons() {
        let xButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        let backupButton = UIBarButtonItem(title: "Backup", style: .plain, target: self, action: #selector(backupButtonClicked))
        let restoreButton = UIBarButtonItem(title: "Restore", style: .plain, target: self, action: #selector(restoreButtonClicked))
        
        navigationItem.leftBarButtonItems = [xButton]
        navigationItem.rightBarButtonItems = [backupButton, restoreButton]
    }
    
    func showActivityViewController(fileName: String?) {
        
        // 도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        guard let file = fileName else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("ShoppingList_\(file).zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
}


// MARK: - Extension: UITableViewDelegate

extension BackupViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        task.forEach { removeImageFromDocument(fileName: "\($0.objectId).jpg") }
        restoreFromCell(urls: fetchDocumentZipFile().0?[indexPath.row])
    }
    
}


// MARK: - Extension: UITableViewDelegate

extension BackupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let int = fetchDocumentZipFile().1?.count else { return 0 }
        return int
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupTableViewCell.reuseIdentifier, for: indexPath) as? BackupTableViewCell else { return UITableViewCell() }
        
        cell.backupLabel.text = fetchDocumentZipFile().1?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


// MARK: - Extension: UIDocumentPickerDelegate

extension BackupViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
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
            
        } else {
            
            do {
                
                // 파일 앱의 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                guard let fileName = fetchDocumentZipFile().1?.last else {
                    showAlertMessage(title: "파일 이름 불러오는데 실패했습니다.")
                    return
                }
                let fileURL = path.appendingPathComponent(fileName)
                
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
}
