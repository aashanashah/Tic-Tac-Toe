//
//  Board.swift
//  Tic Tac Toe
//
//  Created by Aashana on 10/27/17.
//  Copyright © 2017 Aashana. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable class Board: UIView {
    let cellsPerRow = 3
    let dividerWidthGuide: CGFloat = 0.02
    var cellWidth: CGFloat!
    var cellHeight: CGFloat!
    var dividerWidth: CGFloat!
    @IBOutlet weak var controller: BoardViewController!
    var circleLayer: CAShapeLayer!
    var crossLayer: CAShapeLayer!
    var lineLayer : CAShapeLayer!
    var layerArray = Array<CALayer>()
    var winStart = 0
    var winMid = 0
    var winEnd = 0
    var count=0
    var flag = 1
    var win = 1
    var xwin = 0
    var owin = 0
    var xplayer : AVAudioPlayer!
    var oplayer : AVAudioPlayer!
    var winplayer : AVAudioPlayer!
    let pathX = Bundle.main.path(forResource: "xTone", ofType: "mp3")
    let pathO = Bundle.main.path(forResource: "OTone", ofType: "mp3")
    let pathWin = Bundle.main.path(forResource: "win", ofType: "mp3")
    var activeplayer = 1
    var gamefinished = false
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var winner : String!


    override func draw(_ rect: CGRect)
    {
        setUpGameBoardCells()
        
        UIColor.black.setStroke()
        do
        {
            try xplayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: pathX!))
            try oplayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: pathO!))
            try winplayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: pathWin!))
        }
        catch
        {
            print("Could not load file")
        }
        
        var divider = UIBezierPath(rect: CGRect(x: cellWidth, y: 0, width: dividerWidth, height: bounds.size.height))
        divider.lineWidth = 1
        divider.stroke()
        
        divider = UIBezierPath(rect: CGRect(x: cellWidth * 2 + dividerWidth, y: 0, width: dividerWidth, height: bounds.size.height))
        divider.lineWidth = 1
        divider.stroke()
        divider = UIBezierPath(rect: CGRect(x: 0, y: cellWidth, width: bounds.size.width, height: dividerWidth))
        divider.lineWidth = 1
        divider.stroke()
        
        divider = UIBezierPath(rect: CGRect(x: 0 , y: cellWidth * 2 + dividerWidth, width: bounds.size.width, height: dividerWidth))
        divider.lineWidth = 1
        divider.stroke()
        setButtons()
    }
    func setUpGameBoardCells()
    {
        let gameBoardLength = min(bounds.size.height, bounds.size.width)
        dividerWidth = round(gameBoardLength * dividerWidthGuide)
        let cellsTotalWidth: Int = Int(gameBoardLength) - Int(dividerWidth) * (cellsPerRow - 1)
        let dividerWidthFudge: CGFloat = (cellsTotalWidth % cellsPerRow == 1 ? -1 : (cellsTotalWidth % cellsPerRow == 2 ? 1 : 0))
        dividerWidth! += dividerWidthFudge
        cellWidth = CGFloat((cellsTotalWidth - Int(dividerWidthFudge) * (cellsPerRow - 1)) / cellsPerRow)
    }
    func setButtons()
    {
        let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth))
        button1.backgroundColor = .clear
        button1.setTitle("", for: .normal)
        button1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button1.tag = 1
        self.addSubview(button1)
        let button2 = UIButton(frame: CGRect(x: 0, y: cellWidth + dividerWidth, width: cellWidth, height: cellWidth))
        button2.backgroundColor = .clear
        button2.setTitle("", for: .normal)
        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button2.tag = 4
        self.addSubview(button2)
        let button3 = UIButton(frame: CGRect(x: cellWidth + dividerWidth, y: 0, width: cellWidth, height: cellWidth))
        button3.backgroundColor = .clear
        button3.setTitle("", for: .normal)
        button3.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button3.tag = 2
        self.addSubview(button3)
        let button4 = UIButton(frame: CGRect(x: cellWidth + dividerWidth, y: cellWidth + dividerWidth, width: cellWidth, height: cellWidth))
        button4.backgroundColor = .clear
        button4.setTitle("", for: .normal)
        button4.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button4.tag = 5
        self.addSubview(button4)
        let button5 = UIButton(frame: CGRect(x: (cellWidth + dividerWidth) * 2, y: 0, width: cellWidth, height: cellWidth))
        button5.backgroundColor = .clear
        button5.setTitle("", for: .normal)
        button5.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button5.tag = 3
        self.addSubview(button5)
        let button6 = UIButton(frame: CGRect(x: 0, y: (cellWidth + dividerWidth) * 2, width: cellWidth, height: cellWidth))
        button6.backgroundColor = .clear
        button6.setTitle("", for: .normal)
        button6.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button6.tag = 7
        self.addSubview(button6)
        let button7 = UIButton(frame: CGRect(x: (cellWidth + dividerWidth) * 2, y: cellWidth + dividerWidth, width: cellWidth, height: cellWidth))
        button7.backgroundColor = .clear
        button7.setTitle("", for: .normal)
        button7.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button7.tag = 6
        self.addSubview(button7)
        let button8 = UIButton(frame: CGRect(x: cellWidth + dividerWidth, y: (cellWidth + dividerWidth) * 2, width: cellWidth, height: cellWidth))
        button8.backgroundColor = .clear
        button8.setTitle("", for: .normal)
        button8.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button8.tag = 8
        self.addSubview(button8)
        let button9 = UIButton(frame: CGRect(x: (cellWidth + dividerWidth) * 2, y: (cellWidth + dividerWidth) * 2, width: cellWidth, height: cellWidth))
        button9.backgroundColor = .clear
        button9.setTitle("", for: .normal)
        button9.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button9.tag = 9
        self.addSubview(button9)
    }
    @objc func buttonAction(sender : UIButton)
    {
        if gameState[sender.tag-1] == 0 && gamefinished == false
        {
            if activeplayer == 1
            {
                if UserDefaults.standard.bool(forKey: "isPlaying")
                {
                    xplayer.play()
                }
                print(gameState)
                print(sender.tag-1)
                gameState[sender.tag-1] = 1
                let crossPath = UIBezierPath()
                crossPath.move(to: CGPoint(x:sender.frame.origin.x+20,y:sender.frame.origin.y+20))
                crossPath.addLine(to: CGPoint(x:sender.frame.origin.x+cellWidth-20,y:sender.frame.origin.y+cellWidth-20))
                
                crossLayer = CAShapeLayer()
                crossLayer.path = crossPath.cgPath
                crossLayer.fillColor = UIColor.clear.cgColor
                crossLayer.strokeColor = UIColor.blue.cgColor
                crossLayer.lineWidth = 10.0;
                layerArray.insert(crossLayer,at:count)
                count+=1
                
                self.layer.addSublayer(crossLayer)
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = 0.5
                crossLayer.add(animation, forKey: "MyAnimation")
                
                crossPath.move(to: CGPoint(x:sender.frame.origin.x+cellWidth-20,y:sender.frame.origin.y+20))
                crossPath.addLine(to: CGPoint(x:sender.frame.origin.x+20,y:sender.frame.origin.y+cellWidth-20))
                
                crossLayer = CAShapeLayer()
                crossLayer.path = crossPath.cgPath
                crossLayer.fillColor = UIColor.clear.cgColor
                crossLayer.strokeColor = UIColor.blue.cgColor
                crossLayer.lineWidth = 10.0;
                layerArray.insert(crossLayer,at:count)
                count+=1
                
                self.layer.addSublayer(crossLayer)
                crossLayer.add(animation, forKey: "MyAnimation")

                activeplayer = 2
                
                controller.chanceLabel.text = controller.name2 + "'s Turn : O"
            }
            else
            {
                if UserDefaults.standard.bool(forKey: "isPlaying")
                {
                    oplayer.play()
                }
                let circlePath = UIBezierPath(arcCenter: CGPoint(x: (sender.frame.origin.x) + cellWidth / 2.0, y: (sender.frame.origin.y) + cellWidth / 2.0), radius: ((cellWidth)/2)-20, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
            
                circleLayer = CAShapeLayer()
                circleLayer.path = circlePath.cgPath
                circleLayer.fillColor = UIColor.clear.cgColor
                circleLayer.strokeColor = UIColor.red.cgColor
                circleLayer.lineWidth = 10.0;
                layerArray.insert(circleLayer,at:count)
                count+=1
                
                self.layer.addSublayer(circleLayer)
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = 0.5
                circleLayer.add(animation, forKey: "MyAnimation")
                activeplayer = 1
                gameState[sender.tag-1] = 2
                controller.chanceLabel.text = controller.name1 + "'s Turn : X"
            }
            checkWinner()
        }
        else if gamefinished == true
        {
            let alert = UIAlertController(title: "Game Over!", message: "Rematch to continue playing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            controller.present(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Wrong Move", message: "Choose a different Location", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            controller.present(alert, animated: true, completion: nil)
        }
    }
    func computerPlay()
    {
        if controller.level == "Easy" && controller.player == 1
        {
            var randomNo = Int(arc4random_uniform(8))
            while gameState[randomNo] != 0
            {
                randomNo = Int(arc4random_uniform(8))
            }
            if let sender = self.viewWithTag(randomNo+1) as? UIButton
            {
                print(gameState)
                print(sender.tag-1)
                if UserDefaults.standard.bool(forKey: "isPlaying")
                {
                    oplayer.play()
                }
                gameState[sender.tag-1] = 2
                let circlePath = UIBezierPath(arcCenter: CGPoint(x: (sender.frame.origin.x) + cellWidth / 2.0, y: (sender.frame.origin.y) + cellWidth / 2.0), radius: ((cellWidth)/2)-20, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
                
                circleLayer = CAShapeLayer()
                circleLayer.path = circlePath.cgPath
                circleLayer.fillColor = UIColor.clear.cgColor
                circleLayer.strokeColor = UIColor.red.cgColor
                circleLayer.lineWidth = 10.0;
                layerArray.insert(circleLayer,at:count)
                count+=1
                
                self.layer.addSublayer(circleLayer)
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = 0.5
                circleLayer.add(animation, forKey: "MyAnimation")
                activeplayer = 1
                controller.chanceLabel.text = controller.name1 + "'s Turn : X"
                checkWinner()
            }
        }
        else
        {
            
        }
    }
    func checkWinner()
    {
        win = 0
        xwin = 0
        owin = 0
        for item in winningCombinations
        {
            if gameState[item[0]] != 0 && gameState[item[0]] == gameState[item[1]] && gameState[item[1]] == gameState[item[2]]
            {
                if gameState[item[0]] == 1
                {
                    xwin = 1
                    winner = controller.name1
                }
                else
                {
                    owin = 1
                    winner = controller.name2
                }
                controller.rematch.isHidden = false
                winStart = item[0]
                winMid = item[1]
                winEnd = item[2]
                gamefinished = true
                drawWinningLine()
                win = 1
                printWinner()
            }
        }
        
        controller.player1.text = controller.name1 + " : \(controller.count1)"
        controller.player2.text = controller.name2 + " : \(controller.count2)"
        flag = 1
        for item in gameState
        {
            if item  == 0
            {
                flag = 0
            }
        }
        if flag == 1 && win == 0
        {
            controller.rematch.isHidden = false
            controller.chanceLabel.text = "The game is draw"
            gamefinished = true
        }
        if gamefinished == false && activeplayer == 2 && controller.player == 1
        {
            computerPlay()
        }
    }
    func printWinner()
    {
        if(xwin == 1)
        {
            controller.chanceLabel.text = controller.name1 + " has won!!"
            controller.count1 = controller.count1+1
            activeplayer = 1
        }
        else if(owin == 1)
        {
            controller.chanceLabel.text = controller.name2 + " has won!!"
            controller.count2 = controller.count2+1
            activeplayer = 2
        }
    }
    func drawWinningLine()
    {
        if UserDefaults.standard.bool(forKey: "isPlaying")
        {
            winplayer.play()
        }
        if winStart == 0
        {
            if winMid == 1
            {
                let linePath = UIBezierPath()
                linePath.move(to: CGPoint(x:0,y:cellWidth/2))
                linePath.addLine(to: CGPoint(x:bounds.size.width,y:cellWidth/2))
                
                lineLayer = CAShapeLayer()
                lineLayer.path = linePath.cgPath
                lineLayer.fillColor = UIColor.clear.cgColor
                lineLayer.strokeColor = UIColor.black.cgColor
                lineLayer.lineWidth = 10.0;
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = 0.5
                lineLayer.add(animation, forKey: "MyAnimation")
                layerArray.insert(lineLayer,at:count)
                count+=1
                
                self.layer.addSublayer(lineLayer)
            }
            else if winMid == 3
            {
                let linePath = UIBezierPath()
                linePath.move(to: CGPoint(x:cellWidth/2,y:0))
                linePath.addLine(to: CGPoint(x:cellWidth/2,y:bounds.size.height))
   
                lineLayer = CAShapeLayer()
                lineLayer.path = linePath.cgPath
                lineLayer.fillColor = UIColor.clear.cgColor
                lineLayer.strokeColor = UIColor.black.cgColor
                lineLayer.lineWidth = 10.0;
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = 0.5
                lineLayer.add(animation, forKey: "MyAnimation")
                layerArray.insert(lineLayer,at:count)
                count+=1
                
                self.layer.addSublayer(lineLayer)
            }
            else
            {
                let linePath = UIBezierPath()
                linePath.move(to: CGPoint(x:0,y:0))
                linePath.addLine(to: CGPoint(x:bounds.size.width,y:bounds.size.height))
                
                lineLayer = CAShapeLayer()
                lineLayer.path = linePath.cgPath
                lineLayer.fillColor = UIColor.clear.cgColor
                lineLayer.strokeColor = UIColor.black.cgColor
                lineLayer.lineWidth = 10.0;
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = 0.5
                lineLayer.add(animation, forKey: "MyAnimation")
                layerArray.insert(lineLayer,at:count)
                count+=1
                
                self.layer.addSublayer(lineLayer)
            }
        }
        else if winStart == 2
        {
            if winMid == 5
            {
                let linePath = UIBezierPath()
                linePath.move(to: CGPoint(x:bounds.size.width-cellWidth/2,y:0))
                linePath.addLine(to: CGPoint(x:bounds.size.width-cellWidth/2,y:bounds.size.height))
                
                lineLayer = CAShapeLayer()
                lineLayer.path = linePath.cgPath
                lineLayer.fillColor = UIColor.clear.cgColor
                lineLayer.strokeColor = UIColor.black.cgColor
                lineLayer.lineWidth = 10.0;
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = 0.5
                lineLayer.add(animation, forKey: "MyAnimation")
                layerArray.insert(lineLayer,at:count)
                count+=1
                
                self.layer.addSublayer(lineLayer)
            }
            else
            {
                let linePath = UIBezierPath()
                linePath.move(to: CGPoint(x:bounds.size.width,y:0))
                linePath.addLine(to: CGPoint(x:0,y:bounds.size.height))
                
                lineLayer = CAShapeLayer()
                lineLayer.path = linePath.cgPath
                lineLayer.fillColor = UIColor.clear.cgColor
                lineLayer.strokeColor = UIColor.black.cgColor
                lineLayer.lineWidth = 10.0;
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = 0.5
                lineLayer.add(animation, forKey: "MyAnimation")
                layerArray.insert(lineLayer,at:count)
                count+=1
                
                self.layer.addSublayer(lineLayer)
            }
        }
        else if winStart == 1
        {
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x:bounds.size.width/2,y:0))
            linePath.addLine(to: CGPoint(x:bounds.size.width/2,y:bounds.size.height))
            
            lineLayer = CAShapeLayer()
            lineLayer.path = linePath.cgPath
            lineLayer.fillColor = UIColor.clear.cgColor
            lineLayer.strokeColor = UIColor.black.cgColor
            lineLayer.lineWidth = 10.0;
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 0.5
            lineLayer.add(animation, forKey: "MyAnimation")
            layerArray.insert(lineLayer,at:count)
            count+=1
            
            self.layer.addSublayer(lineLayer)
        }
        else if winStart == 3
        {
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x:0,y:bounds.size.height/2))
            linePath.addLine(to: CGPoint(x:bounds.size.width,y:bounds.size.height/2))
        
            lineLayer = CAShapeLayer()
            lineLayer.path = linePath.cgPath
            lineLayer.fillColor = UIColor.clear.cgColor
            lineLayer.strokeColor = UIColor.black.cgColor
            lineLayer.lineWidth = 10.0;
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 0.5
            lineLayer.add(animation, forKey: "MyAnimation")
            layerArray.insert(lineLayer,at:count)
            count+=1
            
            self.layer.addSublayer(lineLayer)
        }
        else
        {
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x:0,y:bounds.size.height-cellWidth/2))
            linePath.addLine(to: CGPoint(x:bounds.size.width,y:bounds.size.height-cellWidth/2))
            
            lineLayer = CAShapeLayer()
            lineLayer.path = linePath.cgPath
            lineLayer.fillColor = UIColor.clear.cgColor
            lineLayer.strokeColor = UIColor.black.cgColor
            lineLayer.lineWidth = 10.0;
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 0.5
            lineLayer.add(animation, forKey: "MyAnimation")
            layerArray.insert(lineLayer,at:count)
            count+=1
            
            self.layer.addSublayer(lineLayer)
        }
        let alert = CustomAlertView(title: "Game Over", image: UIImage(named: "winner")!, winner:winner)
        alert.show(animated: true)

    }
    @IBAction func rematchClick(sender : UIButton)
    {
        if UserDefaults.standard.bool(forKey: "isPlaying")
        {
            winplayer.stop()
        }
        gamefinished = false
        controller.rematch.isHidden = true
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        for layer in self.layer.sublayers! {
            if(layerArray.contains(layer)){
                layer.removeFromSuperlayer()
            }
        }
        if activeplayer == 1
        {
            controller.chanceLabel.text = controller.name1 + "'s Turn : X"
        }
        else
        {
            controller.chanceLabel.text = controller.name2 + "'s Turn : O"
            if controller.player == 1
            {
                computerPlay()
            }
        }
        
        count = 0
    }
}

