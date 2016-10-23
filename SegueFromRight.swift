//
//  SegueFromRight.swift
//  Pulse
//
//  Created by Ian Kumar Mukherjee on 10/22/16.
//  Copyright © 2016 Ian Kumar Mukherjee. All rights reserved.
//

import UIKit
import QuartzCore

class SegueFromRight: UIStoryboardSegue {
    override func perform() {
        let src: UIViewController = self.sourceViewController
        let dst: UIViewController = self.destinationViewController
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.25
        transition.timingFunction = timeFunc
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        src.view.layer.addAnimation(transition, forKey: kCATransition)
        src.presentViewController(dst, animated: true, completion: nil)
    }
}