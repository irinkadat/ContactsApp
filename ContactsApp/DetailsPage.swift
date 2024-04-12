////
////  DetailsPage.swift
////  ContactsApp
////
////  Created by Irinka Datoshvili on 12.04.24.
////
import UIKit

class DetailsPage: UIViewController {
    var developer: Developer?
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let developer = developer {
            title = developer.name
            avatarImageView.image = UIImage(named: developer.avatarImgName)
            infoLabel.text = "Age: \(developer.age)\nHobby: \(developer.hobby)"
        }
        
        setupUI()
    }
    private func setupUI() {
        view.addSubview(avatarImageView)
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            infoLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
