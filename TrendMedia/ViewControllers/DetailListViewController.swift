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
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [checkedImageView, favouriteImageView])
        sv.axis = .horizontal
        sv.spacing = 20
        sv.distribution = .fillProportionally
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
        [imageView, listLabel, registeredDateLabel, verticalStackView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {

        imageView.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(imageView.snp.width).multipliedBy(1)
        }
        
        listLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.height.equalTo(32)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
        }
        
        registeredDateLabel.snp.makeConstraints { make in
            make.top.equalTo(listLabel.snp.bottom).offset(16)
            make.height.equalTo(32)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(registeredDateLabel.snp.bottom).offset(16)
//            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16)
//            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        checkedImageView.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(checkedImageView.snp.height).multipliedBy(1)
        }

        favouriteImageView.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(favouriteImageView.snp.height).multipliedBy(1)
        }
        
    }

}
