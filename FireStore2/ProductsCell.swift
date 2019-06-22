//
//  TableViewCell.swift
//  FireStore2
//
//  Created by Concetta Turner on 11/5/18.
//  Copyright © 2018 Concetta Turner. All rights reserved.
//

import TinyConstraints

class GridLayout: UICollectionViewFlowLayout {
    
    let innerSpace: CGFloat = 0.01
    let numberOfCellsOnRow: CGFloat = 1
    
    override init() {
        super.init()
        self.minimumLineSpacing = innerSpace
        self.minimumInteritemSpacing = innerSpace
        self.scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
         self.scrollDirection = .horizontal
    }
    
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.size.width/self.numberOfCellsOnRow)-self.innerSpace
    }

    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width:itemWidth(), height:itemWidth())
        }
        get {
            return CGSize(width:itemWidth(),height:itemWidth())
        }
    }
}

import UIKit
class ProductsCell: UICollectionViewCell {
    
        static let Id = "WeAiet"
    
        var productImages: UIImage?
        var productNamee: UILabel?
        var productDescriptionn: UILabel?

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        NSLayoutConstraint.activate([
//            productImageee.widthAnchor.constraint(equalTo: widthAnchor),
//            productImageee.heightAnchor.constraint(equalTo: heightAnchor),
//            productImageee.leadingAnchor.constraint(equalTo: leadingAnchor),
//            productImageee.trailingAnchor.constraint(equalTo: trailingAnchor)
//            ])
        
        
        self.backgroundColor = UIColor(hex: "ffffe")
        
         self.tintColor = UIColor(hex: "ffffe")
        
        if let imgs = productImages {
            productImageee.image = imgs
        }
        
        if let names = productNamee {
            productName.text = names.text
        }
        
        if let description = productDescriptionn {
            productDescription.text = description.text
        }
        
        self.addSubview(productImageee)
        self.addSubview(productName)
         self.addSubview(productDescription)

        productImageee.width(200)
        productImageee.height(150)
        productImageee.center(in: self, offset: CGPoint(x: 0, y: 10))

        
        productName.width(200)
        productName.height(74)
        productName.center(in: self, offset: CGPoint(x: 0, y: -80))
        
        productDescription.width(200)
        productDescription.height(74)
        productDescription.center(in: self, offset: CGPoint(x: 0, y: 80))
    }
    
    
    lazy var productImageee: UIImageView = {
        let tableView = UIImageView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = false
        tableView.contentMode = .scaleAspectFit
        
        return tableView
    }()
    
    lazy var productName: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        let customFont = UIFont(name: "AgentOrange", size: 20)
        view.adjustsFontForContentSizeCategory = true
        view.font = customFont
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 7
        view.textColor = UIColor.white
        return view
    }()
    
    lazy var productDescription: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        let customFont = UIFont(name: "Lato-Regular", size: 15)
        view.adjustsFontForContentSizeCategory = true
        view.font = customFont
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 7
        view.textColor = UIColor.white
        return view
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
     override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
//    func configure(_ model: UIImage?, _ name: UILabel?) {
//        productImageee.image = model
//        productName.text = name?.text
//    }
    
    
    override func prepareForReuse() {
        self.contentView.frame = self.bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

//    @IBOutlet weak var productNameLabel: UILabel!
//    @IBOutlet weak var productPRiceLabel: UILabel!
//    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var catagoryName: UILabel!
    
}


class TableViewCelly: UITableViewCell {
    
    
    var moreIMAGES: UIImage?
    var catagoryNAME: UILabel?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let imgs = moreIMAGES {
            moreImages.image = imgs
        }
        
        if let names = catagoryNAME {
            catagoryName.text = names.text
        }
    }
    
    lazy var moreImages: UIImageView = {
        let tableView = UIImageView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.contentMode = .scaleAspectFit
        
        return tableView
    }()
    
    lazy var catagoryName: UILabel = {
        let tableView = UILabel()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(moreImages)
        self.addSubview(catagoryName)
        
        moreImages.width(101)
        moreImages.height(101)
        moreImages.center(in: self, offset: CGPoint(x: 110, y: 0))
        
        catagoryName.width(200)
        catagoryName.height(74)
        catagoryName.center(in: self, offset: CGPoint(x: -70, y: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    override func prepareForReuse() {
        self.contentView.frame = self.bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}






class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellProductImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var donutLabel: UILabel!
    
    
    var tapCallback: (() -> Void)?
    
    @IBAction func didTap(_ sender: Any) {
        tapCallback?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

class RandomCell: UICollectionViewCell {
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
    
    
//
//    var tapCallback: (() -> Void)?
//
//    @IBAction func didTap(_ sender: Any) {
//        tapCallback?()
//    }
//
//
//    var cellLabel: UILabel!
//    var pan: UIPanGestureRecognizer!
//    var deleteLabel1: UILabel!
//    var deleteLabel2: UILabel!
//    var ARViewButton: UIButton!
    

    
    
//
//    override var bounds: CGRect {
//        didSet {
//            self.layoutIfNeeded()
//        }
//    }
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//
//    // Fake Slide picture Cell
//    private func commonInit() {
//        productImage.backgroundColor = UIColor.gray
//        self.backgroundColor = UIColor.red
    
//        cellLabel = UILabel()
//        cellLabel.textColor = UIColor.white
//        cellLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.contentView.addSubview(cellLabel)
//        cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
//        cellLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
//        cellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
//        cellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
//
//        deleteLabel1 = UILabel()
//        deleteLabel1.text = "delete"
//        deleteLabel1.textColor = UIColor.white
//        self.insertSubview(deleteLabel1, belowSubview: self.contentView)
//
//        deleteLabel2 = UILabel()
//        deleteLabel2.text = "delete"
//        deleteLabel2.textColor = UIColor.white
//        self.insertSubview(deleteLabel2, belowSubview: self.contentView)
        
//        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
//        pan.delegate = self
//        self.addGestureRecognizer(pan)
//    }
//
//
//    override func prepareForReuse() {
//        self.contentView.frame = self.bounds
//    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        if (pan.state == UIGestureRecognizer.State.changed) {
//            let p: CGPoint = pan.translation(in: self)
//            let width = self.contentView.frame.width
//            let height = self.contentView.frame.height
//            self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
//            //            self.deleteLabel1.frame = CGRect(x: p.x - deleteLabel1.frame.size.width-10, y: 0, width: 100, height: height)
//            //            self.deleteLabel2.frame = CGRect(x: p.x + width + deleteLabel2.frame.size.width, y: 0, width: 100, height: height)
//        }
//
//    }
//
//    @objc func onPan(_ pan: UIPanGestureRecognizer) {
//        if pan.state == UIGestureRecognizer.State.began {
//
//        } else if pan.state == UIGestureRecognizer.State.changed {
//            self.setNeedsLayout()
//        } else {
//            if abs(pan.velocity(in: self).x) > 500 {
//                let collectionView: UICollectionView = self.superview as! UICollectionView
//                let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
//                collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
//            } else {
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.setNeedsLayout()
//                    self.layoutIfNeeded()
//                })
//            }
//        }
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//
//    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        print(indexPath.row + 1)
//
//    }
//
//
    
    
//    var shoe: Shoe! {
//        didSet {
//            self.updateUI()
//        }
//    }
//    
//    func updateUI()
//    {
//        shoeNameLabel.text = shoe.name
//        shoeDescriptionLabel.text = shoe.description
//    }


