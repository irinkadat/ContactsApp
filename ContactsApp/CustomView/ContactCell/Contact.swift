//
//  Contact.swift
//  ContactsApp
//
//  Created by Irinka Datoshvili on 12.04.24.
//

import UIKit

class Contact: UITableViewCell {
    private let nameLabel = UILabel()
    private let arrowImageView = UIImageView()
    var arrowTapAction: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.isUserInteractionEnabled = true
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.tintColor = UIColor(red: 196.0 / 255.0, green: 196.0 / 255.0, blue: 199.0 / 255.0, alpha: 1.0)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(arrowImageView)

        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowImageView.leadingAnchor, constant: -10),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            arrowImageView.widthAnchor.constraint(equalToConstant: 10),
            arrowImageView.heightAnchor.constraint(equalToConstant: 14),
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(arrowTapped))
        arrowImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func arrowTapped() {
        arrowTapAction?()
    }
    
    func configure(with developer: Developer) {
        let fullName = developer.name
        let nameComponents = fullName.components(separatedBy: " ")
        let capitalizedComponents = nameComponents.map { $0.capitalized }
        let finalName = capitalizedComponents.joined(separator: " ")
        nameLabel.text = finalName
    }
}




