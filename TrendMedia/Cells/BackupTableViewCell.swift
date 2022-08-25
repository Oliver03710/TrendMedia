//
//  BackupTableViewCell.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/08/25.
//

import UIKit

import SnapKit

class BackupTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    let backupLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    
    func setUI() {
        [backupLabel].forEach { self.addSubview($0) }
    }
    
    func setConstraints() {
        backupLabel.snp.makeConstraints { make in
            make.edges.equalTo(self.snp.edges)
        }
    }
}
