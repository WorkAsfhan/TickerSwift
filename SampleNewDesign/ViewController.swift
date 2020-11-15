//
//  ViewController.swift
//  SampleNewDesign
//
//  Created by Eswar on 15/11/20.
//  Copyright © 2020 PPT. All rights reserved.
//

import UIKit

public class ViewController: UIViewController {

    private lazy var segmentedView: UISegmentedControl = {
        let segmentedView = UISegmentedControl(items: ["Category", "Theme", "Trending"])
        segmentedView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedView)
        
        segmentedView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        segmentedView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        segmentedView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5.0).isActive = true
        segmentedView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return segmentedView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        tableView.register(TrendingCell.self, forCellReuseIdentifier: "TrendingCell")
        
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        
        return tableView
    }()
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.size.width/2 - 5.0, height: self.view.frame.size.width/2 - 5.0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ThemeCell.self, forCellWithReuseIdentifier: "ThemeCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var model: ViewModel = ViewControllerViewModel(delegate: self)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.model.selected(segment: 0)
        self.segmentedView.addTarget(self, action: #selector(self.segementValueChange(segmentedView:)), for: .valueChanged)
        
    }


    @objc private func segementValueChange(segmentedView: UISegmentedControl?) {
        self.model.selected(segment: segmentedView?.selectedSegmentIndex ?? 0)
    }
}

extension ViewController: ViewModelDelegate {
    public func updateUserInterface() {
        var i = 0
        while i < self.model.numberOfSegment {
            self.segmentedView.setTitle(self.model.segmentName(for: i), forSegmentAt: i)
            i += 1
        }
        self.segmentedView.selectedSegmentIndex = self.model.selectedIndex
        self.tableView.isHidden = !self.model.isTableView
        self.collectionView.isHidden = self.model.isTableView
        
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.sections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.rows(for: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel: TableCellViewModel = self.model.data(indexPath: indexPath) else {
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.getCellIdentifier(), for: indexPath)
        (cell as? ViewModelToViewEntry)?.set(model: cellModel)
        return cell
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.model.sections()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.rows(for: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellModel: CollectionCellViewModel = self.model.data(indexPath: indexPath) else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.getCellIdentifier(), for: indexPath)
        (cell as? ViewModelToViewEntry)?.set(model: cellModel)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/2, height: self.view.frame.size.width/2)
    }
}

public protocol ViewModelDelegate: class {
    func updateUserInterface()
}

public protocol ViewModel: TableAndCollectionViewDataSource {
    var numberOfSegment: Int {get}
    
    var selectedIndex: Int {get set}
    
    var isTableView: Bool {get}
    
    func selected(segment: Int)
    
    func segmentName(for segment: Int) -> String
    
}

public protocol TableAndCollectionViewDataSource {
    func sections() -> Int
    func rows(for section: Int) -> Int
    func data<T>(indexPath: IndexPath) -> T?
}

public enum ViewControllerSegment: Int {
    case category = 0
    case theme = 1
    case trending = 2
    
    public var name: String {
        switch self {
        case .category:
            return "Category"
        case .theme:
            return "Theme"
        case .trending:
            return "Trending"
        }
    }
}

public class ViewControllerViewModel: ViewModel, ViewModelDelegate {
    public var selectedIndex: Int = 0
    private var segment: ViewControllerSegment {
        return ViewControllerSegment(rawValue: self.selectedIndex) ?? .category
    }
    
    public var numberOfSegment: Int = 3
    
    public var isTableView: Bool {
        return (self.segment != .theme)
    }
    
    private let categoryUseCase = CategoryUseCase()
    private let trendingUseCase = TrendingUseCase()
    private let themeUseCase = ThemeUseCase()
    
    public func selected(segment: Int) {
        self.selectedIndex = segment
        self.updateUserInterface()
    }
    
    public func segmentName(for segment: Int) -> String {
        let seg = ViewControllerSegment(rawValue: segment) ?? .category
        return seg.name
    }
    
    public func sections() -> Int {
        switch self.segment {
        case .category:
            return self.categoryUseCase.sections()
        case .theme:
            return self.themeUseCase.sections()
        case .trending:
            return self.trendingUseCase.sections()
        }
    }
    
    public func rows(for section: Int) -> Int {
        switch self.segment {
        case .category:
            return self.categoryUseCase.rows(for: section)
        case .theme:
            return self.themeUseCase.rows(for: section)
        case .trending:
            return self.trendingUseCase.rows(for: section)
        }
    }
    
    public func data<T>(indexPath: IndexPath) -> T? {
        switch self.segment {
        case .category:
            return self.categoryUseCase.data(indexPath: indexPath)
        case .theme:
            return self.themeUseCase.data(indexPath: indexPath)
        case .trending:
            return self.trendingUseCase.data(indexPath: indexPath)
        }
    }
    
    private weak var delegate: ViewModelDelegate?
    
    public init(delegate: ViewModelDelegate?) {
        self.delegate = delegate
    }
    
    public func updateUserInterface() {
        DispatchQueue.main.async {
            self.delegate?.updateUserInterface()
        }
    }

}

public protocol UseCase: TableAndCollectionViewDataSource {
    
}

public class CategoryUseCase: UseCase {
    public func sections() -> Int {
        return 1
    }
    
    public func rows(for section: Int) -> Int {
        return 3
    }
    
    public func data<T>(indexPath: IndexPath) -> T? {
        let label = Label(text: "", textColor: .white, font: .italicSystemFont(ofSize: 20), backgroundColor: .clear, numberOfLines: 1, alignment: .left, cornerRadius: 0, borderWidth: 0, borderColor: .clear)
        let view = View(backgroundColor: .green, cornerRadius: 40.0)
        let lineView = View(backgroundColor: .lightGray)
        let imageView = ImageView(image: nil, tintColor: .white, backgroundColor: .clear, cornerRadius: 0.0, borderWidth: 0.0, borderColor: .clear)
        switch indexPath.row {
        case 0:
            label.text = "Stocks"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
            view.backgroundColor = .blue
        case 1:
            label.text = "ETFs"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
            view.backgroundColor = .purple
        case 2:
            label.text = "Crypto"
            imageView.image = UIImage(systemName: "square.and.arrow.up")
            view.backgroundColor = .systemTeal
        default:
            break
        }
        return CategoryCellViewModel(categoryLabelPackage: label,
                                     imageViewPackage: imageView,
                                     containerPackage: view,
                                     lineViewPackage: lineView) as? T
    }
    
    
}
