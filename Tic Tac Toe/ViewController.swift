//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Aashana on 10/27/17.
//  Copyright © 2017 Aashana. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var player1 : UITextField!
    @IBOutlet var player2 : UITextField!
    @IBOutlet var labelErr : UILabel!
    @IBOutlet var music : UIButton!
    @IBOutlet var multiPlayerButton : UIButton!
    @IBOutlet var startButton : UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "backview")?.cgImage

        self.navigationController?.isNavigationBarHidden = true
        labelErr.isHidden = true
        player1.delegate = self
        player2.delegate = self
        if UserDefaults.standard.object(forKey: "isPlaying") == nil
        {
            UserDefaults.standard.set(true, forKey: "isPlaying")
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    @IBAction func startClick(sender : UIButton)
    {
        if player1.text == ""
        {
            labelErr.text = "Enter Player 1"
            labelErr.isHidden = false
        }
        else if player2.text == ""
        {
            labelErr.text = "Enter Player 2"
            labelErr.isHidden = false
        }
        else
        {
            labelErr.isHidden = true
            let boardViewController = self.storyboard?.instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
            boardViewController.name1 = player1.text
            boardViewController.name2 = player2.text
            self.navigationController?.pushViewController(boardViewController, animated: true)
        }
    }
    override func viewWillAppear(_ animated : Bool)
    {
        player1.text = ""
        player2.text = ""
        labelErr.isHidden = true
        multiPlayerButton.isHidden = false
        multiPlayerButton.setTitle("2-Player Mode", for: .normal)
        player2.isHidden = true
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
    @IBAction func playerModeButton(sender : UIButton)
    {
        
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return true
    }
    


}

