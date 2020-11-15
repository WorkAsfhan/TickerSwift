//
//  CategoryCell.swift
//  SampleNewDesign
//
//  Created by Eswar on 15/11/20.
//  Copyright © 2020 PPT. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewModelToViewEntry {
    func set<T>(model: T)
}

public class CategoryCell: UITableViewCell, ViewModelToViewEntry {
    private var label: UILabel = UILabel(frame: .zero)
    private var icon: UIImageView = UIImageView(frame: .zero)
    private var container: UIView = UIView(frame: .zero)
    private var lineView: UIView = UIView(frame: .zero)
    
    private var model: CategoryCellVM?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.autoresizesSubviews = true
        self.selectionStyle = .none
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
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.icon.translatesAutoresizingMaskIntoConstraints = false
        self.lineView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.label)
        self.container.addSubview(self.icon)
        self.contentView.addSubview(self.lineView)
        
        self.container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20.0).isActive = true
        self.container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20.0).isActive = true
        self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -11.0).isActive = true
        
        self.icon.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 20.0).isActive = true
        self.icon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.icon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        self.icon.centerYAnchor.constraint(equalTo: self.container.centerYAnchor, constant: 0.0).isActive = true
        
        self.label.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -20.0).isActive = true
        self.label.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 20.0).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -20.0).isActive = true
        
        self.label.leadingAnchor.constraint(equalTo: self.icon.trailingAnchor, constant: 20.0).isActive = true
        self.label.heightAnchor.constraint(greaterThanOrEqualToConstant: 40.0).isActive = true
        
        
        self.lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.lineView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0.0).isActive = true
        self.lineView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0.0).isActive = true
        self.lineView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0.0).isActive = true
        
        self.contentView.clipsToBounds = true
        
        self.icon.contentMode = .scaleAspectFit
        
        guard let model = model as? CategoryCellVM else { return }
        self.label.add(package: model.categoryLabelPackage)
        self.icon.add(package: model.imageViewPackage)
        self.container.addView(package: model.containerPackage)
        self.lineView.addView(package: model.lineViewPackage)
    }
    
}

public protocol CellViewModel {
    var cellIdentifier: String? {get set}
    func getCellIdentifier() -> String
}

extension CellViewModel {
    public func getCellIdentifier() -> String {
        return self.cellIdentifier ?? "cell"
    }
}

public protocol TableCellViewModel: CellViewModel {
    
}

public protocol CategoryCellVM: TableCellViewModel {
    var categoryLabelPackage: LabelPackage {get}
    var imageViewPackage: ImageViewPackage {get}
    var containerPackage: Package {get}
    var lineViewPackage: Package {get}
}

public class CategoryCellViewModel: CategoryCellVM {
    public var cellIdentifier: String? = "CategoryCell"
    
    public var categoryLabelPackage: LabelPackage
    
    public var imageViewPackage: ImageViewPackage
    
    public var containerPackage: Package
    
    public var lineViewPackage: Package
    
    public init(categoryLabelPackage: LabelPackage, imageViewPackage: ImageViewPackage, containerPackage: Package, lineViewPackage: Package) {
        self.categoryLabelPackage = categoryLabelPackage
        self.imageViewPackage = imageViewPackage
        self.containerPackage = containerPackage
        self.lineViewPackage = lineViewPackage
    }
}

public protocol Package {
    var tintColor: UIColor? {get set}
    var backgroundColor: UIColor? {get set}
    var cornerRadius: CGFloat {get set}
    var borderWidth: CGFloat {get set}
    var borderColor: UIColor? {get set}
}

public class View: Package {
    public var tintColor: UIColor?
    
    public var backgroundColor: UIColor?
    
    public var cornerRadius: CGFloat
    
    public var borderWidth: CGFloat
    
    public var borderColor: UIColor?
    
    public init(backgroundColor: UIColor?, cornerRadius: CGFloat = 0.0, borderWidth: CGFloat = 0.0, borderColor: UIColor? = .clear) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
    }
}

public protocol ImageViewPackage: Package {
    var image: UIImage? {get set}
}

public class ImageView: ImageViewPackage {
    public var image: UIImage?
    
    public var tintColor: UIColor?
    
    public var backgroundColor: UIColor?
    
    public var cornerRadius: CGFloat
    
    public var borderWidth: CGFloat
    
    public var borderColor: UIColor?
    
    public init(image: UIImage? = nil, tintColor: UIColor?, backgroundColor: UIColor?, cornerRadius: CGFloat = 0.0, borderWidth: CGFloat = 0.0, borderColor: UIColor? = .clear) {
        self.image = image
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
    }
}

public protocol LabelPackage: Package {
    var text: String {get set}
    var textColor: UIColor? {get set}
    var font: UIFont? {get set}
    var alignment: NSTextAlignment? {get set}
    var numberOfLines: Int {get set}
}

public class Label: LabelPackage {
    public var cornerRadius: CGFloat
    
    public var borderWidth: CGFloat
    
    public var borderColor: UIColor?
    
    public var tintColor: UIColor?
    
    public var numberOfLines: Int
    
    public var alignment: NSTextAlignment?
    
    public var text: String = ""
    
    public var textColor: UIColor?
    
    public var font: UIFont?
    
    public var backgroundColor: UIColor?
    
    public init(text: String = "", textColor: UIColor?, font: UIFont?, backgroundColor: UIColor? = .clear, numberOfLines: Int = 1, alignment: NSTextAlignment? = .left, cornerRadius: CGFloat = 0.0, borderWidth: CGFloat = 0.0, borderColor: UIColor? = .clear) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.numberOfLines = numberOfLines
        self.alignment = alignment
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
    }
}

extension UILabel {
    public func add(package: LabelPackage) {
        self.text = package.text
        self.textColor = package.textColor
        self.font = package.font
        self.textAlignment = package.alignment ?? .left
        self.numberOfLines = package.numberOfLines
        self.addView(package: package)
    }
}

extension UIImageView {
    public func add(package: ImageViewPackage) {
        self.image = package.image
        self.tintColor = package.tintColor
        self.addView(package: package)
    }
}

extension UIView {
    public func addView(package: Package) {
        self.layer.borderWidth = package.borderWidth
        self.layer.borderColor = package.borderColor?.cgColor
        self.layer.cornerRadius = package.cornerRadius
        self.backgroundColor = package.backgroundColor
        self.tintColor  = package.tintColor
    }
}
