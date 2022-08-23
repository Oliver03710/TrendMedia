//
//  DetailListViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/08/23.
//

import UIKit
import SnapKit

class DetailListViewController: UIViewController {

    // MARK: - Properties
    
    let listLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.layer.borderWidth = 1.5
        label.layer.borderColor = UIColor.systemOrange.cgColor
        return label
    }()
    
    let checkedImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.image = UIImage(systemName: "square")
        view.tintColor = .black
        return view
    }()
    
    let favouriteImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.image = UIImage(systemName: "star")
        view.tintColor = .black
        return view
    }()
    
    let registeredDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [listLabel, registeredDateLabel, checkedImageView, favouriteImageView])
        sv.axis = .vertical
        sv.spacing = 40
        sv.distribution = .equalSpacing
        return sv
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        
    }
    
    
    // MARK: - Helper Functions
    
    func configureUI() {
        view.backgroundColor = .white
        [verticalStackView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        verticalStackView.snp.makeConstraints { $0.centerX.centerY.equalTo(self.view) }
        
    }

}
