//
//  ViewController.swift
//  
//
//  Created by Ian Kumar Mukherjee on 10/22/16.
//
//

import Foundation
import Koloda

class ViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainColor = pulseOrange
        let sdryColor = lighterOrange
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [sdryColor.CGColor, mainColor.CGColor]
        let gradientLocations: [Float] = [0.0,0.66]
        gradientLayer.locations = gradientLocations
        kolodaView.layer.insertSublayer(gradientLayer, atIndex: 0)
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    // Change Data Source to Pulse Feed Posts
    private var dataSource: Array<UIImage> = {
        var array: Array<UIImage> = []
        return array
    }()
    
}

extension ViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        dataSource.insert(UIImage(named: "Suck A Dick")!, atIndex: kolodaView.currentCardIndex - 1)
        let position = kolodaView.currentCardIndex
        kolodaView.insertCardAtIndexRange(position...position, animated: true)
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
}

extension ViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        return UInt(dataSource.count)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        return UIImageView(image: dataSource[Int(index)])
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("OverlayView",
                                                  owner: self, options: nil)[0] as? OverlayView
    }
}