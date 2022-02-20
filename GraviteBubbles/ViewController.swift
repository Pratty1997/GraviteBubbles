//
//  ViewController.swift
//  GraviteBubbles
//
//  Created by Prateek Bedi on 20/02/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var gameView: UIView!
    
    struct Constants {
        static let bubbleSize = CGSize.init(width: 28, height: 28)
    }
    
    private var gravity = UIGravityBehavior()
    private var collider = UICollisionBehavior()
    private var animator: UIDynamicAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.animator = UIDynamicAnimator(referenceView: self.gameView)
        self.animator?.addBehavior(self.gravity)
        self.collider.translatesReferenceBoundsIntoBoundary = true
        
        self.animator?.addBehavior(self.collider)
    }
    

    private func dropBubble () {
        var frame = CGRect()
        frame.origin = CGPoint.zero
        frame.size = Constants.bubbleSize
        
        let x = gameView.bounds.width * CGFloat.random(in: 0..<1)
        frame.origin.x = x
        
        let bubbleView = EllipseView(frame: frame)
        bubbleView.backgroundColor = .randomColor
        gameView.addSubview(bubbleView)
        
        collider.addItem(bubbleView)
        gravity.addItem(bubbleView)
    }
    
    // This is the the file modification to test the commit.
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        print("Tapped!")
        dropBubble()
    }
}

class EllipseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        layer.cornerRadius = frame.size.width / 2.0
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder:) not implemented")
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}

extension UIColor {
    static var randomColor: UIColor {
        let randomHue = CGFloat.random(in: 0..<1)
        return UIColor(hue: randomHue, saturation: 1.0, brightness: 1.0, alpha: 0.5)
    }
}

