//
//  detailView.swift
//  izlemeTahmin
//
//  Created by Yusiff on 24.06.2024.
//

import UIKit
import PanModal

class detailView: UIViewController {
    
    var choosenFilm : ResultFilm!
       
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var movieDetailText: UITextView!
    @IBOutlet weak var detailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
         load()
        
        let backSwipe = UISwipeGestureRecognizer(target: self, action: #selector(toBack(swipe:)))
        backSwipe.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(backSwipe)
        
          
    }
    /*
    @IBAction func backButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toBack", sender: nil)
    }
    */
    
    @objc func toBack(swipe:UISwipeGestureRecognizer){
        switch swipe.direction.rawValue{
        case 1:
            performSegue(withIdentifier: "toBack", sender: nil)
        default:
            break        }
    }
    
    
 
    func load(){
        if choosenFilm != nil {
            detailImage.layer.cornerRadius = 20
            imdbLabel.text = "IMDB Puanı: \(Int(choosenFilm.voteAverage))/10"
            detailImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(choosenFilm.posterPath)"))
            movieDetailText.text = choosenFilm.overview
        }
    }
    
}

extension detailView: PanModalPresentable{
    var panScrollable: UIScrollView? {
        nil
    }
    
    var shortFormHeight: PanModalHeight {
        
            return .contentHeight(500)
    
    }

    
}


