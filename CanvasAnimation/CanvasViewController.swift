//
//  CanvasViewController.swift
//  Canvas
//
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var newFaceOriginalCenter: CGPoint!
    var trayUpPositionCenter: CGPoint!
    var trayDownPositionCenter: CGPoint!
    var newlyCreatedFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayUpPositionCenter = trayView.center
        trayDownPositionCenter = CGPoint(
            x:trayUpPositionCenter.x,
            y: trayUpPositionCenter.y + 170)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Began:
            trayOriginalCenter = trayView.center
        case .Changed:
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + gesture.translationInView(self.view).y)
        case .Ended, .Cancelled:
            var velocity = gesture.velocityInView(self.view)
            let animation: (() -> ())!
            if velocity.y > 0 {
                animation = {self.trayView.center = self.trayDownPositionCenter}
                self.view.layoutIfNeeded()
            } else {
                animation = {self.trayView.center = self.trayUpPositionCenter}
                self.view.layoutIfNeeded()
            }
            UIView.animateWithDuration(
                0.35,
                animations: animation)
        default:
            return
        }
    }
    @IBAction func onFace(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began:
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newFaceOriginalCenter = newlyCreatedFace.center
        case .Changed:
            let translation = sender.translationInView(view)
            newlyCreatedFace.center = CGPoint(
                x: newFaceOriginalCenter.x + translation.x,
                y: newFaceOriginalCenter.y + translation.y)
        default:
            return
        }
    }

}









