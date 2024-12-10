//
//  AppDelegate.swift
//  izlemeTahmin
//
//  Created by Yusiff on 18.06.2024.
//

import UIKit
import PanModal
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate, outPutDelegateProtocol {
    var moviesArray = [ResultFilm]()
    var uniqeMovieArray = [ResultFilm]()
    var window: UIWindow? 
    let vc = movieViewModel(services: networkCaller())
  
    
    func output(_outPut: endpointOutput) {
        switch _outPut{
        case .popular(let popular):
            
            print(popular[1].title)
        case .topRated(let toprated):
            
            self.moviesArray.append(contentsOf: toprated)
            print(toprated[0].title)
        case .upComing(let upcoming):
            
            self.moviesArray.append(contentsOf: upcoming)
            print(upcoming[1].title)
        case .discover(let discover):
            
            print(discover[0].releaseDate)
        case .trendingDay(let trendDay):
            
            self.moviesArray.append(contentsOf: trendDay)
            print(trendDay[0].title)
        case .trendingWeek(let trendWeek):
            
            print(trendWeek[0].title)
        case .trendingPerson(let trendPersonn):

            print(trendPersonn[1].title!)
        case .trendingAllDay(let trendAllDay):
            
            self.moviesArray.append(contentsOf: trendAllDay)
            print(trendAllDay[0].releaseDate)
            
        }
        uniqeMovieArray = moviesArray.removingDuplicates()
    }
    
    
    
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        UNUserNotificationCenter.current().delegate = self
        vc.delegate = self
        vc.fetchData()
       
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let id = response.notification.request.identifier

       if id == "İzleme Tavsiyesi"{
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "toMovie") as! detailView
                viewController.choosenFilm = uniqeMovieArray.randomElement()
                window.rootViewController = viewController
               

                
            }
            
            
            
           
        }
        
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let id = notification.request.identifier
        if id == "İzleme Tavsiyesi"{
             if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first{
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let viewController = storyboard.instantiateViewController(withIdentifier: "toMovie") as! detailView
     
                 viewController.choosenFilm = uniqeMovieArray.randomElement()
    
                 window.rootViewController = viewController

                 
             }
             
             
             
            
         }
         
        completionHandler(UNNotificationPresentationOptions.sound)
        

    }
    


   
    }
    
    


