//
//  SecondViewController.swift
//  PhotoPickerBoilerplate
//
//  Created by nikita on 29.08.2021.
//

import UIKit
import Photos

struct PhotoItem {
    let isSelected: Bool
}

protocol CustomLayoutDelegate: AnyObject {
    func someFunc() -> Int
}

class CustomLayout: UICollectionViewLayout {
    weak var delegate: CustomLayoutDelegate?
    
    init(delegate: CustomLayoutDelegate) {
        self.delegate = delegate
        
        super.init()
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        nil
    }
}

class Cell: UICollectionViewCell {
    lazy var label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SecondViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource = [PhotoItem(isSelected: false), PhotoItem(isSelected: false), PhotoItem(isSelected: false), PhotoItem(isSelected: false), PhotoItem(isSelected: false), PhotoItem(isSelected: false), PhotoItem(isSelected: false)]
    
    @IBAction func selectButtonTapped() {
        let selectedItems = dataSource.filter { $0.isSelected }
        print("callback: \(selectedItems)")
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        PHImageManager
        
//        collectionView.collectionViewLayout =         UICollectionViewFlowLayout() либо CustomLayout(delegate: self)
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataSource[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.label.text = "\(indexPath.item)"
        cell.contentView.backgroundColor = item.isSelected ? .red : .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
}

extension SecondViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataSource = dataSource.enumerated().map { (index, element) -> PhotoItem in
            
            if element.isSelected, index == indexPath.item {
                return PhotoItem(isSelected: false)
            } else if !element.isSelected, index == indexPath.item {
                return PhotoItem(isSelected: true)
            } else {
                return element 
            }
        }
        
        collectionView.reloadData()
    }
}

//extension SecondViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//    }4
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//    }
//}

//extension SecondViewController: CustomLayoutDelegate {
//    func someFunc() -> Int {
//
//    }
//}
