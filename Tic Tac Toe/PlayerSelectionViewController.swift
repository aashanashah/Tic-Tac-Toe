//
//  PlayerSelectionViewController.swift
//  Tic Tac Toe
//
//  Created by Aashana Shah on 7/4/18.
//  Copyright © 2018 Aashana. All rights reserved.
//

import UIKit

class PlayerSelectionViewController: UIViewController {
    @IBOutlet var singlePlayerButton : UIButton!
    @IBOutlet var multiPlayerButton : UIButton!
    @IBOutlet var music : UIButton!
    @IBOutlet var captionLabel : UILabel!
    @IBOutlet var backButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "backview")?.cgImage
        self.navigationController?.isNavigationBarHidden = true
        singlePlayerButton.layer.borderColor = UIColor.black.cgColor
        singlePlayerButton.layer.borderWidth = 1
        singlePlayerButton.tag = 0
        multiPlayerButton.tag = 1
        multiPlayerButton.layer.borderColor = UIColor.black.cgColor
        multiPlayerButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        backButton.layer.borderWidth = 1
        backButton.isHidden = true
        backButton.tag = 2
        if UserDefaults.standard.object(forKey: "isPlaying") == nil
        {
            UserDefaults.standard.set(true, forKey: "isPlaying")
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        MyAudioPlayer.playFile(name: "music", type: "mp3")
        if UserDefaults.standard.bool(forKey: "isPlaying")
        {
            MyAudioPlayer.unmute()
            music.setBackgroundImage(UIImage(named: "sound"), for: .normal)
        }
        else
        {
            MyAudioPlayer.mute()
            music.setBackgroundImage(UIImage(named: "mute"), for: .normal)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClickButton(_ sender : UIButton)
    {
        var player = 1
        var level = ""
        if captionLabel.text == "Choose Mode"
        {
            if sender.tag == 0
            {
                player = 1
                captionLabel.text = "Choose Level"
                singlePlayerButton.setTitle("Easy", for: .normal)
                multiPlayerButton.setTitle("Difficult", for: .normal)
                backButton.isHidden = false
            }
            else
            {
                player = 2
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                viewController.player = player
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        else
        {
            if sender.tag == 2
            {
                captionLabel.text = "Choose Mode"
                singlePlayerButton.setTitle("Single Player", for: .normal)
                multiPlayerButton.setTitle("Multi Player", for: .normal)
                backButton.isHidden = true
            }
            level = sender.currentTitle!
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            viewController.player = player
            viewController.level = level
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    @IBAction func play(sender: UIButton)
    {
        if UserDefaults.standard.bool(forKey: "isPlaying")
        {
            MyAudioPlayer.mute()
            music.setBackgroundImage(UIImage(named: "mute"), for: .normal)
            UserDefaults.standard.set(false, forKey: "isPlaying")
        }
        else
        {
            MyAudioPlayer.unmute()
            music.setBackgroundImage(UIImage(named: "sound"), for: .normal)
            UserDefaults.standard.set(true, forKey: "isPlaying")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
