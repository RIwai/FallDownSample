//
//  ViewController.swift
//  FallDownLogoSample
//
//  Created by Ryota Iwai on 2016/02/10.
//  Copyright © 2016年 Ryota Iwai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var baseView: UIView!

    private var animator: UIDynamicAnimator?
    private let gravityBehavior = UIGravityBehavior(items: [])
    private let collisionBehavior = UICollisionBehavior(items: [])
    private let propertiesBehavior = UIDynamicItemBehavior(items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.animator = UIDynamicAnimator(referenceView: self.baseView)
        self.collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        self.propertiesBehavior.elasticity = 0.9
        
        self.animator?.addBehavior(self.gravityBehavior)
        self.animator?.addBehavior(self.collisionBehavior)
        self.animator?.addBehavior(self.propertiesBehavior)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func addLogo() {
        let logoImage = UIImageView(image: UIImage(named: "logo"))
        
        logoImage.backgroundColor = UIColor.clearColor()
        logoImage.contentMode = .ScaleAspectFill
        
        let screenSize = UIScreen.mainScreen().bounds.size
        var imageSize = logoImage.image?.size ?? CGSize(width: 300, height: 200)
        let scaleArray: [CGFloat] = [0.2,0.5,0.2,0.6,0.3,1]
        let scale: CGFloat = scaleArray[Int(arc4random_uniform(UInt32(scaleArray.count)))]
        imageSize.width = imageSize.width * scale
        imageSize.height = imageSize.height * scale
        let xPointMax = screenSize.width - imageSize.width
        let randX = arc4random_uniform(UInt32(xPointMax))
        let imageViewPoint = CGPoint(x: CGFloat(randX), y: 0)
        logoImage.frame = CGRect(origin: imageViewPoint, size: imageSize)
        
        logoImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapLogo:"))
        logoImage.userInteractionEnabled = true
        
        self.baseView.addSubview(logoImage)

        // Add animation
        self.gravityBehavior.addItem(logoImage)
        self.collisionBehavior.addItem(logoImage)
        self.propertiesBehavior.addItem(logoImage)
    }
    
    @IBAction func tapAddButton(sender: AnyObject) {
        self.addLogo()
    }
    
    func tapLogo(tapGesture: UITapGestureRecognizer) {
        guard let tappedView = tapGesture.view else {
            return
        }
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            tappedView.alpha = 0.0
            }) { (finish) -> Void in
                self.gravityBehavior.removeItem(tappedView)
                self.collisionBehavior.removeItem(tappedView)
                self.propertiesBehavior.removeItem(tappedView)
                
                tappedView.removeFromSuperview()
        }
    }
}

