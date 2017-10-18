//
//  AppDelegate.swift
//  TrendingSocial
//
//  Created by Kirk Washam on 10/17/17.
//  Copyright © 2017 StudioATX. All rights reserved.
//

import UIKit
import AWSPinpoint
import AWSAuthCore
import AWSUserPoolsSignIn


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var pinpoint: AWSPinpoint?
    var isInitialized = false
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AWSSignInManager.sharedInstance().register(
            signInProvider: AWSCognitoUserPoolsSignInProvider.sharedInstance())
        
        let didFinishLaunching = AWSSignInManager.sharedInstance().interceptApplication(
            application, didFinishLaunchingWithOptions: launchOptions)
        
        
        if (!isInitialized) {
            AWSSignInManager.sharedInstance().resumeSession(completionHandler: {
                (result: Any?, error: Error?) in
                print("Result: \(String(describing: result)) \n Error:\(String(describing: error))")
            })
            isInitialized = true
        }
    
        
        // Initialize Pinpoint
        pinpoint = AWSPinpoint(configuration:
            AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: launchOptions))
        
        
        return didFinishLaunching
        
    }
    
 
    func application(_ application: UIApplication, open url: URL,
                     sourceApplication: String?, annotation: Any) -> Bool {
        
        print("didFinishLaunching")
        
        AWSSignInManager.sharedInstance().interceptApplication(
            application, open: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
        if (!isInitialized) {
            isInitialized = true
        }
        
        return false;
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        let pinpointAnalyticsClient =
            AWSPinpoint(configuration:
                AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: nil)).analyticsClient
        
        let event = pinpointAnalyticsClient.createEvent(withEventType: "EnteredBackGround")
        event.addAttribute("DemoAttributeValue1", forKey: "DemoAttribute1")
        event.addAttribute("DemoAttributeValue2", forKey: "DemoAttribute2")
        event.addMetric(NSNumber.init(value: arc4random() % 65535), forKey: "EnteredBackGround")
        pinpointAnalyticsClient.record(event)
        pinpointAnalyticsClient.submitEvents()
        
    }
    
 


    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

