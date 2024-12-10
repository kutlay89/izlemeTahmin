//
//  girisView.swift
//  izlemeTahmin
//
//  Created by Yusiff on 15.07.2024.
//

import UIKit
import GoogleMobileAds

class girisView: UIViewController,GADBannerViewDelegate {


    @IBOutlet weak var banner: GADBannerView!
    @IBOutlet weak var startImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startImage.isUserInteractionEnabled = true
        
        let startGesture = UITapGestureRecognizer(target: self, action: #selector(toMainView))
        startImage.addGestureRecognizer(startGesture)
        getsAd()
        
    }
    

    @objc func toMainView(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVc = mainStoryboard.instantiateViewController(identifier: "mainView") as! ViewController
        nextVc.modalPresentationStyle = .fullScreen
        present(nextVc, animated: true)
        
    }
   
    
    func getsAd(){
        // banner reklam
        banner.delegate = self
     
        banner.adUnitID = "..."
        banner.rootViewController = self
        banner.load(GADRequest())
    }

}
