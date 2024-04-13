//
//  ViewController.swift
//  ContactsApp
//
//  Created by Irinka Datoshvili on 12.04.24.
//
import UIKit

class MainVc: UIViewController, UITableViewDataSource {

    var developersDictionary = [String: [Developer]]()
    var developersSectionTitles = [String]()
    let titleContainer = UIView()
    
    let contactsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let developerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "irinka")
        return imageView
    }()
    
    let developerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Irinka Datoshvili"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 13
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iOS Squad"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .white
        
        prepareData()
        addContactsTableView()
    }
    private func setupInfoStackView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.addSubview(infoStackView)

        infoStackView.addArrangedSubview(developerImageView)
        infoStackView.addArrangedSubview(developerNameLabel)
        
        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = UIColor(red: 196.0 / 255.0, green: 196.0 / 255.0, blue: 199.0 / 255.0, alpha: 1.0)
        headerView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: headerView.topAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            developerImageView.widthAnchor.constraint(equalToConstant: 60),
            developerImageView.heightAnchor.constraint(equalToConstant: 60),
            chevronImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 14)
        ])
        
        headerView.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: 72)
        return headerView
    }
    
    private func prepareData() {
        let developers = Developer.allDevelopers.sorted { $0.name < $1.name }
        
        for developer in developers {
            let developerKey = String(developer.name.prefix(1))
            if var developerValues = developersDictionary[developerKey] {
                developerValues.append(developer)
                developersDictionary[developerKey] = developerValues
            } else {
                developersDictionary[developerKey] = [developer]
            }
        }
        developersSectionTitles = [String](developersDictionary.keys).sorted()
    }
    
    private func addContactsTableView() {
        view.addSubview(contactsTableView)
        let headerView = setupInfoStackView()
        contactsTableView.tableHeaderView = headerView
        
        NSLayoutConstraint.activate([
            contactsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contactsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contactsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contactsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        contactsTableView.register(Contact.self, forCellReuseIdentifier: "ContactCell")
        contactsTableView.sectionIndexColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        contactsTableView.sectionIndexBackgroundColor = UIColor.clear
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return developersSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return developersSectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let developerKey = developersSectionTitles[section]
        return developersDictionary[developerKey]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! Contact
        let sectionKey = developersSectionTitles[indexPath.section]
        let developers = developersDictionary[sectionKey]!
        let developer = developers[indexPath.row]
        
        cell.configure(with: developer)
        cell.arrowTapAction = {
            let detailsVC = DetailsPage()
            detailsVC.developer = developers[indexPath.row]
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return developersSectionTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let sectionIndex = developersSectionTitles.firstIndex(of: title) else {
            return -1
        }
        return sectionIndex
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionKey = developersSectionTitles[indexPath.section]
        let developers = developersDictionary[sectionKey]!
        let selectedDeveloper = developers[indexPath.row]
        
        let detailsVC = DetailsPage()
        detailsVC.developer = selectedDeveloper
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
extension MainVc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44.5
    }
}

#Preview {
    MainVc()
}
