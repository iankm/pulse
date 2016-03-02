//
//  ViewController.swift
//  Pulse
//
//  Created by Ian Kumar Mukherjee on 2/29/16.
//  Copyright © 2016 Ian Kumar Mukherjee. All rights reserved.
//

import UIKit

class DailyQViewController: UIViewController {
    
    @IBOutlet weak var QLabel: UILabel!
    @IBOutlet weak var TextBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QLabel.text = "Hello, It's Me."
        TextBox.text = "Type here."
        TextBox.textColor = UIColor.lightGrayColor()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type Here."
            textView.textColor = UIColor.lightGrayColor()
        }
    }

}

