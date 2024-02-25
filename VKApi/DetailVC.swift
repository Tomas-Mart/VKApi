//
//  DetailVC.swift
//  VKApi
//
//  Created by Amina TomasMart on 25.02.2024.
//

import UIKit

class DetailVC: UIViewController {
    
    let manager = VKManager()
    var groups: VKGroup?
    
    private lazy var nameText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = groups?.screenName
        return $0
    }(UILabel())
    
    private lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var text: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.text = groups?.name
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(nameText)
        view.addSubview(image)
        view.addSubview(text)
        addConstraints()
        setImage(imageUrl: groups!.photo50)
    }
    
    func setImage(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {return}
        self.image.load(url: url)
    }
    
    func addConstraints() {
        let ratio = (image.image?.size.height ?? 0) / (image.image?.size.width ?? 0)
        let imageH = (view.frame.width-20) * ratio
        
        NSLayoutConstraint.activate([
            
            nameText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            image.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 20),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            image.heightAnchor.constraint(equalToConstant: imageH),
            
            text.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 60),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
