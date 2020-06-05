//
//  ViewController.swift
//  tryPhatmacy
//
//  Created by MAC on 6/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import ImageSlideshow

class ViewController: UIViewController, ImageSlideshowDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    //actions
    @IBAction func goToAllBrands(_ sender: UIButton) {
    }
    
    // outlits
    @IBOutlet weak var allBrandsButton: UIButton!
    @IBOutlet weak var smallLabel: UILabel!
    @IBOutlet weak var ourServiceLabel: UILabel!
    @IBOutlet weak var slideImage: ImageSlideshow!
    
    @IBOutlet weak var serviceCollectionView: UICollectionView!{
        didSet{
            serviceCollectionView.delegate = self
            serviceCollectionView.dataSource = self
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        AppUtility.lockOrientation(.portrait)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)

    }
    //lock oriantation
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    struct AppUtility {

        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {

            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }

        /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {

            self.lockOrientation(orientation)

            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }

    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {//for ibad
        self.view.setNeedsLayout()
        slideImage.clipsToBounds = true
        imageSiderSetub()
        navigationBarSetub()
        setubLabels()
        serviceCollectionView.backgroundColor = .clear
        serviceCollectionView.reloadData()
        print(view.frame)
    }
    //vriavles
    var imageSlideModel = [ImageSlideModel]()
    var imgeSlideImages:[AlamofireSource] {
        get{
            var images = [AlamofireSource]()
            for img in imageSlideModel {
                images.append(AlamofireSource(url: img.imageUrl))
                
            }
            return images
        }
    }
    
    let numbetOfServices = 7
    
    //let localSource = [BundleImageSource(imageString: "img1"), BundleImageSource(imageString: "img2"), BundleImageSource(imageString: "img3"), BundleImageSource(imageString: "img4")]
    
    //lyfe cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageSlideModel.append(ImageSlideModel(imageUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BNGZiMzBkZjMtNjE3Mi00MWNlLWIyYjItYTk3MjY0Yjg5ODZkXkEyXkFqcGdeQXVyNDg4NjY5OTQ@._V1_SX300.jpg")!))
        imageSlideModel.append(ImageSlideModel(imageUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BOTk5ODg0OTU5M15BMl5BanBnXkFtZTgwMDQ3MDY3NjM@._V1_QL50_SY1000_CR0,0,674,1000_AL_.jpg")!))
        imageSlideModel.append(ImageSlideModel(imageUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BNGVjNWI4ZGUtNzE0MS00YTJmLWE0ZDctN2ZiYTk2YmI3NTYyXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_SY1000_CR0,0,674,1000_AL_.jpg")!))
        imageSlideModel.append(ImageSlideModel(imageUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMjhiMzgxZTctNDc1Ni00OTIxLTlhMTYtZTA3ZWFkODRkNmE2XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SY1000_CR0,0,718,1000_AL_.jpg")!))
        
        slideImage.clipsToBounds = true
        imageSiderSetub()
        navigationBarSetub()
        setubLabels()
        serviceCollectionView.backgroundColor = .clear

        
        
        
    }
    //setub funcs
    private func setubLabels(){
        ourServiceLabel.font = UIFont.boldSystemFont(ofSize: view.bounds.height * (35.0/896.0))
        smallLabel.font = UIFont.preferredFont(forTextStyle: .body).withSize(view.bounds.height * (15.0/896.0))
        allBrandsButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).withSize(view.bounds.height * (17.0/896.0))
    }
    private func navigationBarSetub(){
        let myCardButton = UIBarButtonItem(image: UIImage(named: "addToCard"), style: .plain, target: self, action: #selector(myCard))
        self.navigationItem.leftBarButtonItem  = myCardButton
        let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(openProfile))
        let profileButton = UIBarButtonItem(image: UIImage(named: "profile"), style: .plain, target: self, action: #selector(openSearchBar))
        self.navigationItem.rightBarButtonItems = [profileButton, searchButton]
        navigationController?.navigationBar.tintColor = .black
        //self.navigationItem.rightBarButtonItem = profileButton
        //navigationItem.titleView = titleView
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
    }
    @objc private func myCard(){//go to the card
        
    }
    @objc private func openProfile(){//open profile
        
    }
    @objc private func openSearchBar(){//open search bar
        
    }
    private func imageSiderSetub(){
        slideImage.slideshowInterval = 3.0
        slideImage.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        slideImage.pageIndicator = pageControl
        slideImage.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        slideImage.activityIndicator = DefaultActivityIndicator()
        slideImage.delegate = self
        slideImage.setImageInputs(imgeSlideImages)
        //slideImage.roundCorners(corners: [.bottomRight], radius: slideImage.bounds.height * 0.06)
        slideImage.layer.cornerRadius = slideImage.bounds.height * 0.06
        slideImage.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        
    }
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        //print(page)
    }
    //collection view delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbetOfServices
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serviceCell", for: indexPath)
        //cell.layer.cornerRadius = cell.bounds.height * 0.1
        cell.backgroundColor = .clear
        cell.contentView.layer.cornerRadius = cell.bounds.height * 0.1
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 1.0
        cell.layer.shadowOpacity = 0.3
//        cell.layer.masksToBounds = false
//        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        if let serviceCell = cell as? ServiceCollectionViewCell {
            serviceCell.serviceImage.frame.size = CGSize(width: serviceCell.frame.width, height: serviceCell.frame.height * 0.7)
            serviceCell.serviceImage.image = UIImage(named: "FitnessEquipment")?.af_imageScaled(to: serviceCell.serviceImage.frame.size)
            serviceCell.serviceImage.backgroundColor = .yellow
            serviceCell.serviceImage.contentMode = .scaleAspectFill
            serviceCell.serviceNameLabel.sizeToFit()
            serviceCell.serviceNameLabel.numberOfLines = 0
            serviceCell.serviceNameLabel.font = UIFont.boldSystemFont(ofSize: view.bounds.height * (20.0/896.0))
            serviceCell.serviceNameLabel.text = "Fitness\nEquipment"
            
           
        }
        //print(cell.frame)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.height*0.88)*(100/160), height: collectionView.bounds.height*0.88)
    }

}
extension ImageSlideshow {
    private struct sizeRatio {
        static let cornerRedusToToBoundHight:CGFloat = 0.06
    }
    
    private var cornerRedus:CGFloat{
        return bounds.size.height * sizeRatio.cornerRedusToToBoundHight
    }
    
    
}
extension CGRect {
    var leftHafe : CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHafe : CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func  inset(py size:CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size:CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(py ratio:CGFloat) -> CGRect {
        return insetBy(dx: (width-(width*ratio))/2, dy: (height-(height*ratio))/2)
    }
}
extension CGPoint {
    func  offsetBy(dx:CGFloat, dy:CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}

