//
//  ViewController.swift
//  LeaderBoard
//
//  Created by Richard Tyran on 3/4/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

import UIKit
import GameKit


class ViewController: UIViewController, GKGameCenterControllerDelegate {
    
    @IBOutlet var attackLabel: UILabel!
    
    var attacks: Int64 = 0
    
    @IBAction func attack(sender: UIButton) {
        
        attacks++
        
        // update label
        
        attackLabel.text = "Attacks : \(attack)"
        
        // submit attack score
        
        var score = GKScore(leaderboardIdentifier: "attack_leaderboard")
        score.value = attacks
        
        GKScore.reportScores([score], withCompletionHandler: { (error) -> Void in
            
            println("score reported")
            
        })
        
    }
    @IBAction func leaderboard(sender: UIButton) {
        
        // stop present if user is not authenticated using GKLocalPlayer.localPlayer().authenticated
        
        // present leaderboard
        
        var leaderboardVC = GKGameCenterViewController()
        leaderboardVC.leaderboardIdentifier = "attack_leaderboard"
        leaderboardVC.gameCenterDelegate = self
        
        presentViewController(leaderboardVC, animated: true, completion: nil)
        
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GKLocalPlayer.localPlayer().authenticateHandler = { (viewController: UIViewController!, error: NSError!) -> Void in
            
            if !GKLocalPlayer.localPlayer().authenticated {
                
                self.presentViewController(viewController, animated: true, completion: nil)
            }
            
            println("authentication done = \(GKLocalPlayer.localPlayer().authenticated)")
            
            // local player is authenticated
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

