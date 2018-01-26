//
//  BoardViewController.swift
//  Tic Tac Toe
//
//  Created by Aashana on 10/27/17.
//  Copyright © 2017 Aashana. All rights reserved.
//

import UIKit
import AVFoundation

class BoardViewController: UIViewController {
    @IBOutlet var player1 : UILabel!
    @IBOutlet var player2 : UILabel!
    @IBOutlet var chanceLabel : UILabel!
    @IBOutlet var rematch : UIButton!
    @IBOutlet var boardView : UIView!
    @IBOutlet var quitButton : UIButton!
    
    
 
    var count1 = 0
    var count2 = 0
    var name1 : String!
    var name2: String!
    @IBOutlet var play : UIButton!
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "backview")?.cgImage
        self.navigationController?.isNavigationBarHidden = true
        player1.text = name1 + " : \(count1)"
        player2.text = name2 + " : \(count2)"
        chanceLabel.text = name1 + "'s Turn : X"
        rematch.isHidden = true
        quitButton.layer.cornerRadius = 5
        quitButton.layer.borderWidth = 1
        quitButton.layer.borderColor = UIColor.black.cgColor
        
        if UserDefaults.standard.bool(forKey: "isPlaying")
        {
            MyAudioPlayer.unmute()
            play.setBackgroundImage(UIImage(named: "sound"), for: .normal)
        }
        else
        {
            MyAudioPlayer.mute()
            play.setBackgroundImage(UIImage(named: "mute"), for: .normal)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func quit(sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func play(sender: Any)
    {
        if UserDefaults.standard.bool(forKey: "isPlaying")
        {
            MyAudioPlayer.mute()
            play.setBackgroundImage(UIImage(named: "mute"), for: .normal)
            UserDefaults.standard.set(false, forKey: "isPlaying")
        }
        else
        {
            MyAudioPlayer.unmute()
            play.setBackgroundImage(UIImage(named: "sound"), for: .normal)
            UserDefaults.standard.set(true, forKey: "isPlaying")
        }
    }
}
protocol Modal {
    func show(animated:Bool)
    func dismiss(animated:Bool)
    var backgroundView:UIView {get}
    var dialogView:UIView {get set}
}

extension Modal where Self:UIView{
    func show(animated:Bool){
        self.backgroundView.alpha = 0
        self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
        UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0.66
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.dialogView.center  = self.center
            }, completion: { (completed) in
                
            })
        }else{
            self.backgroundView.alpha = 0.66
            self.dialogView.center  = self.center
        }
    }
    
    func dismiss(animated:Bool){
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0
            }, completion: { (completed) in
                
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        }else{
            self.removeFromSuperview()
        }
        
    }
}


