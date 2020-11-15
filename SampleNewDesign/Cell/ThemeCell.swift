//
//  ThemeCell.swift
//  SampleNewDesign
//
//  Created by Eswar on 15/11/20.
//  Copyright © 2020 PPT. All rights reserved.
//

import Foundation
import UIKit

public class ThemeCell: UICollectionViewCell, ViewModelToViewEntry {
    private var headerLabel: UILabel = UILabel(frame: .zero)
    
    private var icon: UIImageView = UIImageView(frame: .zero)
    private var container: UIView = UIView(frame: .zero)
    
    private var model: CategoryCellVM?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func set<T>(model: T) {
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        // Set any attributes of your UI components here.
        self.container.translatesAutoresizingMaskIntoConstraints = false
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.icon.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.icon)
        self.container.addSubview(self.headerLabel)
        
        self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        self.container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        
        self.icon.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 5).isActive = true
        self.icon.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 5).isActive = true
        self.icon.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -5).isActive = true
        
        
        self.headerLabel.topAnchor.constraint(equalTo: self.icon.bottomAnchor, constant: 5).isActive = true
        self.headerLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 5).isActive = true
        self.headerLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -5).isActive = true
        self.headerLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: 5.0).isActive = true
        self.headerLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        self.icon.contentMode = .scaleAspectFit
        self.icon.clipsToBounds = true
        
        guard let model = model as? ThemeCellVM else { return }
        self.headerLabel.add(package: model.headerLabelPackage)
        self.icon.add(package: model.imageViewPackage)
        self.container.addView(package: model.containerPackage)
    }
    
}

public protocol CollectionCellViewModel: CellViewModel {
    
}

public protocol ThemeCellVM: CollectionCellViewModel {
    var headerLabelPackage: LabelPackage {get}
    var imageViewPackage: ImageViewPackage {get}
    var containerPackage: Package {get}
}

public class ThemeCellViewModel: ThemeCellVM {
    public var headerLabelPackage: LabelPackage
    
    public var imageViewPackage: ImageViewPackage
    
    public var containerPackage: Package
    
    public var cellIdentifier: String? = "ThemeCell"
    
    public init(headerLabelPackage: LabelPackage, imageViewPackage: ImageViewPackage, containerPackage: Package) {
        self.headerLabelPackage = headerLabelPackage
        self.imageViewPackage = imageViewPackage
        self.containerPackage = containerPackage
    }
}

public class ThemeUseCase: UseCase {
    public func sections() -> Int {
        return 1
    }
    
    public func rows(for section: Int) -> Int {
        return 5
    }
    
    public func data<T>(indexPath: IndexPath) -> T? {
        let headerLabel = Label(text: "", textColor: .black, font: .boldSystemFont(ofSize: 14.0), numberOfLines: 0, alignment: .center)
        let view = View(backgroundColor: .init(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.0), cornerRadius: 4.0)
        let imageView = ImageView(image: nil, tintColor: .black, backgroundColor: .clear)
        switch indexPath.row {
        case 0:
            headerLabel.text = "Medifast"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
        case 1:
            headerLabel.text = "Pinterest"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
        case 2:
            headerLabel.text = "Slack Tech"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
        case 3:
            headerLabel.text = "Evo Water"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
        case 4:
            headerLabel.text = "Sellers"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
        default:
            break
        }
        return ThemeCellViewModel(headerLabelPackage: headerLabel, imageViewPackage: imageView, containerPackage: view) as? T
    }
    
}
