//
//  TrendingCell.swift
//  SampleNewDesign
//
//  Created by Eswar on 15/11/20.
//  Copyright © 2020 PPT. All rights reserved.
//

import Foundation
import UIKit

public class TrendingCell: UITableViewCell, ViewModelToViewEntry {
    private var headerLabel: UILabel = UILabel(frame: .zero)
    private var descLabel: UILabel = UILabel(frame: .zero)
    private var tickerLabel: UILabel = UILabel(frame: .zero)
    
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
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false
        self.tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.icon.translatesAutoresizingMaskIntoConstraints = false
        self.lineView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.container)
        self.contentView.addSubview(self.icon)
        self.contentView.addSubview(self.headerLabel)
        self.contentView.addSubview(self.descLabel)
        self.container.addSubview(self.tickerLabel)
        
        self.contentView.addSubview(self.lineView)
        
        
        
        self.icon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20.0).isActive = true
        self.icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.icon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0.0).isActive = true
        
        self.headerLabel.leadingAnchor.constraint(equalTo: self.icon.trailingAnchor, constant: 10.0).isActive = true
        self.headerLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20.0).isActive = true
        self.headerLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16.0).isActive = true
        
        self.descLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 4.0).isActive = true
        
        self.descLabel.leadingAnchor.constraint(equalTo: self.icon.trailingAnchor, constant: 10.0).isActive = true
        self.descLabel.heightAnchor.constraint(equalToConstant: 12.0).isActive = true
        self.descLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20.0).isActive = true
        
        
        
        self.container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20.0).isActive = true
        self.container.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0.0).isActive = true
        self.container.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0).isActive = true
        self.container.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        self.descLabel.trailingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 8.0).isActive = true
        self.headerLabel.trailingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 8.0).isActive = true
        
        self.tickerLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 0.0).isActive = true
        self.tickerLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 0.0).isActive = true
        self.tickerLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: 0.0).isActive = true
        self.tickerLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: 0.0).isActive = true
        
        self.lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.lineView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0.0).isActive = true
        self.lineView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0.0).isActive = true
        self.lineView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0.0).isActive = true
        
        self.contentView.clipsToBounds = true
        
        self.icon.contentMode = .scaleAspectFit
        self.icon.clipsToBounds = true
        
        guard let model = model as? TrendingCellVM else { return }
        self.headerLabel.add(package: model.headerLabelPackage)
        self.tickerLabel.add(package: model.tickerLabelPackage)
        self.descLabel.add(package: model.descLabelPackage)
        self.icon.add(package: model.imageViewPackage)
        self.container.addView(package: model.containerPackage)
        self.lineView.addView(package: model.lineViewPackage)
    }
    
}

public protocol TrendingCellVM: TableCellViewModel {
    var headerLabelPackage: LabelPackage {get}
    var tickerLabelPackage: LabelPackage {get}
    var descLabelPackage: LabelPackage {get}
    var imageViewPackage: ImageViewPackage {get}
    var containerPackage: Package {get}
    var lineViewPackage: Package {get}
}

public class TrendingCellViewModel: TrendingCellVM {
    public var headerLabelPackage: LabelPackage
    
    public var tickerLabelPackage: LabelPackage
    
    public var descLabelPackage: LabelPackage
    
    public var imageViewPackage: ImageViewPackage
    
    public var containerPackage: Package
    
    public var lineViewPackage: Package
    
    public var cellIdentifier: String? = "TrendingCell"
    
    public init(headerLabelPackage: LabelPackage, tickerLabelPackage: LabelPackage, descLabelPackage: LabelPackage, imageViewPackage: ImageViewPackage, containerPackage: Package, lineViewPackage: Package) {
        self.headerLabelPackage = headerLabelPackage
        self.tickerLabelPackage = tickerLabelPackage
        self.descLabelPackage = descLabelPackage
        self.imageViewPackage = imageViewPackage
        self.containerPackage = containerPackage
        self.lineViewPackage = lineViewPackage
    }
}

public class TrendingUseCase: UseCase {
    public func sections() -> Int {
        return 1
    }
    
    public func rows(for section: Int) -> Int {
        return 5
    }
    
    public func data<T>(indexPath: IndexPath) -> T? {
        let headerLabel = Label(text: "", textColor: .black, font: .boldSystemFont(ofSize: 14.0), numberOfLines: 0)
        let descLabel = Label(text: "", textColor: .darkGray, font: .systemFont(ofSize: 12.0), numberOfLines: 0)
        let tickerLabel = Label(text: "", textColor: .white, font: .systemFont(ofSize: 12.0), numberOfLines: 0, alignment: .center)
        
        let view = View(backgroundColor: .green, cornerRadius: 10.0)
        let lineView = View(backgroundColor: .lightGray)
        let imageView = ImageView(image: nil, tintColor: .black, backgroundColor: .white, cornerRadius: 12.0, borderWidth: 1.0, borderColor: .black)
        switch indexPath.row {
        case 0:
            headerLabel.text = "Medifast"
            descLabel.text = "MEDI"
            tickerLabel.text = "12.0"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
            view.backgroundColor = .red
        case 1:
            headerLabel.text = "Pinterest"
            descLabel.text = "PINS"
            tickerLabel.text = "0.1%"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
            view.backgroundColor = .blue
        case 2:
            headerLabel.text = "Slack Tech"
            descLabel.text = "SLACK"
            tickerLabel.text = "10.2"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
            view.backgroundColor = .red
        case 3:
            headerLabel.text = "Evo Water"
            descLabel.text = "AQUA"
            tickerLabel.text = "123.0"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
            view.backgroundColor = .systemPink
        case 4:
            headerLabel.text = "Sellers"
            descLabel.text = "SELL"
            tickerLabel.text = "123"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
            view.backgroundColor = .red
        default:
            break
        }
        return TrendingCellViewModel(headerLabelPackage: headerLabel, tickerLabelPackage: tickerLabel, descLabelPackage: descLabel, imageViewPackage: imageView, containerPackage: view, lineViewPackage: lineView) as? T
    }
    
}
