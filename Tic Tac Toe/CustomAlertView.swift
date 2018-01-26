//
//  CustomAlertView.swift
//  Tic Tac Toe
//
//  Created by Aashana on 11/2/17.
//  Copyright © 2017 Aashana. All rights reserved.
//

import UIKit

class CustomAlertView: UIView, Modal {

    var backgroundView = UIView()
    var dialogView = UIView()
    
    convenience init(title:String, image:UIImage, winner:String) {
        self.init(frame: UIScreen.main.bounds)
        setView(title:title, image:image, winner:winner)
    }
    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setView(title:String, image:UIImage, winner :String)
    {
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        addSubview(backgroundView)
        let dialogViewWidth = frame.width-60
        
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 8, width: dialogViewWidth-16, height: 30))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "American Typewriter", size: 25)
        dialogView.addSubview(titleLabel)
        let separatorLineView = UIView()
        separatorLineView.frame.origin = CGPoint(x: 0, y: titleLabel.frame.height + 8)
        separatorLineView.frame.size = CGSize(width: dialogViewWidth, height: 1)
        separatorLineView.backgroundColor = UIColor.groupTableViewBackground
        dialogView.addSubview(separatorLineView)
        let imageView = UIImageView()
        imageView.frame.origin = CGPoint(x: 40, y: separatorLineView.frame.height + separatorLineView.frame.origin.y + 8)
        imageView.frame.size = CGSize(width: dialogViewWidth - 80 , height: UIScreen.main.bounds.size.height/3 - 150)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        dialogView.addSubview(imageView)
        let winnerLabel = UILabel(frame: CGRect(x: 8, y: imageView.frame.origin.y + imageView.frame.height + 10, width: dialogViewWidth-16, height: 55))
        winnerLabel.text = winner + " has Won!!"
        winnerLabel.textAlignment = .center
        winnerLabel.numberOfLines = 2
        winnerLabel.font = UIFont(name: "American Typewriter", size: 20)
        winnerLabel.textColor = .purple
        dialogView.addSubview(winnerLabel)
        let dialogViewHeight = titleLabel.frame.height + 10 + separatorLineView.frame.height + 10 + imageView.frame.height + 10 + winnerLabel.frame.height + 10
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width-60, height: dialogViewHeight)
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        dialogView.clipsToBounds = true
        addSubview(dialogView)
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dialogView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
    }
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
}
