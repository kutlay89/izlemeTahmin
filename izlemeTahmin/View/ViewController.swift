//
//  ViewController.swift
//  izlemeTahmin
//
//  Created by Yusiff on 18.06.2024.
//

import UIKit
import Algorithms
import SDWebImage
import PanModal
import UserNotifications
import GoogleMobileAds


class ViewController: UIViewController, GADBannerViewDelegate {
  

    @IBOutlet weak var bannner: GADBannerView!
    @IBOutlet weak var randomImage: UIImageView!
    
    @IBOutlet weak var listCollectionView: UICollectionView!
   
    @IBOutlet weak var pickerView: UIPickerView!
    
    var moviesArray = [ResultFilm]()
    var trendPerson = [KnownFor]()
    var selectedFilm : ResultFilm!
    var uniqeMovieArray = [ResultFilm]()
    var choosenCategory = Int()
    
    var randomMovieAray = [ResultFilm]()
 
    var selectId = Int()
    var selectedCategory = Int()

    let moviesCategories : [(n:String, t:Int)] = [("Aksiyon",28),("Animasyon",16),("Macera",12),("Bilim Kurgu",878),("Komedi",35),("Suç",80),("Belgesel",99),("Drama",18),("Aile",10752), ("Fantazi",14),("Tarih",36),("Korku",27),("Gizem",9648), ("Romantik",10749), ("Savaş",10752),("Western",37)]
    
    
    var önerilenFilm = [ResultFilm]()
 
    var randomId = [437342,614933,786892,1086747,955555,1022789]
   
    
    
    
    let vc = movieViewModel(services: networkCaller())

    override func viewDidLoad() {
        super.viewDidLoad()
        vc.delegate = self
        vc.fetchData()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        checkPermission()
    
        randomMovies()
        
        self.listCollectionView.tag = 0

        toBack()
        getsAd()

       
    }
    
    func getsAd(){
  
        bannner.delegate = self
        bannner.adUnitID = "..."
        bannner.rootViewController = self
        bannner.load(GADRequest())
    }
    
    func toBack(){
        let backSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(toStart(swipe:)))
        backSwipeGesture.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(backSwipeGesture)
    }
    
    @objc func toStart(swipe:UISwipeGestureRecognizer){
        switch swipe.direction.rawValue{
        case 1:
        self.dismiss(animated: true)
        default:
            break
        }
        
    }
    
    func randomMovies(){
        
        randomImage.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toRandom))
        randomImage.addGestureRecognizer(gesture)
       
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        randomMovies()
    }
    
    func checkPermission(){
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                userNotificationCenter.requestAuthorization(options: [.alert, .sound]) { allowed, error in
                    if allowed{
                        self.bildirim()
                    }
                }
            case .denied:
                return
            case .authorized:
                self.bildirim()
            case .provisional:
                return
            case .ephemeral:
                return
            @unknown default:
                fatalError()
            }
        }
        
    }
    
    
    func bildirim(){
        
        let ıd = "İzleme Tavsiyesi"
        let userNotificationcenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Ne İzlesem..."
        content.subtitle = "Günlük Film Önerinize Bakın"
        content.sound = .default
        
        let hours = 19
        let minute = 05
        let daily = true
        
        let calender = Calendar.current
        var dateCompose = DateComponents(calendar: calender, timeZone: TimeZone.current)
        dateCompose.hour = hours
        dateCompose.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompose, repeats: daily)
        let request = UNNotificationRequest(identifier: ıd, content: content, trigger: trigger)
        userNotificationcenter.removePendingNotificationRequests(withIdentifiers: [ıd])
        userNotificationcenter.add(request)
        
    }
    
 
    
    
    @objc func toRandom(){
        
            selectId = randomId.randomElement()!

            self.listCollectionView.tag = 1
            self.randomImage.isHidden = true
            
            recommended(url: URL(string: "https://api.themoviedb.org/3/movie/\(String(describing: selectId)))/recommendations?language=tr-TR&api_key=6bbb49a5c6e3ab5bf9deb9a5672b18d4")!) { (result: Result<[ResultFilm], movieError>) in
                
                switch result{
                case .success(let recommend):
                    
                    self.randomMovieAray.append(contentsOf: recommend)
                    self.listCollectionView.reloadData()
               
                    print(recommend)
                    
                case .failure(_):
                    print("OLMADI")
                    
                }
   
            }

        }
      

    func filmFiltrele(preference:Int)->[ResultFilm]{

        önerilenFilm = uniqeMovieArray.filter{film in
            DispatchQueue.main.async {
                self.listCollectionView.reloadData()
            }

            return film.genreIDS.contains(preference)

        }
        
        return önerilenFilm
    }
    
    func filmÖner(){
        let tahmin = filmFiltrele(preference: selectedCategory)
        for film in tahmin {
            let x = film.genreIDS.map{$0}
            print(x)
          
        }
    }
    
        
    func recommended(url:URL, completion:@escaping(Result<[ResultFilm],movieError>)->Void){
    
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completion(.failure(.parseError))
                print("Parse Error")
                completion(.failure(.serverError))
                print("Server Error")
            }
            if let data = data  {
                let jsonResponse = try? JSONDecoder().decode(movieModel.self, from: data)
                if let jsonResponse = jsonResponse{
                    DispatchQueue.main.async {
                        completion(.success(jsonResponse.results))

                    }
                }
            }
        } .resume()
    }



    
}

