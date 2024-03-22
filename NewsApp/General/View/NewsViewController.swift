//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Антон Баландин on 21.03.24.
//

import UIKit
import SnapKit

final class NewsViewController: UIViewController {
    
    // MARK: - GUI Variables
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon") ?? UIImage.add
        return view
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Краткое описание новости"
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()
    
    let descriptionText: UILabel = {
        let label = UILabel()
        label.text = """
NewsApp - это инновационное мобильное приложение, которое позволяет пользователям быть в курсе последних новостей из различных источников. С помощью NewsApp вы можете получать свежие новости по различным категориям, таким как политика, экономика, спорт, наука, культура и многое другое, прямо на вашем смартфоне.
"""
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "21.03.2024"
        label.font = UIFont(name: "Helvetica", size: 14)
        return label
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
    }
    
    // MARK: - Methods
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(textLabel)
        view.addSubview(descriptionText)
        view.addSubview(dateLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.width.equalTo(250)
            make.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionText.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            
        }
    }
}