extension ViewController:outPutDelegateProtocol{
    
    func output(_outPut: endpointOutput) {
        switch _outPut{
        case .popular(let popular):

         //   self.moviesArray.append(contentsOf: popular)
            print(popular[1].title)
        case .topRated(let toprated):

            self.moviesArray.append(contentsOf: toprated)
            print(toprated[0].title)
        case .upComing(let upcoming):

            self.moviesArray.append(contentsOf: upcoming)
            print(upcoming[1].title)
        case .discover(let discover):

     //      self.moviesArray.append(contentsOf: discover)
            print(discover[0].releaseDate)
        case .trendingDay(let trendDay):

            self.moviesArray.append(contentsOf: trendDay)
            print(trendDay[0].title)
        case .trendingWeek(let trendWeek):

          //  self.moviesArray.append(contentsOf: trendWeek)
            print(trendWeek[0].title)
        case .trendingPerson(let trendPersonn):
           // self.trendPerson = trendPersonn
            print(trendPersonn[1].title!)
        case .trendingAllDay(let trendAllDay):

            self.moviesArray.append(contentsOf: trendAllDay)
            print(trendAllDay[0].releaseDate)
  
        }
        uniqeMovieArray = moviesArray.removingDuplicates()
    }
    
    
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return moviesCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return moviesCategories[row].n
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.listCollectionView.tag = 0
 
       randomMovies()
        selectedCategory = moviesCategories[row].t
        
        filmÖner()
        
        print(selectedCategory)
    }
    

 
}


extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listCollectionView.tag == 1{
            return randomMovieAray.count
        }
        else if listCollectionView.tag == 0{
            return önerilenFilm.count
        }
        return önerilenFilm.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for:indexPath) as! listCellCollectionViewCell
        cell.listImage.layer.cornerRadius = 23
        
        if listCollectionView.tag == 1{
            cell.listImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(randomMovieAray[indexPath.row].posterPath )"))
            return cell
        } else if listCollectionView.tag == 0{
            cell.listImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(önerilenFilm[indexPath.row].posterPath )"))
            return cell
            
        }
        return cell
   
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if listCollectionView.tag == 0{
            selectedFilm = önerilenFilm[indexPath.row]
        }
        else if listCollectionView.tag == 1{
            selectedFilm = randomMovieAray[indexPath.row]
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVc = storyBoard.instantiateViewController(identifier: "toMovie") as! detailView
        nextVc.choosenFilm = selectedFilm
        if let parenVc = parentViewController{
        
            parenVc.presentPanModal(nextVc)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125 , height: 150)
    }
   
    
}



extension UIResponder {
    var parentViewController: UIViewController? {
        if let viewController = self as? UIViewController {
            return viewController
        } else {
            return next?.parentViewController
        }
    }
}


extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
